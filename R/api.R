#' Set the API key value.
#'
#' A helper function to set the OPENAQ_API_KEY environment variable.
#'
#' @param api_key A string value for the API key to set.
#'
#' @export
#'
#' @examples
#' set_api_key("my-super-secret-openaq-api-key-1234")
#'
set_api_key <- function(api_key) {
  Sys.setenv("OPENAQ_API_KEY" = api_key)
}

#' Gets the current API Key value.
#'
#' Gets an API key value from the system envionment variable OPENAQ_API_KEY.
#' If run in RSTUDIO, function prompts for user inputs to enter the key.
#'
#' @return A string.
#'
#' @examples
#' api_key <- get_api_key()
#' @noRd
get_api_key <- function() {
  key <- Sys.getenv("OPENAQ_API_KEY")
  if (key == "" && Sys.getenv("RSTUDIO") == "1") {
    key <- rstudioapi::askForSecret(
      name = "OpenAQ API",
      message = "Enter your API Key",
      title = "Enter your API Key"
    )
  }
  key
}

#' Sets base URL environment variable
#'
#' A helper function to set the OPENAQR_BASE_URL environment variable. This is
#' to override the default URL for testing and custom instance of the API. This
#' function is generally not used by most users except in extraordinary cases.
#'
#' @param base_url A string.
#'
#' @export
#'
#' @examples
#' set_base_url("https://example.com")
#'
set_base_url <- function(base_url) {
  Sys.setenv("OPENAQR_BASE_URL" = base_url)
}


#' Gets the base URL value.
#'
#' A helper function for getting the OPENAQR_BASE_URL environment variable. If
#' OPENAQR_BASE_URL is not set it defaults to https://api.openaq.org.
#'
#' @return A string value of the base URL for the API.
#'
#' @examples
#' base_url <- get_base_url()
#'
#' @noRd
get_base_url <- function() {
  url <- Sys.getenv("OPENAQR_BASE_URL", "https://api.openaq.org")
  url
}

#' Checks that API Key is set
#'
#' Function to check that when the base URL is the OpenAQ hosted API
#' (https://api.openaq.orgt) that an API Key is set. This prevents
#' unauthenticated requests from the package.
#'
#' @param base_url A string representing the base URL used for requests.
#' @param api_key A string for the API key.
#' @noRd
check_api_key <- function(base_url, api_key) {
  if (base_url == "https://api.openaq.org" && api_key == "") {
    stop("A valid API key is required when using the OpenAQ API.")
  }
}


#' Toggles on the RATE_LIMIT environment variable to TRUE.
#'
#' @export
#'
enable_rate_limit <- function() {
  Sys.setenv("RATE_LIMIT" = TRUE)
}

#' Gets the RATE_LIMIT value
#'
#' @return A logical value.
#' @noRd
get_rate_limit <- function() {
  rate_limit <- Sys.getenv("RATE_LIMIT", FALSE)
  as.logical(rate_limit)
}


#' Creates httr2 request from path and query parameters.
#'
#' @param path A string.
#' @param query_params A list.
#' @param api_key A string.
#'
#' @return A httr2 request object.
#' @noRd
openaq_request <- function(path, query_params, api_key = NULL) {
  if (is.null(api_key)) {
    api_key <- get_api_key()
  }
  base_url <- get_base_url()

  check_api_key(base_url, api_key)

  resource_path <- paste("/v3", path, sep = "/")

  current_version <- packageVersion(packageName())
  r_version <- paste0(R.Version()[c("major","minor")], collapse = ".")

  req <- httr2::request(base_url)
  req <- httr2::req_url_path(req, resource_path)
  req <- httr2::req_url_query(req, !!!query_params, .multi = "comma")
  req <- httr2::req_headers(req,
    `X-API-Key` = api_key,
    `User-Agent` = sprintf("openaq-r-%s-%s", current_version, r_version),
    `Content-Type` = "application/json",
    Accept = "application/json",
    .redact = "X-API-Key"
  )
  req
}


#' Determines if a httr2 response status is transient.
#'
#' @param resp A httr2 response object.
#'
#' @return A logical representing whether the response is considered transient.
#' @noRd
req_is_transient <- function(resp) {
  httr2::resp_status(resp) == 429 &&
    identical(httr2::resp_header(resp, "X-RateLimit-Remaining"), "0")
}

#' Parses rate limit headers to determine when rate limit period resets
#'
#' @param resp 	A httr2 response object.
#'
#' @return An integer representing the X-RateLimit-Reset header for how many
#' seconds until the rate limit period resets.
#' @noRd
req_after <- function(resp) {
  seconds <- as.integer(httr2::resp_header(resp, "X-RateLimit-Reset"))
  seconds
}


#' Handles performing the HTTP request.
#'
#' @param resp 	An httr2 request object.
#'
#' @return An httr2 response object.
#' @noRd
handle_request <- function(req, dry_run, rate_limit) {
  if (dry_run) {
    httr2::req_dry_run(req)
  } else {
    rate_limit_env <- get_rate_limit()
    if (rate_limit_env || rate_limit) {
      req <- httr2::req_retry(req,
        is_transient = req_is_transient,
        after = req_after
      )
    }
    resp <- httr2::req_perform(req)
    resp
  }
}

#' fetch
#'
#' @param path A string of the URL path.
#' @param query_params A list of query parameters.
#' @param dry_run A logical for setting whether to do a dry run of the request,
#' defaults to FALSE.
#' @param rate_limit A logical for setting whether to automatically rate limit
#' based on rate limit headers, defaults to FALSE.
#' @param api_key A string of the API Key value to set in the request headers,
#' defaults to NULL.
#'
#' @return An httr2 response object.
#' @noRd
fetch <- function(
    path,
    query_params = list(),
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  req <- openaq_request(path, query_params, api_key)
  res <- handle_request(req, dry_run, rate_limit)
  if (!dry_run) {
    x <- httr2::resp_body_json(res, check_type = TRUE)
    results <- x$results
    x$meta[["retrieved_on"]] <- Sys.time()
    attr(results, "meta") <- x$meta
    attr(results, "params") <- query_params
    results <- add_headers(results, res)
    return(results)
  }
}

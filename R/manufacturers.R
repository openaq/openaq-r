#' Get a single manufacturer from the manufacturers resource.
#'
#' @param manufacturers_id An integer.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list defaults to TRUE.
#' @param dry_run A logical for toggling a dry run of the request, defaults to
#' FALSE.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, defaults to FALSE.
#' @param api_key A valid OpenAQ API key string, defaults to NULL.
#'
#' @return A data frame or a list of the results.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' manufacturer <- get_manufacturer(42)
#' }
#'
get_manufacturer <- function(
    manufacturers_id,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  path <- paste("manufacturers", manufacturers_id, sep = "/")
  data <- fetch(path,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_manufacturers_list(structure(
      data,
      class = c("openaq_manufacturers_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_manufacturers_list", "list")
    ))
  }
}

#' Get a list of manufacturers from the manufacturers resource.
#'
#' @param order_by A string.
#' @param sort_order A string.
#' @param limit An integer.
#' @param page An integer.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list defaults to TRUE.
#' @param dry_run A logical for toggling a dry run of the request, defaults to
#' FALSE.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, defaults to FALSE.
#' @param api_key A valid OpenAQ API key string, defaults to NULL.
#'
#' @return A data frame or a list of the results.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' manufacturers <- list_manufacturers()
#' }
#'
list_manufacturers <- function(
    order_by = NULL,
    sort_order = NULL,
    limit = NULL,
    page = NULL,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  param_defs <- list(
    order_by = list(default = NULL, validator = NULL),
    sort_order = list(default = NULL, validator = validate_sort_order),
    limit = list(default = 100, validator = validate_limit),
    page = list(default = 1, validator = validate_page)
  )

  params_list <- extract_parameters(param_defs,
    order_by = order_by,
    sort_order = sort_order,
    limit = limit,
    page = page
  )
  path <- "manufacturers"
  data <- fetch(path,
    query_params = params_list,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_manufacturers_list(structure(
      data,
      class = c("openaq_manufacturers_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_manufacturers_list", "list")
    ))
  }
}



#' Method for converting openaq_manufacturers_list to data frame.
#'
#' @param data A list of countries as returned from list_manufacturers.
#' @param ... Other options.

#'
#' @export as.data.frame.openaq_manufacturers_list
#' @export
#'
#' @examples
#' \dontrun{
#' instruments <- list_instruments()
#' openaq_instruments_list.as.data.frame(instruments)
#' }
as.data.frame.openaq_manufacturers_list <- function(data, ...) {
  tbl <- do.call(rbind, lapply(data, function(x) {
    data.frame(
      id = x$id,
      name = x$name,
      instruments_ids = paste(lapply(x$instruments, function(x) {
        x$id
      }), collapse = ",")
    )
  }))
  tbl$id <- as.numeric(tbl$id)

  attr(tbl, "meta") <- attr(data, "meta")
  return(structure(tbl,
    class = c("openaq_licenses_data.frame", "data.frame")
  ))
}

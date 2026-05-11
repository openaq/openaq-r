# Package-private cache --------------------------------------------------------

.pkg_cache <- new.env(parent = emptyenv())


internal_get_cache <- function() {

  return(.pkg_cache)

}


# Internal helpers -------------------------------------------------------------

internal_download_reference_table <- function(download_function) {

  tryCatch(
    download_function(limit = 1000),
    error = function(e) {
      stop(
        "Unable to download OpenAQ reference data. ",
        "Please check your internet connection and try again.\n",
        "Original error: ", conditionMessage(e),
        call. = FALSE
      )
    }
  )

}


internal_get_reference_table <- function(table_name, download_function) {

  cache <- internal_get_cache()

  if ( is.null(cache[[table_name]]) ) {
    cache[[table_name]] <- internal_download_reference_table(download_function)
  }

  return(cache[[table_name]])

}


# Download reference tables ----------------------------------------------------

#' Get OpenAQ country metadata
#'
#' Returns OpenAQ country metadata as a tibble. Data are downloaded only once
#' per R session and then cached for re-use.
#'
#' For more information about the OpenAQ API, see:
#' \url{https://docs.openaq.org/}
#'
#' @return A tibble of OpenAQ country metadata.
#' @export
get_countries <- function() {

  internal_get_reference_table("countries", list_countries)

}


#' Get OpenAQ instrument metadata
#'
#' Returns OpenAQ instrument metadata as a tibble. Data are downloaded only once
#' per R session and then cached for re-use.
#'
#' For more information about the OpenAQ API, see:
#' \url{https://docs.openaq.org/}
#'
#' @return A tibble of OpenAQ instrument metadata.
#' @export
get_instruments <- function() {

  internal_get_reference_table("instruments", list_instruments)

}


#' Get OpenAQ license metadata
#'
#' Returns OpenAQ license metadata as a tibble. Data are downloaded only once
#' per R session and then cached for re-use.
#'
#' For more information about the OpenAQ API, see:
#' \url{https://docs.openaq.org/}
#'
#' @return A tibble of OpenAQ license metadata.
#' @export
get_licenses <- function() {

  internal_get_reference_table("licenses", list_licenses)

}


#' Get OpenAQ manufacturer metadata
#'
#' Returns OpenAQ manufacturer metadata as a tibble. Data are downloaded only
#' once per R session and then cached for re-use.
#'
#' For more information about the OpenAQ API, see:
#' \url{https://docs.openaq.org/}
#'
#' @return A tibble of OpenAQ manufacturer metadata.
#' @export
get_manufacturers <- function() {

  internal_get_reference_table("manufacturers", list_manufacturers)

}


#' Get OpenAQ owner metadata
#'
#' Returns OpenAQ owner metadata as a tibble. Data are downloaded only once
#' per R session and then cached for re-use.
#'
#' For more information about the OpenAQ API, see:
#' \url{https://docs.openaq.org/}
#'
#' @return A tibble of OpenAQ owner metadata.
#' @export
get_owners <- function() {

  internal_get_reference_table("owners", list_owners)

}


#' Get OpenAQ parameter metadata
#'
#' Returns OpenAQ parameter metadata as a tibble. Data are downloaded only once
#' per R session and then cached for re-use.
#'
#' For more information about the OpenAQ API, see:
#' \url{https://docs.openaq.org/}
#'
#' @return A tibble of OpenAQ parameter metadata.
#' @export
get_parameters <- function() {

  internal_get_reference_table("parameters", list_parameters)

}


#' Get OpenAQ provider metadata
#'
#' Returns OpenAQ provider metadata as a tibble. Data are downloaded only once
#' per R session and then cached for re-use.
#'
#' For more information about the OpenAQ API, see:
#' \url{https://docs.openaq.org/}
#'
#' @return A tibble of OpenAQ provider metadata.
#' @export
get_providers <- function() {

  internal_get_reference_table("providers", list_providers)

}


# Reset cache ------------------------------------------------------------------

#' Reset cached OpenAQ reference tables
#'
#' Clears all OpenAQ reference tables cached during the current R session.
#'
#' @return Invisibly returns `NULL`.
#' @export
reset_reference_cache <- function() {

  cache <- internal_get_cache()

  cache$countries <- NULL
  cache$instruments <- NULL
  cache$licenses <- NULL
  cache$manufacturers <- NULL
  cache$owners <- NULL
  cache$parameters <- NULL
  cache$providers <- NULL

  invisible(NULL)

}


# Internal conversion helpers --------------------------------------------------

internal_validate_character_input <- function(x) {

  if ( is.null(x) ) {
    return(NULL)
  }

  if ( !is.character(x) ) {
    stop("`x` must be a character vector.", call. = FALSE)
  }

  invisible(TRUE)

}


internal_match_to_id <- function(
    x,
    reference_table,
    match_columns
) {

  validation_result <- internal_validate_character_input(x)

  if ( is.null(validation_result) ) {
    return(NULL)
  }

  x_upper <- toupper(x)

  result <- rep(NA_integer_, length(x))

  for ( match_column in match_columns ) {

    remaining <- is.na(result)

    if ( !any(remaining) ) {
      break
    }

    lookup_upper <- toupper(reference_table[[match_column]])

    matched_index <- match(
      x_upper[remaining],
      lookup_upper
    )

    matched <- !is.na(matched_index)

    if ( any(matched) ) {

      remaining_index <- which(remaining)

      result[remaining_index[matched]] <-
        reference_table$id[matched_index[matched]]

    }

  }

  return(as.integer(result))

}


# Convert names/codes to IDs ---------------------------------------------------

#' Convert country codes or names to OpenAQ country IDs
#'
#' Matching is case-insensitive. Values are matched first against `code`, then
#' against `name`. If no match is found, `NA` is returned.
#'
#' @param x Character vector of country codes or names.
#'
#' @return Integer vector of OpenAQ country IDs.
#'
#' @examples
#' \dontrun{
#' country_to_id(c("US", "Canada", "France", "Unknown"))
#' }
#'
#' @export
country_to_id <- function(x) {

  countries <- get_countries()

  internal_match_to_id(
    x = x,
    reference_table = countries,
    match_columns = c("code", "name")
  )

}


#' Convert instrument names to OpenAQ instrument IDs
#'
#' Matching is case-insensitive. If no match is found, `NA` is returned.
#'
#' @param x Character vector of instrument names.
#'
#' @return Integer vector of OpenAQ instrument IDs.
#'
#' @examples
#' \dontrun{
#' instrument_to_id(c("BAM 1020", "PurpleAir PA-II", "Unknown"))
#' }
#'
#' @export
instrument_to_id <- function(x) {

  instruments <- get_instruments()

  internal_match_to_id(
    x = x,
    reference_table = instruments,
    match_columns = "name"
  )

}


#' Convert license names to OpenAQ license IDs
#'
#' Matching is case-insensitive. If no match is found, `NA` is returned.
#'
#' @param x Character vector of license names.
#'
#' @return Integer vector of OpenAQ license IDs.
#'
#' @examples
#' \dontrun{
#' license_to_id(c("CC BY 4.0", "Public Domain", "Unknown"))
#' }
#'
#' @export
license_to_id <- function(x) {

  licenses <- get_licenses()

  internal_match_to_id(
    x = x,
    reference_table = licenses,
    match_columns = "name"
  )

}


#' Convert manufacturer names to OpenAQ manufacturer IDs
#'
#' Matching is case-insensitive. If no match is found, `NA` is returned.
#'
#' @param x Character vector of manufacturer names.
#'
#' @return Integer vector of OpenAQ manufacturer IDs.
#'
#' @examples
#' \dontrun{
#' manufacturer_to_id(
#'   c("Met One Instruments", "Thermo Fisher Scientific", "Unknown")
#' )
#' }
#'
#' @export
manufacturer_to_id <- function(x) {

  manufacturers <- get_manufacturers()

  internal_match_to_id(
    x = x,
    reference_table = manufacturers,
    match_columns = "name"
  )

}


#' Convert owner names to OpenAQ owner IDs
#'
#' Matching is case-insensitive. If no match is found, `NA` is returned.
#'
#' @param x Character vector of owner names.
#'
#' @return Integer vector of OpenAQ owner IDs.
#'
#' @examples
#' \dontrun{
#' owner_to_id(
#'   c("Environmental Defense Fund", "Carnegie Mellon University")
#' )
#' }
#'
#' @export
owner_to_id <- function(x) {

  owners <- get_owners()

  internal_match_to_id(
    x = x,
    reference_table = owners,
    match_columns = "name"
  )

}


#' Convert parameter names to OpenAQ parameter IDs
#'
#' Matching is case-insensitive. Values are matched first against `name`, then
#' against `displayName`. If no match is found, `NA` is returned.
#'
#' @param x Character vector of parameter names.
#'
#' @return Integer vector of OpenAQ parameter IDs.
#'
#' @examples
#' \dontrun{
#' parameter_to_id(c("pm25", "PM2.5", "Ozone", "Unknown"))
#' }
#'
#' @export
parameter_to_id <- function(x) {

  parameters <- get_parameters()

  internal_match_to_id(
    x = x,
    reference_table = parameters,
    match_columns = c("name", "displayName")
  )

}


#' Convert provider names to OpenAQ provider IDs
#'
#' Matching is case-insensitive. Values are matched first against `name`, then
#' against `export_prefix`. If no match is found, `NA` is returned.
#'
#' @param x Character vector of provider names or export prefixes.
#'
#' @return Integer vector of OpenAQ provider IDs.
#'
#' @examples
#' \dontrun{
#' provider_to_id(c("Clarity", "airnow", "Unknown"))
#' }
#'
#' @export
provider_to_id <- function(x) {

  providers <- get_providers()

  internal_match_to_id(
    x = x,
    reference_table = providers,
    match_columns = c("name", "export_prefix")
  )

}

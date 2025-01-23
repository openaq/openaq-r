#' get a single license from the licenses resource.
#'
#' @param licenses_id An integer.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list defaults to TRUE.
#' @param dry_run A logical for toggling a dry run of the request, defaults to
#' FALSE.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, defaults to FALSE.
#' @param api_key A valid OpenAQ API key string, defaults to NULL.
#'
#' @return A data frame.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' license <- get_license(42)
#' }
#'
get_license <- function(
    licenses_id,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  path <- paste("licenses", licenses_id, sep = "/")
  data <- fetch(path,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (as_data_frame == TRUE) {
    invisible(as.data.frame.openaq_licenses_list(structure(
      data,
      class = c("openaq_licenses_list", "list")
    )))
  } else {
    invisible(structure(
      data,
      class = c("openaq_licenses_list", "list")
    ))
  }
}


#' get a list of licenses from the licenses resource.
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
#' @return A data frame.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' licenses <- list_licenses()
#' }
#'
list_licenses <- function(
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
  path <- "licenses"
  data <- fetch(path, params_list,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_licenses_list(structure(
      data,
      class = c("openaq_licenses_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_licenses_list", "list")
    ))
  }
}

#' Method for converting openaq_instruments_list to data frame.
#'
#' @param data A list of countries as returned from list_instruments
#'
#' @export as.data.frame.openaq_licenses_list
#' @export
#'
#' @examples
#' \dontrun{
#' instruments <- list_instruments()
#' openaq_instruments_list.as.data.frame(instruments)
#' }
as.data.frame.openaq_licenses_list <- function(data, ...) {
  tbl <- do.call(rbind, lapply(data, function(x) {
    data.frame(
      id = x$id,
      name = x$name,
      commercial_use_allowed = x$commercialUseAllowed,
      attribution_required = x$attributionRequired,
      share_alike_required = x$shareAlikeRequired,
      modification_allowed = x$modificationAllowed,
      redistribution_allowed = x$redistributionAllowed,
      source_url = x$sourceUrl
    )
  }))
  tbl$id <- as.numeric(tbl$id)
  tbl$commercial_use_allowed <- as.logical(tbl$commercial_use_allowed)
  tbl$attribution_required <- as.logical(tbl$attribution_required)
  tbl$share_alike_required <- as.logical(tbl$share_alike_required)
  tbl$modification_allowed <- as.logical(tbl$modification_allowed)
  tbl$redistribution_allowed <- as.logical(tbl$redistribution_allowed)
  attr(tbl, "meta") <- attr(data, "meta")
  return(structure(tbl,
    class = c("openaq_licenses_data.frame", "data.frame")
  ))
}

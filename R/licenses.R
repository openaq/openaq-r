#' get a single license from the licenses resource.
#'
#' @param licenses_id An integer.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list default is `TRUE`.
#' @param dry_run A logical for toggling a dry run of the request, defaults to
#' `FALSE`.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, default is `FALSE`.
#' @param api_key A valid OpenAQ API key string, default is `NULL`.
#'
#' @return A data frame.
#'
#' @export
#'
#' @examplesIf interactive()
#' license <- get_license(42)
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
  if (isTRUE(dry_run)) {
    return(data)
  }
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
#' data frame or list default is `TRUE`.
#' @param dry_run A logical for toggling a dry run of the request, defaults to
#' `FALSE`.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, default is `FALSE`.
#' @param api_key A valid OpenAQ API key string, default is `NULL`.
#'
#' @return A data frame.
#'
#' @export
#'
#' @examplesIf interactive()
#' licenses <- list_licenses()
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
  if (isTRUE(dry_run)) {
    return(data)
  }
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
#' @param x A list of countries as returned from list_instruments.
#' @param row.names `NULL` or a character vector giving the row names for the
#' data frame. Missing values are not allowed.
#' @param optional logical. If TRUE, setting row names and converting column
#' names (to syntactic names: see make.names) is optional. Note that all of R's
#' base package as.data.frame() methods use optional only for column names
#' treatment, basically with the meaning of data.frame(*, check.names =
#' !optional). See also the make.names argument of the matrix method.
#' @param ... additional arguments to be passed to or from methods.
#'
#' @export as.data.frame.openaq_licenses_list
#' @export
#'
#' @examplesIf interactive()
#' instruments <- list_instruments()
#' openaq_instruments_list.as.data.frame(instruments)
#'
as.data.frame.openaq_licenses_list <- function(x, row.names = NULL, optional = FALSE, ...) {
  tbl <- do.call(rbind, lapply(x, function(rw) {
    data.frame(
      id = rw$id,
      name = rw$name,
      commercial_use_allowed = rw$commercialUseAllowed,
      attribution_required = rw$attributionRequired,
      share_alike_required = rw$shareAlikeRequired,
      modification_allowed = rw$modificationAllowed,
      redistribution_allowed = rw$redistributionAllowed,
      source_url = rw$sourceUrl
    )
  }))
  tbl$id <- as.numeric(tbl$id)
  tbl$commercial_use_allowed <- as.logical(tbl$commercial_use_allowed)
  tbl$attribution_required <- as.logical(tbl$attribution_required)
  tbl$share_alike_required <- as.logical(tbl$share_alike_required)
  tbl$modification_allowed <- as.logical(tbl$modification_allowed)
  tbl$redistribution_allowed <- as.logical(tbl$redistribution_allowed)
  attr(tbl, "meta") <- attr(x, "meta")
  structure(tbl,
    class = c("openaq_licenses_data.frame", "data.frame")
  )
}

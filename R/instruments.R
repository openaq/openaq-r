#' Get a single instrument from the instruments resource.
#'
#' @param instruments_id An integer representing the OpenAQ instruments_id.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list, default is `TRUE`.
#' @param dry_run A logical for toggling a dry run of the request, default is
#' `FALSE`.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, default is `FALSE`.
#' @param api_key A valid OpenAQ API key string, default is `NULL`.
#'
#' @return A data frame or a list of the results.
#'
#' @export
#'
#' @examplesIf interactive()
#' instrument <- get_instrument(42)
#'
get_instrument <- function(
    instruments_id,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  path <- paste("instruments", instruments_id, sep = "/")
  data <- fetch(path,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (isTRUE(as_data_frame)) {
    as.data.frame.openaq_instruments_list(structure(
      data,
      class = c("openaq_instruments_list", "list")
    ))
  } else {
    structure(
      data,
      class = c("openaq_instruments_list", "list")
    )
  }
}

#' Get a list of instruments from the instruments resource.
#'
#' @param order_by A string specifying the field to order results by.
#' @param sort_order A string specifying sort direction, either `"asc"` or `"desc"`.
#' @param limit An integer specifying the maximum number of results to return, default is `100`.
#' @param page An integer specifying the page number for paginated results, default is `1`.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list, default is `TRUE`.
#' @param dry_run A logical for toggling a dry run of the request, default is
#' `FALSE`.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, default is `FALSE`.
#' @param api_key A valid OpenAQ API key string, default is `NULL`.
#'
#' @return A data frame or a list of the results.
#'
#' @export
#'
#' @examplesIf interactive()
#' instruments <- list_instruments()
#'
list_instruments <- function(
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
  path <- "instruments"
  data <- fetch(path,
    query_params = params_list,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (isTRUE(as_data_frame)) {
    as.data.frame.openaq_instruments_list(structure(
      data,
      class = c("openaq_instruments_list", "list")
    ))
  } else {
    structure(
      data,
      class = c("openaq_instruments_list", "list")
    )
  }
}

#' Get a list of manufacturer instruments from the instruments resource.
#'
#' @param manufacturers_id An integer representing the OpenAQ manufacturers_id.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list, default is `TRUE`.
#' @param dry_run A logical for toggling a dry run of the request, default is
#' `FALSE`.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, default is `FALSE`.
#' @param api_key A valid OpenAQ API key string, default is `NULL`.
#'
#' @return A data frame or a list of the results.
#'
#' @export
#'
#' @examplesIf interactive()
#' instruments <- list_manufacturer_instruments(42)
#'
list_manufacturer_instruments <- function(
    manufacturers_id,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  path <- paste("manufacturers", manufacturers_id, "instruments", sep = "/")
  data <- fetch(path,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (isTRUE(as_data_frame)) {
    as.data.frame.openaq_instruments_list(structure(
      data,
      class = c("openaq_instruments_list", "list")
    ))
  } else {
    structure(
      data,
      class = c("openaq_instruments_list", "list")
    )
  }
}


#' Method for converting openaq_instruments_list to data frame.
#'
#' @param x A list of instruments as returned from list_instruments.
#' @param row.names `NULL` or a character vector giving the row names for the
#' data frame. Missing values are not allowed.
#' @param optional logical. If TRUE, setting row names and converting column
#' names (to syntactic names: see make.names) is optional. Note that all of R's
#' base package as.data.frame() methods use optional only for column names
#' treatment, basically with the meaning of data.frame(*, check.names =
#' !optional). See also the make.names argument of the matrix method.
#' @param ... additional arguments to be passed to or from methods.
#'
#' @export as.data.frame.openaq_instruments_list
#' @export
#'
#' @examplesIf interactive()
#' instruments <- list_instruments(as_data_frame = FALSE)
#' as.data.frame(instruments)
#'
as.data.frame.openaq_instruments_list <- function(x, row.names = NULL, optional = FALSE, ...) { # nolint: object_name_linter
  tbl <- do.call(rbind, lapply(x, function(rw) {
    data.frame(
      id = rw$id,
      name = rw$name,
      is_monitor = rw$isMonitor,
      manufacturer_id = rw$manufacturer$id,
      manufacturer_name = rw$manufacturer$name
    )
  }))
  tbl$id <- as.numeric(tbl$id)
  tbl$is_monitor <- as.logical(tbl$is_monitor)
  tbl$manufacturer_id <- as.numeric(tbl$manufacturer_id)
  tbl$manufacturer_name <- as.factor(tbl$manufacturer_name)
  attr(tbl, "meta") <- attr(x, "meta")
  structure(tbl,
    class = c("openaq_instruments_data.frame", "data.frame")
  )
}

#' Get a single country from countries resource.
#'
#' @param countries_id An integer representing the OpenAQ countries_id.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list default is `TRUE`.
#' @param dry_run A logical for toggling a dry run of the request, defaults is
#' `FALSE.`
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, default is `FALSE`.
#' @param api_key A valid OpenAQ API key string, default is `NULL`.
#'
#' @return A data frame or list of the results.
#'
#' @export
#'
#' @examplesIf interactive()
#' country <- get_country(42)
#'
get_country <- function(
    countries_id,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  path <- paste("countries", countries_id, sep = "/")
  data <- fetch(path,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (isTRUE(as_data_frame)) {
    return(as.data.frame.openaq_countries_list(structure(
      data,
      class = c("openaq_countries_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_countries_list", "list")
    ))
  }
}


#' Get a list of countries from the countries resource.
#'
#' @param providers_id A numeric vector of length 1 or more, containing the
#' ID(s) of the providers to use for filtering results. If multiple IDs are
#' provided, results matching any of the IDs will be returned.
#' @param parameters_id A numeric vector of length 1 or more, containing the
#' ID(s) of the parameters to use for filtering results. If multiple IDs are
#' provided, results matching any of the IDs will be returned.
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
#' @return A data frame or a list of the results.
#'
#' @export
#'
#' @examplesIf interactive()
#' countries <- list_countries()
#'
list_countries <- function(
    providers_id = NULL,
    parameters_id = NULL,
    order_by = NULL,
    sort_order = NULL,
    limit = NULL,
    page = NULL,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  param_defs <- list(
    providers_id = list(default = NULL, validator = NULL),
    parameters_id = list(default = NULL, validator = NULL),
    order_by = list(default = NULL, validator = NULL),
    sort_order = list(default = NULL, validator = validate_sort_order),
    limit = list(default = 100, validator = validate_limit),
    page = list(default = 1, validator = validate_page)
  )

  params_list <- extract_parameters(param_defs,
    providers_id = providers_id,
    parameters_id = parameters_id,
    order_by = order_by,
    sort_order = sort_order,
    limit = limit,
    page = page
  )
  path <- "countries"
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
    return(as.data.frame.openaq_countries_list(structure(
      data,
      class = c("openaq_countries_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_countries_list", "list")
    ))
  }
}

#' Method for converting openaq_countries_list to data frame.
#'
#' @param x A list of countries as returned from list_countries
#' @param row.names `NULL` or a character vector giving the row names for the
#' data frame. Missing values are not allowed.
#' @param optional logical. If TRUE, setting row names and converting column
#' names (to syntactic names: see make.names) is optional. Note that all of R's
#' base package as.data.frame() methods use optional only for column names
#' treatment, basically with the meaning of data.frame(*, check.names =
#' !optional). See also the make.names argument of the matrix method.
#' @param ... additional arguments to be passed to or from methods.
#'
#' @export as.data.frame.openaq_countries_list
#' @export
#'
#' @examplesIf interactive()
#' countries <- list_countries()
#' openaq_countries_list.as.data.frame(countries)
#'
as.data.frame.openaq_countries_list <- function(x, row.names = NULL, optional = FALSE, ...) {
  tbl <- do.call(rbind, lapply(x, function(rw) {
    data.frame(
      id = rw$id,
      code = rw$code,
      datetime_first = parse_openaq_timestamp(rw$datetimeFirst),
      datetime_last = parse_openaq_timestamp(rw$datetimeLast),
      parameter_ids = paste(lapply(rw$parameters, function(x) {
        rw$id
      }), collapse = ","),
      parameter_names = paste(lapply(rw$parameters, function(x) {
        paste(rw$name, rw$units, collapse = " ")
      }), collapse = ",")
    )
  }))
  tbl$id <- as.numeric(tbl$id)
  attr(tbl, "meta") <- attr(x, "meta")
  structure(tbl,
    class = c("openaq_countries_data.frame", "data.frame")
  )
}

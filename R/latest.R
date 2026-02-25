#' Get the latest measurements by locations_id.
#'
#' @param locations_id An integer.
#' @param datetime_min A string.
#' @param limit An integer.
#' @param page An integer.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list default is `TRUE`.
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
#' measurements <- list_location_latest(2178)
#'
list_location_latest <- function(
    locations_id,
    datetime_min = NULL,
    limit = NULL,
    page = NULL,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  param_defs <- list(
    datetime_min = list(
      default = NULL,
      validator = validate_datetime,
      transform = transform_datetime
    ),
    limit = list(default = NULL, validator = validate_limit),
    page = list(default = NULL, validator = validate_page)
  )

  params_list <- extract_parameters(param_defs,
    datetime_min = datetime_min,
    limit = limit,
    page = page
  )
  path <- paste("locations", locations_id, "latest", sep = "/")
  data <- fetch(path, params_list, dry_run = dry_run)
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (as_data_frame == TRUE) {
    as.data.frame.openaq_latest_list(structure(
      data,
      class = c("openaq_latest_list", "list")
    ))
  } else {
    structure(
      data,
      class = c("openaq_latest_list", "list")
    )
  }
}

#' Get the latest measurements by parameters_id.
#'
#' @param parameters_id An integer.
#' @param datetime_min A string.
#' @param limit An integer.
#' @param page An integer.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list default is `TRUE`.
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
#' measurements <- list_parameter_latest(2)
#'
list_parameter_latest <- function(
    parameters_id,
    datetime_min = NULL,
    limit = NULL,
    page = NULL,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  param_defs <- list(
    datetime_min = list(
      default = NULL,
      validator = validate_datetime,
      transform = transform_datetime
    ), limit = list(default = 100, validator = validate_limit),
    page = list(default = 1, validator = validate_page)
  )

  params_list <- extract_parameters(param_defs,
    datetime_min = datetime_min,
    limit = limit,
    page = page
  )
  path <- paste("parameters", parameters_id, "latest", sep = "/")
  data <- fetch(path, params_list)
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (isTRUE(as_data_frame)) {
    as.data.frame.openaq_latest_list(structure(
      data,
      class = c("openaq_latest_list", "list")
    ))
  } else {
    structure(
      data,
      class = c("openaq_latest_list", "list")
    )
  }
}


#' Method for converting openaq_latest_list to data frame.
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
#' @export as.data.frame.openaq_latest_list
#' @export
#'
#' @examplesIf interactive()
#' instruments <- list_instruments(as_data_frame = FALSE)
#' openaq_latest_list.as.data.frame(instruments)
#'
as.data.frame.openaq_latest_list <- function(x, row.names = NULL, optional = FALSE, ...) { # nolint: object_name_linter
  tbl <- do.call(rbind, lapply(x, function(rw) {
    data.frame(
      sensors_id = rw$sensorsId,
      locations_id = rw$locationsId,
      value = rw$value,
      datetime_local = parse_openaq_timestamp(deep_get(rw, "datetime", "local", default = NULL)),
      datetime_utc = parse_openaq_timestamp(deep_get(rw, "datetime", "utc", default = NULL)),
      latitude = deep_get(rw, "coordinates", "latitude"),
      longitude = deep_get(rw, "coordinates", "longitude")
    )
  }))
  tbl$sensors_id <- as.numeric(tbl$sensors_id)
  tbl$locations_id <- as.numeric(tbl$locations_id)
  tbl$value <- as.numeric(tbl$value)
  tbl$latitude <- as.numeric(tbl$latitude)
  tbl$longitude <- as.numeric(tbl$longitude)
  attr(tbl, "meta") <- attr(x, "meta")
  structure(tbl,
    class = c("openaq_latest_data.frame", "data.frame")
  )
}

#' Get a single sensor from sensors resource.
#'
#' @param sensors_id An integer.
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
#' sensor <- get_sensor(42)
#'
get_sensor <- function(
    sensors_id,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  path <- paste("sensors", sensors_id, sep = "/")
  data <- fetch(path,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_sensors_list(structure(
      data,
      class = c("openaq_sensors_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_sensors_list", "list")
    ))
  }
}

#' Get a location's sensors.
#'
#' @param locations_id An integer.
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
#' sensors <- get_location_sensors(42)
#'
get_location_sensors <- function(
    locations_id,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  path <- paste("locations", locations_id, "sensors", sep = "/")
  data <- fetch(path,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_sensors_list(structure(
      data,
      class = c("openaq_sensors_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_sensors_list", "list")
    ))
  }
}

#' Method for converting openaq_sensors_list to data frame.
#'
#' @param x A list of sensors as returned from get_sensor
#' @param row.names `NULL` or a character vector giving the row names for the
#' data frame. Missing values are not allowed.
#' @param optional logical. If TRUE, setting row names and converting column
#' names (to syntactic names: see make.names) is optional. Note that all of R's
#' base package as.data.frame() methods use optional only for column names
#' treatment, basically with the meaning of data.frame(*, check.names =
#' !optional). See also the make.names argument of the matrix method.
#' @param ... additional arguments to be passed to or from methods.#'
#'
#' @export as.data.frame.openaq_sensors_list
#' @export
#'
#' @examplesIf interactive()
#' sensor <- get_sensor(as_frame_frame = FALSE)
#' openaq_sensors_list.as.data.frame(sensor)
#'
as.data.frame.openaq_sensors_list <- function(x, row.names = NULL, optional = FALSE, ...) { # nolint: object_name_linter
  tbl <- do.call(rbind, lapply(x, function(rw) {
    data.frame(
      id = rw$id,
      name = rw$name,
      parameters_id = deep_get(rw, "parameter", "id"),
      datetime_first_utc = parse_openaq_timestamp(deep_get(rw, "datetimeFirst", "utc", default = NULL)),
      datetime_first_local = parse_openaq_timestamp(deep_get(rw, "datetimeFirst", "local", default = NULL)),
      datetime_last_utc = parse_openaq_timestamp(deep_get(rw, "datetimeLast", "utc", default = NULL)),
      datetime_last_local = parse_openaq_timestamp(deep_get(rw, "datetimeLast", "local", default = NULL)),
      min = deep_get(rw, "summary", "min"),
      max = deep_get(rw, "summary", "max"),
      avg = deep_get(rw, "summary", "avg"),
      expected_count = deep_get(rw, "coverage", "expectedCount"),
      expected_interval = deep_get(rw, "coverage", "expectedInterval"),
      observed_count = deep_get(rw, "coverage", "observedCount"),
      observed_interval = deep_get(rw, "coverage", "observedInterval"),
      percent_complete = deep_get(rw, "coverage", "percentComplete"),
      percent_coverage = deep_get(rw, "coverage", "percentCoverage"),
      latest_value = deep_get(rw, "latest", "value"),
      latest_datetime = parse_openaq_timestamp(deep_get(rw, "latest", "datetime", default = NULL)),
      latest_latitude = deep_get(rw, "latest", "coordinates", "latitude"),
      latest_longitude = deep_get(rw, "latest", "coordinates", "longitude")
    )
  }))
  tbl$id <- as.numeric(tbl$id)
  tbl$parameters_id <- as.numeric(tbl$parameters_id)
  tbl$expected_count <- as.numeric(tbl$expected_count)
  tbl$expected_interval <- as.factor(tbl$expected_interval)
  tbl$observed_count <- as.numeric(tbl$observed_count)
  tbl$observed_interval <- as.factor(tbl$observed_interval)
  tbl$percent_complete <- as.numeric(tbl$percent_complete)
  tbl$percent_coverage <- as.numeric(tbl$percent_coverage)
  tbl$latest_value <- as.numeric(tbl$latest_value)
  tbl$latest_latitude <- as.numeric(tbl$latest_latitude)
  tbl$latest_longitude <- as.numeric(tbl$latest_longitude)
  tbl$min <- as.numeric(tbl$min)
  tbl$max <- as.numeric(tbl$max)
  tbl$avg <- as.numeric(tbl$avg)
  attr(tbl, "meta") <- attr(x, "meta")
  return(structure(tbl,
    class = c("openaq_sensors_data.frame", "data.frame")
  ))
}

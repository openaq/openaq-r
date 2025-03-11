#' Get a list of measurements by sensors_id.
#'
#' @param sensors_id An integer representing an OpenAQ sensors_id.
#' @param data A string a data interval to return, defaults to "measurements".
#' @param rollup A string.
#' @param datetime_from A POSIXct datetime to filter measurements
#' @param datetime_to A POSIXct datetime to filter measurements
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
#' measurements <- list_sensor_measurements(3920, "hours")
#' }
#'
list_sensor_measurements <- function(
    sensors_id,
    data = "measurements",
    rollup = NULL,
    datetime_from = NULL,
    datetime_to = NULL,
    order_by = NULL,
    sort_order = NULL,
    limit = NULL,
    page = NULL,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  validate_data_param(data)
  validate_rollup(rollup)
  param_defs <- list(
    datetime_from = list(
      default = NULL,
      validator = validate_datetime,
      transform = transform_datetime
    ),
    datetime_to = list(
      default = NULL,
      validator = validate_datetime,
      transform = transform_datetime
    ),
    order_by = list(default = NULL, validator = NULL),
    sort_order = list(default = NULL, validator = validate_sort_order),
    limit = list(default = 100, validator = validate_limit),
    page = list(default = 1, validator = validate_page)
  )

  params_list <- extract_parameters(param_defs,
    datetime_from = datetime_from,
    datetime_to = datetime_to,
    order_by = order_by,
    sort_order = sort_order,
    limit = limit,
    page = page
  )
  if (is.null(rollup)) {
    path <- paste("sensors", sensors_id, data, sep = "/")
  } else {
    path <- paste("sensors", sensors_id, data, rollup, sep = "/")
  }
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
    return(as.data.frame.openaq_measurements_list(structure(
      data,
      class = c("openaq_measurements_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_measurements_list", "list")
    ))
  }
}


#' Get a list of measurements by locations_id.
#'
#' @param locations_id An integer representing an OpenAQ locations_id
#' @param parameters_ids A numeric vector of length 1 or more, containing the
#' ID(s) of the parameter(s) to use for filtering results. If multiple IDs are
#' provided, results matching any of the IDs will be returned.
#' @param data A string a data interval to return, defaults to "measurements".
#' @param rollup A string.
#' @param datetime_from A POSIXct datetime to filter measurements
#' @param datetime_to A POSIXct datetime to filter measurements
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
#' measurements <- list_sensor_measurements(3920, "hours")
#' }
#'
list_location_measurements <- function(
    locations_id,
    parameters_ids = NULL,
    data = "measurements",
    rollup = NULL,
    datetime_from = NULL,
    datetime_to = NULL,
    order_by = NULL,
    sort_order = NULL,
    limit = NULL,
    page = NULL,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  location <- get_location(locations_id, as_data_frame = FALSE)
  if (is.null(parameters_ids)) {
    sensors <- location[[1]]$sensors
  } else {
    sensors <- purrr::keep(
      location[[1]]$sensors,
      \(x) x$parameters_id %in% parameters_ids
    )
  }
  sensors_ids <- purrr::map(sensors, ~ .x$id)
  validate_data_param(data)
  validate_rollup(rollup)
  param_defs <- list(
    datetime_from = list(
      default = NULL,
      validator = validate_datetime,
      transform = transform_datetime
    ),
    datetime_to = list(
      default = NULL,
      validator = validate_datetime,
      transform = transform_datetime
    ),
    order_by = list(default = NULL, validator = NULL),
    sort_order = list(default = NULL, validator = validate_sort_order),
    limit = list(default = 100, validator = validate_limit),
    page = list(default = 1, validator = validate_page)
  )

  params_list <- extract_parameters(param_defs,
    datetime_from = datetime_from,
    datetime_to = datetime_to,
    order_by = order_by,
    sort_order = sort_order,
    limit = limit,
    page = page
  )
  results <- list()
  for (sensors_id in sensors_ids) {
    if (is.null(rollup)) {
      path <- paste("sensors", sensors_id, data, sep = "/")
    } else {
      path <- paste("sensors", sensors_id, data, rollup, sep = "/")
    }
    result <- fetch(path,
      query_params = params_list,
      dry_run = dry_run,
      rate_limit = rate_limit,
      api_key = api_key
    )
    results <- c(result, data)
  }
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_measurements_list(structure(
      results,
      class = c("openaq_measurements_list", "list")
    )))
  } else {
    return(structure(
      results,
      class = c("openaq_measurements_list", "list")
    ))
  }
}

get_period_field <- function(x, key) {
  if (is.null(x$period)) {
    NA
  } else {
    if (is.null(x$period[key])) {
      x$period[key]
    } else {
      NA
    }
  }
}


get_summary_field <- function(x, key) {
  if (is.null(x$summary)) {
    return(NA)
  } else {
    if (is.null(x$summary[key])) {
      return(x$summary[key])
    } else {
      return(NA)
    }
  }
}


#' Method for converting openaq_measurements_list to data frame.
#'
#' @param data A list of measurements as returned from list_sensor_measurements.
#' @param ... Other options.
#'
#' @export as.data.frame.openaq_measurements_list
#' @export
#'
#' @examples
#' \dontrun{
#' meas <- list_sensor_measurements(23707, limit = 500, as_data_frame = FALSE)
#' openaq_measurements_list.as.data.frame(meas)
#' }
as.data.frame.openaq_measurements_list <- function(x, row.names = NULL, optional = FALSE, ...) {
  tbl <- do.call(rbind, lapply(x, function(rw) {
    data.frame(
      value = rw$value,
      parameter_id = rw$parameter$id,
      parameter_name = rw$parameter$name,
      parameter_units = rw$parameter$units,
      period_label = deep_get(rw, "period", "label"),
      period_interval = deep_get(rw, "period", "interval"),
      datetime_from = parse_openaq_timestamp(deep_get(rw, "period", "datetimeFrom", "local", default = NULL)),
      datetime_to = parse_openaq_timestamp(deep_get(rw, "period", "datetimeTo", "local", default = NULL)),
      latitude = deep_get(rw, "coordinates", "latitude"),
      longitude = deep_get(rw, "coordinates", "longitude"),
      min = deep_get(rw, "summary", "min"),
      q02 = deep_get(rw, "summary", "q02"),
      q25 = deep_get(rw, "summary", "q25"),
      median = deep_get(rw, "summary", "median"),
      q75 = deep_get(rw, "summary", "q75"),
      q98 = deep_get(rw, "summary", "q98"),
      max = deep_get(rw, "summary", "max"),
      avg = deep_get(rw, "summary", "avg"),
      sd = deep_get(rw, "summary", "sd"),
      expected_count = deep_get(rw, "coverage", "expectedCount"),
      expected_interval = deep_get(rw, "coverage", "expectedInterval"),
      observed_count = deep_get(rw, "coverage", "observedCount"),
      observed_interval = deep_get(rw, "coverage", "observedInterval"),
      percent_complete = deep_get(rw, "coverage", "percentComplete"),
      percent_coverage = deep_get(rw, "coverage", "percentCoverage")
    )
  }))
  tbl$value <- as.numeric(tbl$value)
  tbl$parameter_id <- as.numeric(tbl$parameter_id)
  tbl$period_label <- as.factor(tbl$period_label)
  tbl$period_interval <- as.factor(tbl$period_interval)
  tbl$latitude <- as.numeric(tbl$latitude)
  tbl$longitude <- as.numeric(tbl$longitude)
  tbl$min <- as.numeric(tbl$min)
  tbl$q02 <- as.numeric(tbl$q02)
  tbl$q25 <- as.numeric(tbl$q25)
  tbl$median <- as.numeric(tbl$median)
  tbl$q75 <- as.numeric(tbl$q75)
  tbl$q98 <- as.numeric(tbl$q98)
  tbl$max <- as.numeric(tbl$max)
  tbl$avg <- as.numeric(tbl$avg)
  tbl$avg <- as.numeric(tbl$sd)
  tbl$expected_count <- as.numeric(tbl$expected_count)
  tbl$expected_interval <- as.factor(tbl$expected_interval)
  tbl$observed_count <- as.numeric(tbl$observed_count)
  tbl$observed_interval <- as.factor(tbl$observed_interval)
  tbl$percent_complete <- as.numeric(tbl$percent_complete)
  tbl$percent_coverage <- as.numeric(tbl$percent_coverage)


  attr(tbl, "meta") <- attr(x, "meta")
  structure(tbl,
    class = c("openaq_measurements_data.frame", "data.frame")
  )
}

#' Helper for plotting measurements
#'
#' @param df A data frame of measurements results.
#' @param ... Other options to be passed on to base::plot().
#'
#' @export
#'
#' @examples
#' \dontrun{
#' meas <- list_sensor_measurements(23707, limit = 500, as_data_frame = FALSE)
#' plot(meas)
#' }
plot.openaq_measurements_data.frame <- function(x, y, ...) {
  n <- head(x, 1)
  y_label <- sprintf("Value %s %s", n$parameter_name, n$parameter_units)
  base::plot(x$datetime_to, x$value,
    type = "l",
    xlab = "Datetime (local)",
    ylab = y_label
  )
  points(x$datetime_to, x$value)
  grid()
}

#' Helper for plotting measurements from list
#'
#' @param meas A list of measurements results.
#' @param ... Other options to be passed on to base::plot().
#'
#' @export
#'
#' @examples
#' \dontrun{
#' meas <- list_sensor_measurements(23707, limit = 500, as_data_frame = FALSE)
#' plot(meas)
#' }
plot.openaq_measurements_list <- function(x, y, ...) {
  plot(as.data.frame(x), ...)
}

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
#' @param locations_id An integer representing an OpenAQ sensors_id.
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


get_summary_field <- function(x, key) {
  if (is.null(x$summary)) {
    return(NA)
  } else {
    return(x$summary[key])
  }
}

#' Method for converting openaq_measurements_list to data frame.
#'
#' @param data A list of measurements as returned from list_sensor_measurements.
#'
#' @export as.data.frame.openaq_measurements_list
#' @export
#'
#' @examples
#' \dontrun{
#' meas <- list_sensor_measurements(23707, limit = 500, as_data_frame = FALSE)
#' openaq_measurements_list.as.data.frame(meas)
#' }
as.data.frame.openaq_measurements_list <- function(data, ...) {
  tbl <- do.call(rbind, lapply(data, function(x) {
    data.frame(
      value = x$value,
      parameter_id = x$parameter$id,
      parameter_name = x$parameter$name,
      parameter_units = x$parameter$units,
      period_label = x$period$label,
      period_interval = x$period$interval,
      datetime_from = parse_openaq_timestamp(x$period$datetimeFrom$local),
      datetime_to = parse_openaq_timestamp(x$period$datetimeTo$local),
      latitude = check_coordinates(x$coordinates, "latitude"),
      longitude = check_coordinates(x$coordinates, "longitude"),
      min = get_summary_field(x, "min"),
      q02 = get_summary_field(x, "q02"),
      q25 = get_summary_field(x, "q25"),
      median = get_summary_field(x, "median"),
      q75 = get_summary_field(x, "q75"),
      q98 = get_summary_field(x, "q98"),
      max = get_summary_field(x, "max"),
      avg = get_summary_field(x, "avg"),
      sd = get_summary_field(x, "sd"),
      expected_count = x$coverage$expectedCount,
      expected_interval = x$coverage$expectedInterval,
      observed_count = x$coverage$observedCount,
      observed_interval = x$coverage$observedInterval,
      percent_complete = x$coverage$percentComplete,
      percent_coverage = x$coverage$percentCoverage
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


  attr(tbl, "meta") <- attr(data, "meta")
  return(structure(tbl,
    class = c("openaq_measurements_data.frame", "data.frame")
  ))
}

#' Helper for plotting measurements
#'
#' @param df A measurements data frame.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' meas <- list_sensor_measurements(23707, limit = 500, as_data_frame = FALSE)
#' plot(meas)
#' }
plot.openaq_measurements_data.frame <- function(df, ...) {
  n <- head(df, 1)
  y_label <- sprintf("Value %s %s", n$parameter_name, n$parameter_units)
  base::plot(df$datetime_to, df$value,
    type = "l",
    xlab = "Datetime (local)",
    ylab = y_label
  )
  points(df$datetime_to, df$value)
  grid()
}

#' Helper for plotting measurements from list
#'
#' @export
#'
#' @examples
#' \dontrun{
#' meas <- list_sensor_measurements(23707, limit = 500, as_data_frame = FALSE)
#' plot(meas)
#' }
plot.openaq_measurements_list <- function(meas, ...) {
  plot(as.data.frame(meas), ...)
}

#' Get a single sensor from sensors resource.
#'
#' @param sensors_id An integer.
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
#' sensor <- get_sensor(42)
#' }
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
#' sensors <- get_location_sensors(42)
#' }
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
#' @param data A list of sensors as returned from get_sensor
#' @param ... Other options.
#'
#' @export as.data.frame.openaq_sensors_list
#' @export
#'
#' @examples
#' \dontrun{
#' sensor <- get_sensor(as_frame_frame = FALSE)
#' openaq_sensors_list.as.data.frame(sensor)
#' }
as.data.frame.openaq_sensors_list <- function(data, ...) {
  tbl <- do.call(rbind, lapply(data, function(x) {
    data.frame(
      id = x$id,
      name = x$name,
      parameters_id = x$parameter$id,
      datetime_first_utc = parse_openaq_timestamp(x$datetimeFirst$utc),
      datetime_first_local = parse_openaq_timestamp(x$datetimeFirst$local),
      datetime_last_utc = parse_openaq_timestamp(x$datetimeLast$utc),
      datetime_last_local = parse_openaq_timestamp(x$datetimeLast$local),
      expected_count = x$coverage$expectedCount,
      expected_interval = x$coverage$expectedInterval,
      observed_count = x$coverage$observedCount,
      observed_interval = x$coverage$observedInterval,
      percent_complete = x$coverage$percentComplete,
      percent_coverage = x$coverage$percentCoverage,
      datetime_from = parse_openaq_timestamp(x$coverage$datetimeFrom),
      datetime_to = parse_openaq_timestamp(x$coverage$datetimeTo),
      latest_value = x$latest$value,
      latest_datetime = parse_openaq_timestamp(x$latest$datetime),
      latest_latitude = x$latest$coordinates$latitude,
      latest_longitude = x$latest$coordinates$longitude,
      min = x$summary$min,
      max = x$summary$max,
      avg = x$summary$avg
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
  attr(tbl, "meta") <- attr(data, "meta")
  return(structure(tbl,
    class = c("openaq_sensors_data.frame", "data.frame")
  ))
}

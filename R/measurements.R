#' Get a list of measurements by sensors_id.
#'
#' @param sensors_id An integer representing an OpenAQ sensors_id.
#' @param data A string a data interval to return, default is "measurements".
#' @param rollup A string representing the aggregation rollup, default is `NULL`.
#' @param datetime_from A POSIXct datetime (when `data` is `"measurements"` or
#' `"hours"`) or a Date (when `data` is `"days"` or larger) to filter from,
#' default is `NULL`.
#' @param datetime_to A POSIXct datetime (when `data` is `"measurements"` or
#' `"hours"`) or a Date (when `data` is `"days"` or larger) to filter to,
#' default is `NULL`.
#' @param order_by A string representing the field to order by, default is `NULL`.
#' @param sort_order A string, either "asc" or "desc", default is `NULL`.
#' @param limit An integer representing the number of results per page.
#' @param page An integer representing the page number.
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
#' measurements <- list_sensor_measurements(3920, "hours")
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
  validate_data_rollup_compat(data, rollup)
  if (data %in% c("measurements", "hours")) {
    datetime_validator <- validate_datetime
    datetime_transformer <- transform_datetime
  } else {
    datetime_validator <- validate_date
    datetime_transformer <- transform_date
  }
  param_defs <- list(
    datetime_from = list(
      default = NULL,
      validator = datetime_validator,
      transform = datetime_transformer
    ),
    datetime_to = list(
      default = NULL,
      validator = datetime_validator,
      transform = datetime_transformer
    ),
    order_by = list(default = NULL, validator = NULL),
    sort_order = list(default = NULL, validator = validate_sort_order),
    limit = list(default = 100, validator = validate_limit),
    page = list(default = 1, validator = validate_page)
  )

  if (data %in% c("measurements", "hours")) {
    params_list <- extract_parameters(param_defs,
      datetime_from = datetime_from,
      datetime_to = datetime_to,
      order_by = order_by,
      sort_order = sort_order,
      limit = limit,
      page = page
    )
  } else {
    params_list <- extract_parameters(param_defs,
      date_from = datetime_from,
      date_to = datetime_to,
      order_by = order_by,
      sort_order = sort_order,
      limit = limit,
      page = page
    )
  }
  if (is.null(rollup)) {
    path <- paste("sensors", sensors_id, data, sep = "/")
  } else {
    path <- paste("sensors", sensors_id, data, rollup, sep = "/")
  }
  fetched_data <- fetch(path,
    query_params = params_list,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(fetched_data)
  }
  if (isTRUE(as_data_frame)) {
    as.data.frame.openaq_measurements_list(structure(
      fetched_data,
      class = c("openaq_measurements_list", "list")
    ))
  } else {
    structure(
      fetched_data,
      class = c("openaq_measurements_list", "list")
    )
  }
}

#' Extract a field from the period sub-list
#'
#' Internal helper to safely navigate the 'period' list.
#' Returns NA if 'period' is missing or the key doesn't exist.
#'
#' @param x A list representing a single record.
#' @param key The specific element name to retrieve.
#' @noRd
get_period_field <- function(x, key) {
  if (is.null(x$period)) {
    NA
  } else {
    if (!is.null(x$period[[key]])) {
      x$period[[key]]
    } else {
      NA
    }
  }
}

#' Extract a field from the summary sub-list
#'
#' Internal helper to safely navigate the 'summary' list.
#' Returns NA if 'summary' is missing or the key doesn't exist.
#'
#' @param x A list representing a single record.
#' @param key The specific element name to retrieve.
#' @noRd
get_summary_field <- function(x, key) {
  if (is.null(x)) stop("input 'x' cannot be NULL")
  if (is.null(x$summary) || is.null(x$summary[[key]])) {
    return(NA)
  }
  x$summary[[key]]
}


#' Method for converting openaq_measurements_list to data frame.
#'
#' @param x A list of measurements as returned from list_sensor_measurements.
#' @param row.names `NULL` or a character vector giving the row names for the
#' data frame. Missing values are not allowed.
#' @param optional logical. If TRUE, setting row names and converting column
#' names (to syntactic names: see make.names) is optional. Note that all of R's
#' base package as.data.frame() methods use optional only for column names
#' treatment, basically with the meaning of data.frame(*, check.names =
#' !optional). See also the make.names argument of the matrix method.
#' @param ... additional arguments to be passed to or from methods.
#'
#' @export as.data.frame.openaq_measurements_list
#' @export
#'
#' @examplesIf interactive()
#' meas <- list_sensor_measurements(23707, limit = 500, as_data_frame = FALSE)
#' as.data.frame(meas)
#'
as.data.frame.openaq_measurements_list <- function(x, row.names = NULL, optional = FALSE, ...) { # nolint: object_name_linter
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
  tbl$sd <- as.numeric(tbl$sd)
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
#' @param x A data frame of measurements results.
#' @param y Unused, default is `NULL`.
#' @param ... Other options to be passed on to base::plot().
#'
#' @export
#'
#' @examplesIf interactive()
#' meas <- list_sensor_measurements(23707, limit = 500, as_data_frame = FALSE)
#' plot(meas)
#'
plot.openaq_measurements_data.frame <- function(x, y = NULL, ...) {
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
#' @param x A list of measurements results.
#' @param y Other data
#' @param ... Other options to be passed on to base::plot().
#'
#' @export
#'
#' @examplesIf interactive()
#' meas <- list_sensor_measurements(23707, limit = 500)
#' plot(meas)
#'
plot.openaq_measurements_list <- function(x, y = NULL, ...) {
  plot(as.data.frame(x), ...)
}

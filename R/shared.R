#' Validates sort_order query parameter.
#'
#' A function for ensuring that the sort_order query parameter is either "ASC"
#' or "DESC", case insensitive.
#'
#' @param sort_order Any value.
#'
#' @noRd
validate_sort_order <- function(sort_order) {
  valid_orders <- c("ASC", "DESC")
  if (!(toupper(sort_order) %in% valid_orders)) {
    stop("Invalid sort order. Must be either 'ASC' or 'DESC'.")
  }
}

#' Validates limit query parameter.
#'
#' A function for ensuring that the limit query parameter is a numeric value
#' between 0 and up to 1000.
#'
#' @param limit Any value.
#'
#' @noRd
validate_limit <- function(limit) {
  if (!(is.numeric(limit) && limit > 0 && limit <= 1000)) {
    stop("Invalid limit. Must be a positive numeric value and less than or equal
    to 1000.")
  }
}

#' Validates page query parameter.
#'
#' A function for ensuring that the page query parameter is a numeric value
#' and greater than zero.
#'
#' @param page Any value.
#'
#' @noRd
validate_page <- function(page) {
  if (!(is.numeric(page) && page > 0)) {
    stop("Invalid page Must be a positive numeric value.")
  }
}


#' Validates query parameters that are numeric or list of numerics.
#'
#' An internal helper function to generalize the validation of query parameters
#' that are of type numeric or list of numerics.
#'
#' @param x Any value.
#' @param parameter A string.
#'
#' @noRd
validate_numeric_or_list <- function(x, parameter) {
  if (!is.numeric(x) && !(is.list(x) && all(sapply(x, is.numeric)))) {
    msg <- sprintf(
      "%s must be a numeric value or a list of numeric values.",
      parameter
    )
    stop(msg)
  }
}

#'
#'
#'
validate_providers_id <- function(id) {
  validate_numeric_or_list(id, "providers_id")
}

#'
#'
#'
validate_owner_contacts_id <- function(id) {
  validate_numeric_or_list(id, "owner_contacts_id")
}

#'
#'
#'
validate_manufacturers_id <- function(id) {
  validate_numeric_or_list(id, "manufacturers_id")
}

#'
#'
#'
validate_licenses_id <- function(id) {
  validate_numeric_or_list(id, "licenses_id")
}

#'
#'
#'
validate_instruments_id <- function(id) {
  validate_numeric_or_list(id, "instruments_id")
}

#'
#'
#'
validate_countries_id <- function(id) {
  validate_numeric_or_list(id, "countries_id")
}

#'
#'
#'
validate_parameters_id <- function(id) {
  validate_numeric_or_list(id, "parameters_id")
}

#'
#'
#'
check_coordinates <- function(coordinates, key) {
  if (is.null(coordinates)) {
    return(NA)
  } else {
    return(coordinates[key])
  }
}

#' Validates radius query parameter.
#'
#' A function for ensuring that the radius query parameter is a numeric value,
#' greater than zero and less than 25000
#'
#' @param radius Any value.
#'
#' @noRd
validate_radius <- function(radius) {
  if (!(is.numeric(radius) && radius > 0 && radius <= 25000)) {
    stop("Invalid page Must be a positive numeric value.")
  }
}

#' Validates coordinates query parameter.
#'
#' A function for ensuring that the coordinates query parameter is a list of
#' numeric values and is of valid WGS84 coordinates. Ensures that longitude
#' value is between -180 and 180 and latitude value is between -90 and 90.
#'
#' @param coordinates Any value.
#'
#' @noRd
validate_coordinates <- function(coordinates) {
  if (!is.list(coordinates) || length(coordinates) != 2) {
    stop("Coordinates must be a list of length 2.")
  }
  if (!is.numeric(coordinates[[1]]) || !is.numeric(coordinates[[2]])) {
    stop("Coordinates must be numeric values.")
  }
  if (abs(coordinates[[1]]) > 90 || abs(coordinates[[2]]) > 180) {
    stop("Invalid latitude or longitude values.")
  }
}

#' Validates bbox query parameter.
#'
#' A function for ensuring that the bbox query parameter is a list of
#' numeric values and is of valid WGS84 coordinates. Ensures that longitude
#' values are between -180 and 180 and latitude values are between -90 and 90.
#'
#' @param bbox Any value.
#'
#' @noRd
validate_bbox <- function(bbox) {
  if (!is.list(bbox) || length(bbox) != 4) {
    stop("Bounding box must be a list of length 4.")
  }

  if (!all(sapply(bbox, is.numeric))) {
    stop("Bounding box elements must be numeric values.")
  }

  min_lon <- bbox[[1]]
  min_lat <- bbox[[2]]
  max_lon <- bbox[[3]]
  max_lat <- bbox[[4]]

  if (abs(min_lon) > 180 || abs(max_lon) > 180) {
    stop("Invalid longitude values in bounding box.")
  }

  if (abs(min_lat) > 90 || abs(max_lat) > 90) {
    stop("Invalid latitude values in bounding box.")
  }

  if (min_lon >= max_lon || min_lat >= max_lat) {
    stop("Invalid bounding box: minimum coordinates must be less than maximum
    coordinates.")
  }
}


#' Validates iso query parameter.
#'
#' A function for ensuring that the iso query parameter is a two character
#' string alphabetical letters.
#'
#' @param iso Any value.
#'
#' @noRd
validate_iso <- function(iso) {
  iso_regex <- "^[A-Za-z]{2}$"
  if (!grepl(iso_regex, iso)) {
    stop("Invalid iso. Must be a 2 character string ISO 3166-1 alpha-2.")
  }
}

#' Validates monitor query parameter.
#'
#' A function for ensuring that the monitor query parameter is a logical
#' value.
#'
#' @param monitor Any value.
#'
#' @noRd
validate_monitor <- function(monitor) {
  if (!(is.logical(monitor))) {
    stop("Invalid monitor Must be a logical value TRUE or FALSE.")
  }
}

#' Validates mobile query parameter.
#'
#' A function for ensuring that the mobile query parameter is a logical value,
#'
#' @param mobile Any value.
#'
#' @noRd
validate_mobile <- function(mobile) {
  if (!(is.logical(mobile))) {
    stop("Invalid mobile Must be a logical value TRUE or FALSE.")
  }
}

#'
#'
#'
is.POSIXct <- function(x) inherits(x, "POSIXct") # nolint: object_name_linter.

#' Validates datetime query parameters.
#'
#' A function for ensuring that datetime query parameters are a valid is.POSIXct
#' value,
#'
#' @param datetime Any value.
#'
#' @noRd
validate_datetime <- function(datetime) {
  if (!is.POSIXct(datetime)) {
    stop("Invalid datetime must be a POSIXct datetime.")
  }
}

#' Validates data path parameter.
#'
#' A function for ensuring that the data path parameter is one of the valid
#' values
#'
#' @param data Any value.
#'
#' @noRd
validate_data_param <- function(data) {
  valid_data_values <- c("measurements", "hours", "days", "years")
  if (is.null(data) || !(data %in% valid_data_values)) {
    stop("Invalid data value. Must be one of 'measurements', 'hours', 'days', 'years'.")
  }
}

#' Validates rollup path parameter.
#'
#' A function for ensuring that the rollup path parameter is one of the valid
#' values
#'
#' @param rollup Any value.
#'
#' @noRd
validate_rollup <- function(rollup) {
  if (!is.null(rollup)) {
    valid_rollups <- c(
      "hourly", "daily", "monthly", "yearly", "hourofday",
      "dayofweek", "monthofyear"
    )
    if (!(rollup %in% valid_rollups)) {
      stop("Invalid rollup Must be one of 'hourly','daily','monthly','yearly','hourofday','dayofweek','monthofyear'.")
    }
  }
}


#'
#'
#'
#'
#' @param param_defs Any value.
#'
#' @noRd
extract_parameters <- function(param_defs, ...) {
  params <- list(...)
  for (param_name in names(param_defs)) {
    param_def <- param_defs[[param_name]]
    param_value <- params[[param_name]]
    if (is.null(param_value)) {
      param_value <- param_def$default
    } else if (!is.null(param_def$validator)) {
      param_def$validator(param_value)
    }
    if (!is.null(param_def$transform)) {
      params[[param_name]] <- param_def$transform(param_value)
    } else {
      params[[param_name]] <- param_value
    }
  }
  return(params)
}


#' Transform function that checks if input is a list and transforms accordingly.
#'
#' @param x The value to be checked
#'
#' @return The value if not a list, the item collapsed to comma delimited string
#' if is a list.
#'
#' @examples
#' transform_list_or_item(list(1, 2, 3))
#' @noRd
transform_list_or_item <- function(x) {
  if (is.list(x)) {
    invisible(list_to_string(x))
  } else {
    invisible(x)
  }
}

#' Converts a list to a comma delimited string
#'
#' @param li A list to be collapsed.
#'
#' @return A string of the collapse list items
#'
#' @examples
#' list_to_string(list(1, 2, 3))
#' @noRd
list_to_string <- function(li) {
  if (!is.null(li)) {
    invisible(paste(li, collapse = ","))
  }
}


#' Converts a timestamp to an ISO 8601 datetime string.
#'
#' @param x A list to be collapsed.
#'
#' @return
#'
#' @examples
#' list_to_string(list(1, 2, 3))
#' @noRd
transform_datetime <- function(x) {
  if (!is.null(x)) {
    invisible(lubridate::format_ISO8601(x, usetz = TRUE))
  }
}

#' Set rate limit headers as attributes to an object
#'
#' @param data An object to which the header attributes are set.
#' @param headers A httr2 list of response headers.
#'
#' @noRd
add_headers <- function(data, headers) {
  attr(data, "x_ratelimit_used") <- headers["X-Ratelimit-Used"]
  attr(data, "x_ratelimit_reset") <- headers["X-Ratelimit-Reset"]
  attr(data, "x_ratelimit_limit") <- headers["X-Ratelimit-Limit"]
  attr(data, "x_ratelimit_remaining") <- headers["X-Ratelimit-Remaining"]
}


#'
#'
#'
parse_openaq_timestamp <- function(x) {
  if (!is.null(x)) {
    if (methods::is(x, "character")) {
      utc <- x
    } else if (methods::is(x, "list") && "utc" %in% names(x)) {
      utc <- x$utc
    }
    return(as.POSIXct(utc, format = "%Y-%m-%dT%H:%M:%S", tz = "UTC"))
  } else {
    return(NA)
  }
}

#'
#'
#'
or <- function(test, alternative) {
  res <- test
  if (!length(res)) {
    return(alternative)
  }
  if (all(is.null(res) | is.na(res) | is.nan(res))) {
    return(alternative)
  }
  res
}

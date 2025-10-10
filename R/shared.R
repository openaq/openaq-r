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


#' Validates query parameters are a numeric vector
#'
#' An internal helper function to generalize the validation of query parameters
#' that shoudl be a numeric vector.
#'
#' @param x Any value.
#' @param parameter A string representing the query parameter name.
#'
#' @noRd
validate_numeric_vector <- function(x, parameter) {
  if (!is.numeric(x) || !is.vector(x)) {
    msg <- sprintf(
      "%s must be a numeric vector",
      parameter
    )
    stop(msg)
  }
}

#' Validates providers_id query parameter.
#'
#' A function for validating providers_id query parameter is a numeric
#' vector
#'
#' @param id Any value.
#'
#' @noRd
validate_providers_id <- function(id) {
  validate_numeric_vector(id, "providers_id")
}

#' Validates owner_contacts_id query parameter.
#'
#' A function for validating owner_contacts_id query parameter is a numeric
#' vector
#'
#' @param id Any value.
#'
#' @noRd
validate_owner_contacts_id <- function(id) {
  validate_numeric_vector(id, "owner_contacts_id")
}

#' Validates manufacturers_id query parameter.
#'
#' A function for validating manufacturers_id query parameter is a numeric
#' vector
#'
#' @param id Any value.
#'
#' @noRd
validate_manufacturers_id <- function(id) {
  validate_numeric_vector(id, "manufacturers_id")
}

#' Validates licenses_id query parameter.
#'
#' A function for validating licenses_id query parameter is a numeric
#' vector
#'
#' @param id Any value.
#'
#' @noRd
validate_licenses_id <- function(id) {
  validate_numeric_vector(id, "licenses_id")
}

#' Validates instruments_id query parameter.
#'
#' A function for validating instruments_id query parameter is a numeric
#' vector
#'
#' @param id Any value.
#'
#' @noRd
validate_instruments_id <- function(id) {
  validate_numeric_vector(id, "instruments_id")
}

#' Validates countries_id query parameter.
#'
#' A function for validating countries_id query parameter is a numeric
#' vector
#'
#' @param id Any value.
#'
#' @noRd
validate_countries_id <- function(id) {
  validate_numeric_vector(id, "countries_id")
}

#' Validates parameters_id query parameter.
#'
#' A function for validating parameters_id query parameter is a numeric
#' vector
#'
#' @param id Any value.
#'
#' @noRd
validate_parameters_id <- function(id) {
  validate_numeric_vector(id, "parameters_id")
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
    if (radius > 25000) {
      stop("Invalid radius value. Must be less than 25000")
    } else {
      stop("Invalid radius value. Must be a positive numeric value.")
    }
  }
}

#' Validates coordinates query parameter.
#'
#' A function for ensuring that the coordinates query parameter is a named
#' numeric vector with `latitude` and `longitude` fields and is of valid WGS84
#' coordinates. Ensures that longitude value is between -180 and 180 and
#' latitude value is between -90 and 90.
#'
#' @param coordinates Any value.
#'
#' @noRd
validate_coordinates <- function(coordinates) {
  error_message <- NULL
  if (!is.numeric(coordinates)) {
    error_message <- "Invalid point format. Input must be numeric."
  } else if (length(coordinates) != 2 || is.null(names(coordinates)) || !all(c("longitude", "latitude") %in% names(coordinates))) {
    error_message <- "Invalid point format. Must be a named numeric vector with 'longitude' and 'latitude'."
  } else {
    lon <- coordinates["longitude"]
    lat <- coordinates["latitude"]

    if (!is.numeric(lon) || !is.numeric(lat)) {
      error_message <- "Longitude and latitude must be numeric."
    } else if (abs(lon) > 180 || abs(lat) > 90) {
      error_message <- "Invalid longitude or latitude. Longitude must be between -180 and 180, and latitude between -90 and 90."
    }
  }

  if (!is.null(error_message)) {
    stop(error_message)
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
validate_bbox <- function(bbox) { # nolint: cyclocomp_linter
  error_message <- NULL

  if (!is.numeric(bbox)) {
    error_message <- "Invalid bounding box format. Input must be numeric."
  } else if (length(bbox) != 4 || is.null(names(bbox)) || !all(c("xmin", "ymin", "xmax", "ymax") %in% names(bbox))) {
    error_message <- "Invalid bounding box format. Must be a named numeric vector with 'xmin', 'ymin', 'xmax', and 'ymax'."
  } else {
    xmin <- bbox["xmin"]
    ymin <- bbox["ymin"]
    xmax <- bbox["xmax"]
    ymax <- bbox["ymax"]

    if (!is.numeric(xmin) || !is.numeric(ymin) || !is.numeric(xmax) || !is.numeric(ymax)) {
      error_message <- "Bounding box coordinates must be numeric."
    } else if (xmin > xmax) {
      error_message <- "Invalid bounding box. xmin must be less than or equal to xmax."
    } else if (ymin > ymax) {
      error_message <- "Invalid bounding box. ymin must be less than or equal to ymax."
    } else if (abs(ymin) > 90 || abs(ymax) > 90) {
      error_message <- "Invalid latitude values in bounding box."
    } else if (abs(xmin) > 180 || abs(xmax) > 180) {
      error_message <- "Invalid longitude values in bounding box."
    }
  }
  if (!is.null(error_message)) {
    stop(error_message)
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
#' @param ... list of values
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
  params
}


#' Transform function that checks if input is a list and transforms accordingly.
#'
#' @param x The value to be checked
#'
#' @return The value if not a list, the item collapsed to comma delimited string
#' if is a list.
#'
#' @examples
#' transform_vector_to_comma_string(c(1, 2, 3))
#' @noRd
transform_vector_to_string <- function(x) {
  if (!is.null(x)) {
    invisible(paste(x, collapse = ","))
  }
}

#' Converts a timestamp to an ISO 8601 datetime string.
#'
#' @param x A list to be collapsed.
#'
#' @examples
#' transform_datetime
#' @noRd
transform_datetime <- function(x) {
  if (!is.null(x)) {
    invisible(lubridate::format_ISO8601(x, usetz = TRUE))
  }
}

#' Set rate limit headers as attributes to an object
#'
#' @param data An object to which the header attributes are set.
#' @param headers A httr2 response object
#'
#' @return the data object with the headers as attributes.
#'
#' @noRd
add_headers <- function(data, res) {
  attr(data, "headers") <- c(
    "x_ratelimit_used" = as.integer(httr2::resp_header(res, "X-Ratelimit-Used")),
    "x_ratelimit_reset" = as.integer(httr2::resp_header(res, "X-Ratelimit-Reset")),
    "x_ratelimit_limit" = as.integer(httr2::resp_header(res, "X-Ratelimit-Limit")),
    "x_ratelimit_remaining" = as.integer(httr2::resp_header(res, "X-Ratelimit-Remaining"))
  )
  invisible(data)
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
    as.POSIXct(utc, format = "%Y-%m-%dT%H:%M:%S", tz = "UTC")
  } else {
    NA
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

#' Gets value from a nested list
#'
#' @param x A list to search.
#' @param ... Keys, in order of their hierarchy to check against the list `x`.
#'
#' @noRd
deep_get <- function(x, ..., default = NA) {
  for (key in list(...)) {
    if (is.null(x) || !key %in% names(x)) {
      return(default)
    }
    x <- x[[key]]
  }
  if (is.null(x)) {
    return(NA)
  }
  return(x)
}

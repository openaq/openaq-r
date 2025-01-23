# validate_sort_order

test_that("validate_sort_order throws", {
  sort_order <- "acs" # mispelling of "asc"
  expect_error(validate_sort_order(sort_order))
})

test_that("validate_sort_order does not throw - lowercase", {
  sort_order <- "asc"
  expect_no_error(validate_sort_order(sort_order))
  sort_order <- "desc"
  expect_no_error(validate_sort_order(sort_order))
})

test_that("validate_sort_order does not throw - uppercase", {
  sort_order <- "ASC"
  expect_no_error(validate_sort_order(sort_order))
  sort_order <- "DESC"
  expect_no_error(validate_sort_order(sort_order))
})

# validate_limit

test_that("validate_limit throws - non numeric", {
  limit <- "100"
  expect_error(validate_limit(limit))
})

test_that("validate_limit throws - lower bound", {
  limit <- -1
  expect_error(validate_limit(limit))
})

test_that("validate_limit throws - zero", {
  limit <- 0
  expect_error(validate_limit(limit))
})

test_that("validate_limit throws - upper bound", {
  limit <- 1001
  expect_error(validate_limit(limit))
})

test_that("validate_limit does not throw", {
  limit <- 42
  expect_no_error(validate_limit(limit))
})


# validate_page

test_that("validate_page throws - non numeric", {
  page <- "100"
  expect_error(validate_page(page))
})

test_that("validate_page throws - lower bound", {
  page <- -1
  expect_error(validate_page(page))
})

test_that("validate_page does not throw ", {
  page <- 2
  expect_no_error(validate_page(page))
})

# validate_numeric_or_list

test_that("validate_numeric_or_list works valid inputs", {
  expect_no_error(validate_numeric_or_list(10, "parameter"))
  expect_no_error(validate_numeric_or_list(list(1, 2, 3), "parameter"))
})

test_that("validate_numeric_or_list throws for invalid inputs", {
  expect_error(
    validate_numeric_or_list("abc", "parameter"),
    "parameter must be a numeric value or a list of numeric values."
  )
  expect_error(
    validate_numeric_or_list(list(1, "a", 3), "parameter"),
    "parameter must be a numeric value or a list of numeric values."
  )
  expect_error(
    validate_numeric_or_list(TRUE, "parameter"),
    "parameter must be a numeric value or a list of numeric values."
  )
})

# validate_providers_id

test_that("validate_providers_id throws with correct error message", {
  expect_error(
    validate_providers_id("abc"),
    "providers_id must be a numeric value or a list of numeric values."
  )
})

# validate_owner_contacts_id

test_that("validate_owner_contacts_id throws with correct error message", {
  expect_error(
    validate_owner_contacts_id("abc"),
    "owner_contacts_id must be a numeric value or a list of numeric values."
  )
})

# validate_manufacturers_id

test_that("validate_manufacturers_id throws with correct error message", {
  expect_error(
    validate_manufacturers_id("abc"),
    "manufacturers_id must be a numeric value or a list of numeric values."
  )
})

# validate_licenses_id

test_that("validate_licenses_id throws with correct error message", {
  expect_error(
    validate_licenses_id("abc"),
    "licenses_id must be a numeric value or a list of numeric values."
  )
})

# validate_instruments_id

test_that("validate_licenses_id throws with correct error message", {
  expect_error(
    validate_licenses_id("abc"),
    "licenses_id must be a numeric value or a list of numeric values."
  )
})

# validate_countries_id

test_that("validate_countries_id throws with correct error message", {
  expect_error(
    validate_countries_id("abc"),
    "countries_id must be a numeric value or a list of numeric values."
  )
})

# validate_parameters_id

test_that("validate_parameters_id throws with correct error message", {
  expect_error(
    validate_parameters_id("abc"),
    "parameters_id must be a numeric value or a list of numeric values."
  )
})

# check_coordinates TODO


# validate_radius

test_that("validate_radius throws - non numeric", {
  radius <- "100"
  expect_error(validate_radius(radius))
})

test_that("validate_radius throws - upper bounds", {
  radius <- 25001
  expect_error(validate_radius(radius))
})

test_that("validate_radius throws - lower bounds", {
  radius <- -1
  expect_error(validate_radius(radius))
})

test_that("validate_radius does not throw", {
  radius <- 100
  expect_no_error(validate_radius(radius))
})

# validate_coordinates

test_that("validate_coordinates throws - non numeric", {
  coordinates <- list(0, "0")
  expect_error(validate_coordinates(coordinates))
  coordinates <- list("0", 0)
  expect_error(validate_coordinates(coordinates))
  coordinates <- list("0", "0")
  expect_error(validate_coordinates(coordinates))
})

test_that("validate_coordinates throws - list errors", {
  coordinates <- list(0, 0, 0)
  expect_error(validate_coordinates(coordinates))
  coordinates <- list(0)
  expect_error(validate_coordinates(coordinates))
  coordinates <- 0
  expect_error(validate_coordinates(coordinates))
})


test_that("validate_coordinates throws - upper bounds", {
  coordinates <- list(91, 170)
  expect_error(validate_coordinates(coordinates))
  coordinates <- list(89, 181)
  expect_error(validate_coordinates(coordinates))
})

test_that("validate_coordinates throws - lower bounds", {
  coordinates <- list(-91, 170)
  expect_error(validate_coordinates(coordinates))
  coordinates <- list(89, -181)
  expect_error(validate_coordinates(coordinates))
})

test_that("validate_coordinates does not throw", {
  coordinates <- list(0, 0)
  expect_no_error(validate_coordinates(coordinates))
  coordinates <- list(42, 42)
  expect_no_error(validate_coordinates(coordinates))
  coordinates <- list(90, 180)
  expect_no_error(validate_coordinates(coordinates))
  coordinates <- list(-90, -180)
  expect_no_error(validate_coordinates(coordinates))
})


# validate_bbox

test_that("validate_bbox throws - non numeric", {
  invalid_bbox <- list("-180", -90, 180, 90)
  expect_error(validate_bbox(invalid_bbox))
  invalid_bbox <- list(-180, "-90", 180, 90)
  expect_error(validate_bbox(invalid_bbox))
  invalid_bbox <- list(-180, -90, "180", 90)
  expect_error(validate_bbox(invalid_bbox))
  invalid_bbox <- list(-180, -90, 180, "90")
  expect_error(validate_bbox(invalid_bbox))
  invalid_bbox <- list("-180", "-90", "180", "90")
  expect_error(validate_bbox(invalid_bbox))
})

test_that("validate_bbox throws error for invalid list length", {
  invalid_bbox <- list(-180, -90, 180)
  expect_error(validate_bbox(invalid_bbox))
  invalid_bbox <- list(-180, -90, 180, 90, 100)
  expect_error(validate_bbox(invalid_bbox))
})

test_that("validate_bbox throws error for invalid latitude", {
  invalid_bbox <- list(-200, -90, 180, 90)
  expect_error(validate_bbox(invalid_bbox))
})

test_that("validate_bbox throws error for invalid longitude", {
  invalid_bbox <- list(-180, -100, 180, 90)
  expect_error(validate_bbox(invalid_bbox))
})

test_that("validate_bbox throws - invalid bounding box range", {
  invalid_bbox <- list(10, 20, 5, 10)
  expect_error(validate_bbox(invalid_bbox))
  invalid_bbox <- list(-180, 20, 180, 10)
  expect_error(validate_bbox(invalid_bbox))
})

test_that("validate_bbox does not throw error for valid bounding box", {
  valid_bbox <- list(-180, -90, 180, 90)
  expect_silent(validate_bbox(valid_bbox))
})


# validate_iso

test_that("validate_iso handles valid inputs", {
  expect_no_error(validate_iso("US"))
  expect_no_error(validate_iso("XK"))
  expect_no_error(validate_iso("ZA"))
  expect_no_error(validate_iso("us"))
  expect_no_error(validate_iso("xk"))
  expect_no_error(validate_iso("za"))
})

test_that("validate_iso throws for invalid inputs", {
  error_message <- "Invalid iso. Must be a 2 character string ISO 3166-1 alpha-2."
  expect_error(validate_iso("USA"), error_message)
  expect_error(validate_iso("U"), error_message)
  expect_error(validate_iso("12"), error_message)
  expect_error(validate_iso("U-S"), error_message)
  expect_error(validate_iso("U$"), error_message)
})

# validate_monitor

test_that("validate_monitor handles valid inputs", {
  expect_no_error(validate_monitor(TRUE))
  expect_no_error(validate_monitor(FALSE))
})

test_that("validate_monitor throws with invalid inputs", {
  error_message <- "Invalid monitor Must be a logical value TRUE or FALSE."
  expect_error(validate_monitor("TRUE"), error_message)
  expect_error(validate_monitor(1), error_message)
  expect_error(validate_monitor(0.5), error_message)
  expect_error(validate_monitor(NULL), error_message)
})

# validate_mobile

test_that("validate_mobile handles valid inputs", {
  expect_no_error(validate_mobile(TRUE))
  expect_no_error(validate_mobile(FALSE))
})

test_that("validate_mobile throws with invalid inputs", {
  error_message <- "Invalid mobile Must be a logical value TRUE or FALSE."
  expect_error(validate_mobile("TRUE"), error_message)
  expect_error(validate_mobile(1), error_message)
  expect_error(validate_mobile(0.5), error_message)
  expect_error(validate_mobile(NULL), error_message)
})

# validate_datetime

test_that("validate_datetime handles valid inputs", {
  valid_datetime <- as.POSIXct("2025-07-04 17:30:00", tz = "America/Denver")
  expect_no_error(validate_datetime(valid_datetime))
})

test_that("validate_datetime throws with invalid inputs", {
  error_message <- "Invalid datetime must be a POSIXct datetime."
  expect_error(validate_datetime("2024-07-04"), error_message)
  expect_error(validate_datetime(1688488200), error_message)
  expect_error(validate_datetime(as.Date("2024-07-04")), error_message)
  expect_error(validate_datetime(NULL), error_message)
})

# validate_data_param

test_that("validate_data_param handles valid inputs", {
  expect_no_error(validate_data_param("measurements"))
  expect_no_error(validate_data_param("hours"))
  expect_no_error(validate_data_param("days"))
  expect_no_error(validate_data_param("years"))
})

test_that("validate_data_param throws with invalid inputs", {
  error_message <- "Invalid data value. Must be one of 'measurements', 'hours', 'days', 'years'."
  expect_error(validate_data_param("invalid_data"), error_message)
  expect_error(validate_data_param(123), error_message)
  expect_error(validate_data_param(TRUE), error_message)
  expect_error(validate_data_param(NULL), error_message)
})


# validate_rollup

test_that("validate_rollup handles valid inputs", {
  expect_no_error(validate_rollup("hourly"))
  expect_no_error(validate_rollup("daily"))
  expect_no_error(validate_rollup("monthly"))
  expect_no_error(validate_rollup("yearly"))
  expect_no_error(validate_rollup("hourofday"))
  expect_no_error(validate_rollup("dayofweek"))
  expect_no_error(validate_rollup("monthofyear"))
  expect_no_error(validate_rollup(NULL))
})

test_that("validate_rollup handles invalid inputs", {
  error_message <- "Invalid rollup Must be one of 'hourly','daily','monthly','yearly','hourofday','dayofweek','monthofyear'." # nolint
  expect_error(validate_rollup("invalid_rollup"), error_message)
  expect_error(validate_rollup(123), error_message)
  expect_error(validate_rollup(TRUE), error_message)
})


# extract_parameters

test_that("extract_parameters returns default values", {
  param_defs <- list(
    param1 = list(default = 10),
    param2 = list(default = "hello")
  )
  result <- extract_parameters(param_defs)
  expect_equal(result, list(param1 = 10, param2 = "hello"))
})

test_that("extract_parameters returns custom values over defaults", {
  param_defs <- list(
    param1 = list(default = 10),
    param2 = list(default = "hello")
  )
  result <- extract_parameters(param_defs, param1 = 5, param2 = "world")
  expect_equal(result, list(param1 = 5, param2 = "world"))
})


test_that("extract_parameters with validator correctly validates", {
  validate_positive <- function(x) {
    if (x <= 0) {
      stop("Value must be positive")
    }
  }

  param_defs <- list(
    param1 = list(default = 10, validator = validate_positive)
  )

  result <- extract_parameters(param_defs, param1 = 5)
  expect_equal(result, list(param1 = 5))
  expect_error(
    extract_parameters(param_defs, param1 = -2),
    "Value must be positive"
  )
})

test_that("extract_parameters with validator and transform works correctly", {
  param_defs <- list(
    date = list(
      default = 10,
      validator = validate_datetime,
      transform = lubridate::format_ISO8601
    )
  )
  date_string <- "2019-07-11T14:00:00-06:00"
  result <- extract_parameters(param_defs, date = as.POSIXct(date_string))
  expect_equal(result, list(date = "2019-07-11T00:00:00"))
})


# list_to_string

test_that("list_to_string collapses numbers correctly", {
  result <- list_to_string(list(1, 2, 3))
  expect_equal(result, "1,2,3")
})

test_that("list_to_string collapses strings correctly", {
  result <- list_to_string(list("1", "2", "3"))
  expect_equal(result, "1,2,3")
})

test_that("list_to_string collapses mixed values correctly", {
  result <- list_to_string(list(1, "2", 3))
  expect_equal(result, "1,2,3")
})


# transform_list_or_item TODO

# parse_openaq_timestamp TODO

# or TODO

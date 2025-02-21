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

# validate_providers_id

test_that("validate_providers_id throws with correct error message", {
  expect_error(
    validate_providers_id("abc"),
    "providers_id must be a numeric vector"
  )
})

# validate_owner_contacts_id

test_that("validate_owner_contacts_id throws with correct error message", {
  expect_error(
    validate_owner_contacts_id("abc"),
    "owner_contacts_id must be a numeric vector"
  )
})

# validate_manufacturers_id

test_that("validate_manufacturers_id throws with correct error message", {
  expect_error(
    validate_manufacturers_id("abc"),
    "manufacturers_id must be a numeric vector"
  )
})

# validate_licenses_id

test_that("validate_licenses_id throws with correct error message", {
  expect_error(
    validate_licenses_id("abc"),
    "licenses_id must be a numeric vector"
  )
})

# validate_instruments_id

test_that("validate_instruments_id throws with correct error message", {
  expect_error(
    validate_instruments_id("abc"),
    "instruments_id must be a numeric vector"
  )
})

# validate_countries_id

test_that("validate_countries_id throws with correct error message", {
  expect_error(
    validate_countries_id("abc"),
    "countries_id must be a numeric vector"
  )
})

# validate_parameters_id

test_that("validate_parameters_id throws with correct error message", {
  expect_error(
    validate_parameters_id("abc"),
    "parameters_id must be a numeric vector"
  )
})

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

test_that("validate_coordinates handles invalid input correctly", {
  expect_error(
    validate_coordinates(c("a", "b")),
    "Invalid point format. Input must be numeric."
  )
  expect_error(
    validate_coordinates(c(1, 2, 3)),
    "Invalid point format. Must be a named numeric vector with 'longitude' and 'latitude'."
  )
  expect_error(
    validate_coordinates(c(1, 2)),
    "Invalid point format. Must be a named numeric vector with 'longitude' and 'latitude'."
  )
  expect_error(
    validate_coordinates(c(x = 1, y = 2)),
    "Invalid point format. Must be a named numeric vector with 'longitude' and 'latitude'."
  )
  expect_error(
    validate_coordinates(c(longitude = "1", latitude = 2)),
    "Invalid point format. Input must be numeric."
  )
  expect_error(
    validate_coordinates(c(longitude = 1, latitude = "2")),
    "Invalid point format. Input must be numeric."
  )
  expect_error(
    validate_coordinates(c(longitude = 200, latitude = 10)),
    "Invalid longitude or latitude. Longitude must be between -180 and 180, and latitude between -90 and 90."
  )
  expect_error(
    validate_coordinates(c(longitude = -200, latitude = 10)),
    "Invalid longitude or latitude. Longitude must be between -180 and 180, and latitude between -90 and 90."
  )
  expect_error(
    validate_coordinates(c(longitude = 10, latitude = 100)),
    "Invalid longitude or latitude. Longitude must be between -180 and 180, and latitude between -90 and 90."
  )
  expect_error(
    validate_coordinates(c(longitude = 10, latitude = -100)),
    "Invalid longitude or latitude. Longitude must be between -180 and 180, and latitude between -90 and 90."
  )
})


test_that("validate_coordinates handles valid input correctly", {
  expect_silent(validate_coordinates(c(longitude = 10, latitude = 20)))
  expect_silent(validate_coordinates(c(longitude = -10, latitude = -20)))
  expect_silent(validate_coordinates(c(longitude = 0, latitude = 0)))
  expect_silent(validate_coordinates(c(longitude = 180, latitude = 90)))
  expect_silent(validate_coordinates(c(longitude = -180, latitude = -90)))
})

# validate_bbox

test_that("validate_bbox handles invalid input correctly - catches non-numeric", {
  expect_error(
    validate_bbox(c("a", "b", "c", "d")),
    "Invalid bounding box format. Input must be numeric."
  )

  expect_error(
    validate_bbox(c(xmin = "1", ymin = 2, xmax = 3, ymax = 4)),
    "Invalid bounding box format. Input must be numeric."
  )
  expect_error(
    validate_bbox(c(xmin = 1, ymin = "2", xmax = 3, ymax = 4)),
    "Invalid bounding box format. Input must be numeric."
  )
})
test_that("validate_bbox handles invalid input correctly - catches non-compliant format", {
  expect_error(
    validate_bbox(c(1, 2, 3)),
    "Invalid bounding box format. Must be a named numeric vector with 'xmin', 'ymin', 'xmax', and 'ymax'."
  )

  expect_error(
    validate_bbox(c(1, 2, 3, 4)),
    "Invalid bounding box format. Must be a named numeric vector with 'xmin', 'ymin', 'xmax', and 'ymax'."
  )

  expect_error(
    validate_bbox(c(x = 1, y = 2, z = 3, w = 4)),
    "Invalid bounding box format. Must be a named numeric vector with 'xmin', 'ymin', 'xmax', and 'ymax'."
  )
})

test_that("validate_bbox handles invalid input correctly - catches out of bounds", {
  expect_error(
    validate_bbox(c(xmin = 2, ymin = 1, xmax = 1, ymax = 2)),
    "Invalid bounding box. xmin must be less than or equal to xmax."
  )

  expect_error(
    validate_bbox(c(xmin = 1, ymin = 2, xmax = 2, ymax = 1)),
    "Invalid bounding box. ymin must be less than or equal to ymax."
  )
})

test_that("validate_bbox handles invalid input correctly - catches invalid lat,lng", {
  expect_error(
    validate_bbox(c(xmin = 200, ymin = 10, xmax = 210, ymax = 20)),
    "Invalid longitude values in bounding box."
  )
  expect_error(
    validate_bbox(c(xmin = -200, ymin = 10, xmax = -190, ymax = 20)),
    "Invalid longitude values in bounding box."
  )
  expect_error(
    validate_bbox(c(xmin = 10, ymin = 100, xmax = 20, ymax = 110)),
    "Invalid latitude values in bounding box."
  )
})


test_that("validate_bbox handles valid input correctly", {
  expect_silent(validate_bbox(c(xmin = 1, ymin = 2, xmax = 3, ymax = 4)))
  expect_silent(validate_bbox(c(xmin = -180, ymin = -90, xmax = 180, ymax = 90))) # Boundary values
  expect_silent(validate_bbox(c(xmin = -10, ymin = -20, xmax = 10, ymax = 20)))
  expect_silent(validate_bbox(c(xmin = 0, ymin = 0, xmax = 0, ymax = 0)))
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


# parse_openaq_timestamp TODO

# or

test_that("or function works as expected", {
  expect_equal(or(c(), "default"), "default")
  expect_equal(or(c(NULL, NULL), 10), 10)
  expect_equal(or(c(NA, NA), "default"), "default")
  expect_equal(or(c(NaN, NaN), 0), 0)
  expect_equal(or(c(1, 2, 3), "default"), c(1, 2, 3))
  expect_equal(or(c(1, NA, 3), "default"), c(1, NA, 3))
})


## deep_get

test_that("deep_get", {
  data <- list(
    a = list(
      b = list(
        c = "value"
      )
    ),
    d = NULL
  )
  expect_equal(deep_get(data, "a"), list(
    b = list(
      c = "value"
    )
  ))
  expect_equal(deep_get(data, "a", "b"), list(
    c = "value"
  ))
  expect_equal(deep_get(data, "a", "b", "c"), "value")
  expect_equal(deep_get(data, "d"), NA)
  expect_equal(deep_get(data, "d", "e"), NA)
  expect_equal(deep_get(data, "d", "e", "f"), NA)
})


# add_headers

test_that("add_headers correctly adds headers", {
  res <- httr2::response(
    status_code = 200,
    headers = list(
      `X-Ratelimit-Used` = "42",
      `X-Ratelimit-Reset` = "43",
      `X-Ratelimit-Limit` = "44",
      `X-RateLimit-Remaining` = "45"
    )
  )
  results <- list(a = "b")
  results <- add_headers(results, res)
  headers <- attr(results, "headers")
  expect_equal(headers[["x_ratelimit_used"]], 42)
  expect_equal(headers[["x_ratelimit_reset"]], 43)
  expect_equal(headers[["x_ratelimit_limit"]], 44)
  expect_equal(headers[["x_ratelimit_remaining"]], 45)
})

fixture_path <- file.path("../../tests/fixtures", "measurements.json")

fixture_data <- jsonlite::fromJSON(fixture_path, simplifyVector = FALSE)

test_that("as.data.frame works", {
  expect_no_error(as.data.frame.openaq_measurements_list(fixture_data))
})

test_that("list_sensor_measurements() works", {
  tz <- "America/New_York"
  vcr::use_cassette("list_sensor_measurements_3", {
    measurements <- list_sensor_measurements(3, datetime_from=as.POSIXct("2023-03-07", tz = tz), datetime_to=as.POSIXct("2023-03-08", tz = tz))
  })
  testthat::expect_type(measurements, "list")
  testthat::expect_true(is.data.frame(measurements))
  testthat::expect_true(nrow(measurements) == 48)
})


test_that("list_sensor_measurements() as list works", {
  tz <- "America/New_York"
  vcr::use_cassette("list_sensor_measurements_3_list", {
    measurements <- list_sensor_measurements(3, datetime_from=as.POSIXct("2023-03-07", tz = tz), datetime_to=as.POSIXct("2023-03-08", tz = tz),  as_data_frame = FALSE)
  })
  testthat::expect_type(measurements, "list")
  testthat::expect_false(is.data.frame(measurements))
  testthat::expect_true(length(measurements) == 48)
})


test_that("list_sensor_measurements() filters to limit", {
  vcr::use_cassette("list_sensor_measurements_limit_5", {
    measurements <- list_sensor_measurements(3, limit = 5)
  })
  expect_equal(nrow(measurements), 5)
})


test_that("get_period_field extracts data correctly", {
  sample_data <- list(period = list(label = "1 hour", value = 3600))
  empty_data <- list(period = NULL)
  missing_key <- list(period = list(value = 3600))
  expect_equal(get_period_field(sample_data, "label"), "1 hour")
  expect_true(is.na(get_period_field(empty_data, "label")))
  expect_true(is.na(get_period_field(missing_key, "label")))
})

test_that("get_summary_field extracts data correctly", {
  sample_data <- list(summary = list(avg = 12.5, max = 20))
  empty_data <- list(other_field = "test")
  expect_equal(get_summary_field(sample_data, "avg"), 12.5)
  expect_true(is.na(get_summary_field(empty_data, "avg")))
  expect_error(get_summary_field(NULL, "avg"), "input 'x' cannot be NULL")
})
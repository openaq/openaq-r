test_that("get_sensor(5) works", {
  vcr::use_cassette("get_sensor_5", {
    sensor <- get_sensor(5)
  })
  testthat::expect_type(sensor, "list")
  testthat::expect_true(is.data.frame(sensor))
  testthat::expect_true(nrow(sensor) == 1)
})

test_that("get_sensor(5) as list works", {
  vcr::use_cassette("get_sensor_5_list", {
    sensor <- get_sensor(5, as_data_frame = FALSE)
  })
  testthat::expect_type(sensor, "list")
  testthat::expect_false(is.data.frame(sensor))
  testthat::expect_true(length(sensor) == 1)
})


test_that("list_location_sensors(3) works", {
  vcr::use_cassette("list_location_sensors_3", {
    sensors <- list_location_sensors(3)
  })
  testthat::expect_type(sensors, "list")
  testthat::expect_true(is.data.frame(sensors))
  testthat::expect_true(nrow(sensors) == 2)
})

test_that("list_location_sensors(3) as list works", {
  vcr::use_cassette("list_location_sensors_3_list", {
    sensors <- list_location_sensors(3, as_data_frame = FALSE)
  })
  testthat::expect_type(sensors, "list")
  testthat::expect_false(is.data.frame(sensors))
  testthat::expect_true(length(sensors) == 2)
})

fixture_path <- file.path("../../tests/fixtures", "sensors.json")

fixture_data <- jsonlite::fromJSON(fixture_path, simplifyVector = FALSE)

test_that("as.data.frame works", {
  expect_no_error(as.data.frame.openaq_sensors_list(fixture_data))
})

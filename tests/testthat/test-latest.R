test_that("list_parameter_latest(2) works", {
  vcr::use_cassette("list_parameter_latest_2", {
    latest <- list_parameter_latest(2)
  })
  testthat::expect_type(latest, "list")
  testthat::expect_true(is.data.frame(latest))
  testthat::expect_true(nrow(latest) == 7)
})

test_that("list_parameter_latest(2) as list works", {
  vcr::use_cassette("list_parameter_latest_2_list", {
    latest <- list_parameter_latest(2, as_data_frame = FALSE)
  })
  testthat::expect_type(latest, "list")
  testthat::expect_false(is.data.frame(latest))
  testthat::expect_true(length(latest) == 7)
})


test_that("list_location_latest(1) works", {
  vcr::use_cassette("list_location_latest_1", {
    latest <- list_location_latest(1)
  })
  testthat::expect_type(latest, "list")
  testthat::expect_true(is.data.frame(latest))
  testthat::expect_true(nrow(latest) == 1)
})

test_that("list_location_latest(1) datetime_min works", {
  t <- as.POSIXct("2025-01-16", tz = "UTC")
  vcr::use_cassette("list_location_latest_1_min", {
    latest <- list_location_latest(1, datetime_min = t)
  })
  testthat::expect_type(latest, "list")
  testthat::expect_true(is.data.frame(latest))
  testthat::expect_true(nrow(latest) == 0)
})

test_that("list_location_latest(1) as list works", {
  vcr::use_cassette("list_location_latest_list", {
    latest <- list_location_latest(1, as_data_frame = FALSE)
  })
  testthat::expect_type(latest, "list")
  testthat::expect_false(is.data.frame(latest))
  testthat::expect_true(length(latest) == 1)
})

fixture_path <- file.path("../../tests/fixtures", "latest.json")

fixture_data <- jsonlite::fromJSON(fixture_path, simplifyVector = FALSE)

test_that("as.data.frame works", {
  expect_no_error(as.data.frame.openaq_latest_list(fixture_data))
})

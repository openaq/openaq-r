test_that("list_parameter_latest(2) works", {
    vcr::use_cassette("list_parameter_latest_2", {
        latest <- list_parameter_latest(2)
    })
    testthat::expect_type(latest, "list")
    testthat::expect_true(is.data.frame(latest))
    testthat::expect_true(nrow(latest) == 7)
})


test_that("list_location_latest() works", {
    vcr::use_cassette("list_location_latest_1", {
        latest <- list_location_latest(1)
    })
    testthat::expect_type(latest, "list")
    testthat::expect_true(is.data.frame(latest))
    testthat::expect_true(nrow(latest) == 1)
})

test_that("list_location_latest() datetime_min works", {
    t <- as.POSIXct("2025-01-16", tz = "UTC")
    vcr::use_cassette("list_location_latest_1_min", {
        latest <- list_location_latest(1, datetime_min = t)
    })
    testthat::expect_type(latest, "list")
    testthat::expect_true(is.data.frame(latest))
    testthat::expect_true(nrow(latest) == 0)
})

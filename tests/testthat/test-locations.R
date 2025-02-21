test_that("get_location(1) works", {
  vcr::use_cassette("get_location_1", {
    location <- get_location(1)
  })
  testthat::expect_type(location, "list")
  testthat::expect_true(is.data.frame(location))
  testthat::expect_true(nrow(location) == 1)
})

test_that("list_locations() works", {
  vcr::use_cassette("list_locations", {
    locations <- list_locations()
  })
  testthat::expect_type(locations, "list")
  testthat::expect_true(is.data.frame(locations))
  testthat::expect_true(nrow(locations) == 6)
})

test_that("get_location(1) as list works", {
  vcr::use_cassette("get_location_1_list", {
    location <- get_location(1, as_data_frame = FALSE)
  })
  testthat::expect_type(location, "list")
  testthat::expect_false(is.data.frame(location))
  testthat::expect_true(length(location) == 1)
})


test_that("list_locations() as list works", {
  vcr::use_cassette("list_locations_list", {
    locations <- list_locations(as_data_frame = FALSE)
  })
  testthat::expect_type(locations, "list")
  testthat::expect_false(is.data.frame(locations))
  testthat::expect_true(length(locations) == 6)
})

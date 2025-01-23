test_that("get_country(9) works", {
  vcr::use_cassette("get_country_9", {
    country <- get_country(9)
  })
  testthat::expect_type(country, "list")
  testthat::expect_true(is.data.frame(country))
  testthat::expect_true(nrow(country) == 1)
})

test_that("list_countries() works", {
  vcr::use_cassette("list_countries", {
    countries <- list_countries()
  })
  testthat::expect_type(countries, "list")
  testthat::expect_true(is.data.frame(countries))
  testthat::expect_true(nrow(countries) == 4)
})

test_that("get_country(9) as list works", {
  vcr::use_cassette("get_country_9_list", {
    country <- get_country(9, as_data_frame = FALSE)
  })
  testthat::expect_type(country, "list")
  testthat::expect_false(is.data.frame(country))
  testthat::expect_true(length(country) == 1)
})


test_that("list_countries() as list works", {
  vcr::use_cassette("list_countries_list", {
    countries <- list_countries(as_data_frame = FALSE)
  })
  testthat::expect_type(countries, "list")
  testthat::expect_false(is.data.frame(countries))
  testthat::expect_true(length(countries) == 4)
})

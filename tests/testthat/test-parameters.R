test_that("get_parameter(2) works", {
  vcr::use_cassette("get_parameter_2", {
    parameter <- get_parameter(2)
  })
  testthat::expect_type(parameter, "list")
  testthat::expect_true(is.data.frame(parameter))
  testthat::expect_true(nrow(parameter) == 1)
})

test_that("list_parameters() works", {
  vcr::use_cassette("list_parameters", {
    parameters <- list_parameters()
  })
  testthat::expect_type(parameters, "list")
  testthat::expect_true(is.data.frame(parameters))
  testthat::expect_true(nrow(parameters) == 1)
})

test_that("get_parameter(2) as list works", {
  vcr::use_cassette("get_parameter_2_list", {
    parameter <- get_parameter(2, as_data_frame = FALSE)
  })
  testthat::expect_type(parameter, "list")
  testthat::expect_false(is.data.frame(parameter))
  testthat::expect_true(length(parameter) == 1)
})


test_that("list_parameters() as list works", {
  vcr::use_cassette("list_parameters_list", {
    parameters <- list_parameters(as_data_frame = FALSE)
  })
  testthat::expect_type(parameters, "list")
  testthat::expect_false(is.data.frame(parameters))
  testthat::expect_true(length(parameters) == 1)
})

test_that("get_instrument(9) works", {
  vcr::use_cassette("get_instrument_9", {
    instrument <- get_instrument(9)
  })
  testthat::expect_type(instrument, "list")
  testthat::expect_true(is.data.frame(instrument))
  testthat::expect_true(nrow(instrument) == 1)
})

test_that("list_instruments() works", {
  vcr::use_cassette("list_instruments", {
    instruments <- list_instruments()
  })
  testthat::expect_type(instruments, "list")
  testthat::expect_true(is.data.frame(instruments))
  testthat::expect_true(nrow(instruments) == 12)
})

test_that("get_instrument(9) as list works", {
  vcr::use_cassette("get_instrument_9_list", {
    instrument <- get_instrument(9, as_data_frame = FALSE)
  })
  testthat::expect_type(instrument, "list")
  testthat::expect_false(is.data.frame(instrument))
  testthat::expect_true(length(instrument) == 1)
})


test_that("list_instruments() as list works", {
  vcr::use_cassette("list_instruments_list", {
    instruments <- list_instruments(as_data_frame = FALSE)
  })
  testthat::expect_type(instruments, "list")
  testthat::expect_false(is.data.frame(instruments))
  testthat::expect_true(length(instruments) == 12)
})

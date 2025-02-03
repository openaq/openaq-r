test_that("get_manufacturer(1) works", {
  vcr::use_cassette("get_manufacturer_1", {
    manufacturer <- get_manufacturer(1)
  })
  testthat::expect_type(manufacturer, "list")
  testthat::expect_true(is.data.frame(manufacturer))
  testthat::expect_true(nrow(manufacturer) == 1)
})

test_that("list_manufacturers() works", {
  vcr::use_cassette("list_manufacturers", {
    manufacturers <- list_manufacturers()
  })
  testthat::expect_type(manufacturers, "list")
  testthat::expect_true(is.data.frame(manufacturers))
  testthat::expect_true(nrow(manufacturers) == 10)
})

test_that("get_manufacturer(1) as list works", {
  vcr::use_cassette("get_manufacturer_1_list", {
    manufacturer <- get_manufacturer(1, as_data_frame = FALSE)
  })
  testthat::expect_type(manufacturer, "list")
  testthat::expect_false(is.data.frame(manufacturer))
  testthat::expect_true(length(manufacturer) == 1)
})


test_that("list_manufacturers() as list works", {
  vcr::use_cassette("list_manufacturers_list", {
    manufacturers <- list_manufacturers(as_data_frame = FALSE)
  })
  testthat::expect_type(manufacturers, "list")
  testthat::expect_false(is.data.frame(manufacturers))
  testthat::expect_true(length(manufacturers) == 10)
})

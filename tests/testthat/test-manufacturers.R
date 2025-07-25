test_that("get_manufacturer(8) works", {
  vcr::use_cassette("get_manufacturer_8", {
    manufacturer <- get_manufacturer(8)
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
  testthat::expect_true(nrow(manufacturers) == 1)
})

test_that("get_manufacturer(8) as list works", {
  vcr::use_cassette("get_manufacturer_8_list", {
    manufacturer <- get_manufacturer(8, as_data_frame = FALSE)
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
  testthat::expect_true(length(manufacturers) == 1)
})

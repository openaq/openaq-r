test_that("get_license(30) works", {
  vcr::use_cassette("get_license_30", {
    license <- get_license(30)
  })
  testthat::expect_type(license, "list")
  testthat::expect_true(is.data.frame(license))
  testthat::expect_true(nrow(license) == 1)
})

test_that("list_licenses() works", {
  vcr::use_cassette("list_licenses", {
    licenses <- list_licenses()
  })
  testthat::expect_type(licenses, "list")
  testthat::expect_true(is.data.frame(licenses))
  testthat::expect_true(nrow(licenses) == 11)
})

test_that("get_license(30) as list works", {
  vcr::use_cassette("get_license_30_list", {
    license <- get_license(30, as_data_frame = FALSE)
  })
  testthat::expect_type(license, "list")
  testthat::expect_false(is.data.frame(license))
  testthat::expect_true(length(license) == 1)
})


test_that("list_licenses() as list works", {
  vcr::use_cassette("list_licenses_list", {
    licenses <- list_licenses(as_data_frame = FALSE)
  })
  testthat::expect_type(licenses, "list")
  testthat::expect_false(is.data.frame(licenses))
  testthat::expect_true(length(licenses) == 11)
})

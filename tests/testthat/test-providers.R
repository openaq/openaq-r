test_that("get_provider(119) works", {
  vcr::use_cassette("get_provider_119", {
    provider <- get_provider(119)
  })
  testthat::expect_type(provider, "list")
  testthat::expect_true(is.data.frame(provider))
  testthat::expect_true(nrow(provider) == 1)
})

test_that("list_providers() works", {
  vcr::use_cassette("list_providers", {
    providers <- list_providers()
  })
  testthat::expect_type(providers, "list")
  testthat::expect_true(is.data.frame(providers))
  testthat::expect_true(nrow(providers) == 1)
})

test_that("get_provider(119) as list works", {
  vcr::use_cassette("get_provider_119_list", {
    provider <- get_provider(119, as_data_frame = FALSE)
  })
  testthat::expect_type(provider, "list")
  testthat::expect_false(is.data.frame(provider))
  testthat::expect_true(length(provider) == 1)
})


test_that("list_providers() as list works", {
  vcr::use_cassette("list_providers_list", {
    providers <- list_providers(as_data_frame = FALSE)
  })
  testthat::expect_type(providers, "list")
  testthat::expect_false(is.data.frame(providers))
  testthat::expect_true(length(providers) == 1)
})

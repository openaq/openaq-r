test_that("get_owner(1) works", {
  vcr::use_cassette("get_owner_1", {
    owner <- get_owner(1)
  })
  testthat::expect_type(owner, "list")
  testthat::expect_true(is.data.frame(owner))
  testthat::expect_true(nrow(owner) == 1)
})

test_that("list_owners() works", {
  vcr::use_cassette("list_owners", {
    owners <- list_owners()
  })
  testthat::expect_type(owners, "list")
  testthat::expect_true(is.data.frame(owners))
  testthat::expect_true(nrow(owners) == 1)
})

test_that("get_owner(1) as list works", {
  vcr::use_cassette("get_owner_1_list", {
    owner <- get_owner(1, as_data_frame = FALSE)
  })
  testthat::expect_type(owner, "list")
  testthat::expect_false(is.data.frame(owner))
  testthat::expect_true(length(owner) == 1)
})


test_that("list_owners() as list works", {
  vcr::use_cassette("list_owners_list", {
    owners <- list_owners(as_data_frame = FALSE)
  })
  testthat::expect_type(owners, "list")
  testthat::expect_false(is.data.frame(owners))
  testthat::expect_true(length(owners) == 1)
})

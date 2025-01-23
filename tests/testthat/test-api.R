# set_api_key

test_that("set_api_key sets env var", {
  withr::with_envvar(
    new = c("OPENAQ_API_KEY" = NA),
    {
      set_api_key("test-api-key-1234")
      api_key <- Sys.getenv("OPENAQ_API_KEY")
      expect_equal(api_key, "test-api-key-1234")
    }
  )
})


# get_api_key

test_that("get_api_key returns value", {
  withr::with_envvar(
    new = c("OPENAQ_API_KEY" = "my-test-api-key"),
    expect_equal(get_api_key(), "my-test-api-key")
  )
})


test_that("get_api_key returns empty value", {
  withr::with_envvar(
    new = c("OPENAQ_API_KEY" = NA),
    expect_equal(get_api_key(), "")
  )
})


# set_base_url

test_that("set_base_url correctly sets variable", {
  withr::with_envvar(
    new = c("OPENAQR_BASE_URL" = NA),
    {
      set_base_url("https://example.com")
      base_url <- Sys.getenv("OPENAQR_BASE_URL")
      expect_equal(base_url, "https://example.com")
    }
  )
})

# get_base_url

test_that("get_base_url returns value", {
  withr::with_envvar(
    new = c("OPENAQR_BASE_URL" = NA),
    {
      Sys.setenv(OPENAQR_BASE_URL = "https://example.com")
      expect_equal(get_base_url(), "https://example.com")
    }
  )
})

test_that("get_base_url returns default value", {
  withr::with_envvar(
    new = c("OPENAQR_BASE_URL" = NA),
    expect_equal(get_base_url(), "https://api.openaq.org")
  )
})


# check_api_key

test_that("check_api_key does not throw", {
  base_url <- "https://api.openaq.org"
  valid_api_key <- "test_valid_api_key"
  expect_no_error(check_api_key(base_url, valid_api_key))
})

test_that("check_api_key throws", {
  base_url <- "https://api.openaq.org"
  expect_error(check_api_key(base_url, NULL))
  expect_error(check_api_key(base_url, ""))
})

test_that("check_api_key throws with correct message", {
  base_url <- "https://api.openaq.org"
  error_message <- capture_message(check_api_key(base_url, ""))
  expect_equal(
    conditionMessage(error_message),
    "A valid API key is required when using the OpenAQ API."
  )
})

# enable_rate_limit



# get_rate_limit




# req_is_transient

test_that("req_is_transient returns TRUE", {
  res <- httr2::response(
    status_code = 429,
    headers = list(`X-RateLimit-Remaining` = "0")
  )
  expect_true(req_is_transient(res))
})

test_that("req_is_transient returns FALSE", {
  res <- httr2::response(
    status_code = 200,
    headers = list(`X-RateLimit-Remaining` = "2")
  )
  expect_false(req_is_transient(res))
})

# req_after

test_that("after returns correct rate limit remaining header value", {
  res <- httr2::response(
    status_code = 429,
    headers = list(`X-RateLimit-Remaining` = "0", `X-RateLimit-Reset` = "45")
  )
  expect_type(req_after(res), "integer")
  expect_equal(req_after(res), 45)
})


test_that("openaq_request throws error", {
  webmockr::enable()
  withr::with_envvar(
    new = c("OPENAQ_API_KEY" = "mock-api-key-for-testing-1234"),
    {
      webmockr::stub_request("get", "https://api.openaq.org/v3/countries") %>%
        webmockr::to_return(body = "failure", status = 401)
      res <- openaq_request("countries", list())
      expect_error(res:status_code)
    }
  )
})

test_that("request throws with incorrect config", {
  expect_error(webmockr::request("countries"))
})

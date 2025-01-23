library("vcr")

vcr_dir <- vcr::vcr_test_path("fixtures")

if (!nzchar(Sys.getenv("OPENAQ_API_KEY"))) {
  if (dir.exists(vcr_dir)) {
    Sys.setenv("OPENAQ_API_KEY" = "test-openaq-api-key-1234")
  } else {
    # If there's no mock files nor API token, impossible to run tests
    stop("No API key nor cassettes, tests cannot be run.",
      call. = FALSE
    )
  }
}

invisible(vcr::vcr_configure(
  dir = vcr_dir,
  filter_sensitive_data = list(
    "<<<test_openaq_api_key>>>" = Sys.getenv("OPENAQ_API_KEY")
  )
))

vcr::check_cassette_names()

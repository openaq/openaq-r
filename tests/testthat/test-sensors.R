fixture_path <- file.path("../../tests/fixtures", "sensors.json")

fixture_data <- jsonlite::fromJSON(fixture_path, simplifyVector = FALSE)

test_that("as.data.frame works", {
  expect_no_error(as.data.frame.openaq_sensors_list(fixture_data))
})

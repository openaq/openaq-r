# openaq v1.0.0 - 2026-02-XX

## Added

- Added `validate_data_rollup_compat()` to validate compatibility between `data`
  and `rollup` parameters in `list_sensor_measurements()`.
- Added tests for `list_sensor_measurements()`, `get_period_field()`,
  `get_summary_field()`, `validate_data_rollup_compat()`, and
  `transform_vector_to_string()`.
- Added `validate_date()` and `transform_date()` to support date-only query
  parameters when `data` is `"days"` or larger. Includes tests for both 
  functions.

## Changed

- Moved `maps` from `Imports` to `Suggests`. World boundary overlay in
  `plot.openaq_locations_data.frame()` is now optional. A message is displayed
  if `maps` is not installed.
- Moved `rstudioapi` from `Imports` to `Suggests`. API key prompting in RStudio
  is now optional with a fallback error message when running outside RStudio.
- Removed `purrr` and `graphics` and `utils` from `Imports`.
- Improved parameter documentation across all resource functions.
- Standardized `isTRUE()` usage for `as_data_frame` checks across all resource
  functions.
- Updated `validate_datetime()` to accept a `name` parameter.
- Updated `list_sensor_measurements()` to use `validate_date()` or
  `validate_datetime()` based on the `data` argument. Tests updated accordingly.

## Fixed

- Fixed missing `dry_run` early return in `list_manufacturer_instruments()`.
- Fixed missing `rate_limit` and `api_key` arguments in `fetch()` calls in
  `list_location_latest()` and `list_parameter_latest()`.
- Fixed wrong class assignment `openaq_licenses_data.frame` in
  `as.data.frame.openaq_manufacturers_list()`.
- Fixed `tbl$avg <- as.numeric(tbl$sd)` typo in
  `as.data.frame.openaq_measurements_list()`, column is now correctly assigned
  to `tbl$sd`.
- Fixed incorrect example function names in `as.data.frame` methods across all
  resource files.
- Fixed `y` parameter missing default `NULL` in `plot.openaq_measurements_data.frame()`
  and `plot.openaq_measurements_list()`.

## Removed

- Removed `list_location_measurements()` function.

# openaq v0.9.0 - 2025-11-21

## Added

- Added additional validation to validate API key.
- Added additional tests

# openaq v0.8.0 - 2025-10-10

## Changed

- added additional validation to `validate_numeric_vectors` to prevent out of bounds integers and doubles
- added additional validation to restrict `radius` parameters to fit within max value of 25000 (25km)

# openaq v0.7.0 - 2025-07-25

## Changed

### BREAKING CHANGES
- renamed `get_location_sensors` to `list_locations_sensors`
- updated minimum package version of httr2 to v1.2.0
- updated minimum package version of vcr to 2.0.0

# openaq v0.6.0 - 2025-07-03

## Changed

- `parameter_names` field in countries resource function as.data.frame fixed to correctly list name values.
- `parameter_ids` field in countries resource function as.data.frame fixed to correctly list ids.
- `instrument_ids` field in manufacturers resource function as.data.frame fixed to correctly list ids.
- `parameter_ids` field in providers resource function as.data.frame fixed to correctly list ids.
- documentation fixes

# openaq v0.5.0 - 2025-04-22

## Changed

- Check `data` parameter to correctly pass `datetime_from` and/or `datetime_to`
 vs `date_to` and `date_from` for `list_sensor_measurements`.

# openaq v0.4.0 - 2025-03-31

## Changed

- Updated plot function signature to meet S3 function generic/method consistency requirements
- removed support for oldrel-4 version

# openaq v0.3.0 - 2025-02-21

## Changed

- *BREAKING CHANGES*
- Changed `providers_id`, `parameters_id`, `owner_contacts_id`,
`manufacturers_id`, `licenses_id`, `instruments_id`, and `countries_id` function
arguments to be numeric vectors
- Changed `coordinates` function argument to be a named numeric vector with
fields `latitude` and `longitude`
- Changed `bbox` function argument to be a named numeric vector with fields
`xmin`, `ymin`, `xmax` and `ymax`.

# openaq v0.2.0 - 2025-02-03

## Added

- Added missing DRY_RUN checks for resource functions.
- `deep_get` function for handling nullable fields in `as.data.frame` methods.
- Rate limit headers added to "headers" property as list.
- Updated User-Agent to include package version.

# openaq v0.1.2 - 2025-01-25

## Added

- Additional null check for possible null value in summary standard
deviation field. Resolved #4

# openaq v0.1.1 - 2025-01-24

## Added

- Fix null check in parameters_list.as.data.frame to catch null values in
results object.
- `dry_run` check in licenses resource functions

# openaq v0.1.0 - 2025-01-23

Initial release

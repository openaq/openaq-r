# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## v0.6.0 - 2025-07-03

### Changed

- `parameter_names` field in countries resource function as.data.frame fixed to correctly list name values.
- `parameter_ids` field in countries resource function as.data.frame fixed to correctly list ids.
- `instrument_ids` field in manufacturers resource function as.data.frame fixed to correctly list ids.
- `parameter_ids` field in providers resource function as.data.frame fixed to correctly list ids.
- documentation fixes

## v0.5.0 - 2025-04-22

### Changed

- Check `data` parameter to correctly pass `datetime_from` and/or `datetime_to`
 vs `date_to` and `date_from` for `list_sensor_measurements`.

## v0.4.0 - 2025-03-31

### Changed

- Updated plot function signature to meet S3 function generic/method consistency requirements
- removed support for oldrel-4 version

## v0.3.0 - 2025-02-21

### Changed

- *BREAKING CHANGES*
- Changed `providers_id`, `parameters_id`, `owner_contacts_id`,
`manufacturers_id`, `licenses_id`, `instruments_id`, and `countries_id` function
arguments to be numeric vectors
- Changed `coordinates` function argument to be a named numeric vector with
fields `latitude` and `longitude`
- Changed `bbox` function argument to be a named numeric vector with fields
`xmin`, `ymin`, `xmax` and `ymax`.

## v0.2.0 - 2025-02-03

### Added

- Added missing DRY_RUN checks for resource functions.
- `deep_get` function for handling nullable fields in `as.data.frame` methods.
- Rate limit headers added to "headers" property as list.
- Updated User-Agent to include package version.

## v0.1.2 - 2025-01-25

### Added

- Additional null check for possible null value in summary standard
deviation field. Resolved #4

## v0.1.1 - 2025-01-24

### Added

- Fix null check in parameters_list.as.data.frame to catch null values in
results object.
- `dry_run` check in licenses resource functions

## v0.1.0 - 2025-01-23

Initial release

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

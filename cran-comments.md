## Test environments

* local: macOS 15.x (aarch64), R 4.5.x (and devel)
* GitHub Actions (ubuntu-latest): R-devel, R-release, R-oldrel-1, R-oldrel-2, R-oldrel-3
* GitHub Actions (windows-latest): R-release, R-oldrel-1, R-oldrel-2
* GitHub Actions (macos-latest): R-release

## R CMD check results

0 errors | 0 warnings | 0 notes

## Summary of changes in this version

* Added `disable_rate_limit()` for setting the `RATE_LIMIT` environment
  variable to `FALSE`.
* Updated datetime validation, parameter extraction, and timestamp parsing
  to gracefully handle `NA`/`"NA"` values.
* Changed the default for the `RATE_LIMIT` environment variable to `TRUE`.
* Changed the package license from MIT to Apache License 2.0.

## Vignettes

The vignettes are pre-compiled because they require OpenAQ API authentication.
The .Rmd files are generated from .Rmd.orig source files, which are included
in the package for transparency.

## Downstream dependencies

There are currently no downstream dependencies for this package.

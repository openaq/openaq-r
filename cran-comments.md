## Test environments

* local: macOS 26.2 (aarch64-apple-darwin20), R 4.5.0
* GitHub Actions (ubuntu-latest): R-devel, R-release, R-oldrel-1, R-oldrel-2, R-oldrel-3
* GitHub Actions (windows-latest): R-release, R-oldrel-1, R-oldrel-2  
* GitHub Actions (macos-latest): R-release

## R CMD check results

0 errors ✔ | 0 warnings ✔ | 2 notes ✖

NOTES:

* New submission

* Checking vignettes reports a 'figure' directory that looks like a leftover
  from knitr. This directory contains plots for pre-compiled vignettes and is
  required. The vignettes demonstrate functionality requiring OpenAQ API
  authentication, so they are pre-compiled locally with results embedded.
  The figure directory must be included for the vignettes to display correctly.

## Vignettes

Vignettes are pre-compiled because they require OpenAQ API authentication.
The vignettes are built from source using real API calls locally, then the
compiled .Rmd files with embedded results and associated figures are included
in the package. This ensures vignettes can be built on CRAN without requiring
API credentials.

## Downstream dependencies

There are currently no downstream dependencies for this package.

## Test environments

* local: macOS 15.2 (aarch64), R 4.5.0 (and devel)
* GitHub Actions (ubuntu-latest): R-devel, R-release, R-oldrel-1, R-oldrel-2, R-oldrel-3
* GitHub Actions (windows-latest): R-release, R-oldrel-1, R-oldrel-2  
* GitHub Actions (macos-latest): R-release

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a resubmission. See resubmission notes below.

## Vignettes

The vignettes are pre-compiled because they require OpenAQ API authentication.
The .Rmd files are generated from .Rmd.orig source files, which are included
in the package for transparency.

## Downstream dependencies

There are currently no downstream dependencies for this package.

## Resubmission

* Fixed invalid file URIs in README.md: DEVELOPMENT.md and CONTRIBUTING.md
  now use full GitHub URLs.
* Quoted 'OpenAQ' in the Title and Description fields of DESCRIPTION. Note
  that OpenAQ is an organization name, but it also serves as the API name,
  so quoting has been applied per reviewer feedback.

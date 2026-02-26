## Test environments

* local: macOS 15.2 (aarch64), R 4.5.0 (and devel)
* GitHub Actions (ubuntu-latest): R-devel, R-release, R-oldrel-1, R-oldrel-2, R-oldrel-3
* GitHub Actions (windows-latest): R-release, R-oldrel-1, R-oldrel-2  
* GitHub Actions (macos-latest): R-release

## R CMD check results

0 errors | 0 warnings | 2 notes

* This is a new submission.

* NOTE: 'checking files in ‘vignettes’ ... NOTE. The following directory looks like a leftover from 'knitr': ‘figure’'
  
  The 'figure' directory contains static plots generated for pre-compiled
  vignettes. The vignettes interact with the OpenAQ API which requires
  authentication and cannot be run during CRAN checks. Vignettes have been
  pre-compiled locally from .Rmd.orig source files, which are included in
  the package for transparency. All files have been manually inspected.

## Vignettes

The vignettes are pre-compiled because they require OpenAQ API authentication.
The .Rmd files are generated from .Rmd.orig source files. The .Rmd.orig files
are included in .Rbuildignore.

## Downstream dependencies

There are currently no downstream dependencies for this package.

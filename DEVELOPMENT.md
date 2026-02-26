# Development Guide

This guide covers how to set up, build, test, and document the `openaq` R
package locally.

## Prerequisites

- R >= 4.1.0
- [devtools](https://devtools.r-lib.org/)
- [roxygen2](https://roxygen2.r-lib.org/)
- An OpenAQ API key set as the environment variable `OPENAQ_API_KEY`

## Getting Started

Clone the repository and install dependencies:

```r
install.packages("devtools")
devtools::install_deps(dependencies = TRUE)
```

## Building

Build the package tarball:

```sh
R CMD build .
```

Or using `devtools`:

```r
devtools::build()
```

To check the package against CRAN rules:

```r
devtools::check(cran = TRUE)
```

## Tests

Tests use the [`testthat`](https://testthat.r-lib.org/) framework with
[`vcr`](https://docs.ropensci.org/vcr/) and
[`webmockr`](https://docs.ropensci.org/webmockr/) for fixture-based mocking.

For full details on running tests, recording cassettes, and coverage, see the
[Testing Guide](./test/README.md).

## Documentation

Documentation is generated from roxygen2 comments. To build:

```r
devtools::document()
```

### Vignettes

Vignettes are precompiled because they require OpenAQ API authentication and
cannot be built in a standard CRAN check environment. See
`vignettes/README.md` for details on rebuilding vignettes from source.

## Code Style

Code style is enforced using [`lintr`](https://lintr.r-lib.org/). To check 
locally:

```r
lintr::lint_package()
```

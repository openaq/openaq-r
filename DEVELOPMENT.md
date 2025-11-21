# Local development

## Building

building the package

``` sh
R CMD build .
```

## Testing

### Setup

Testing uses `vcr` and `webmockr` for saving and mocking API results for
reproducable offline tests.

Test fixtures are built from the local build of the openaq-db, and so
only contain a subset of data as compared to the full local setup.

To record `vcr` cassettes set up a local instance of the [OpenAQ
DB](https://github.com/openaq/openaq-db) and the [OpenAQ
API](https://github.com/openaq/openaq-api-v2) and uncomment the line in
[helper-vcr.R](https://openaq.github.io/openaq-r/'./test/testthat/helper-vcr.R')
to set the base URL to the local API address e.g.
`set_base_url('http://localhost:8000')` (or whichever port is used by
the local instance of the API)

Tests can be run in the R REPL with:

### Running tests

``` r
devtools::test()
```

or from a standard shell using `Rscript`:

``` sh
Rscript -e "devtools::test()"
```

## Documentation

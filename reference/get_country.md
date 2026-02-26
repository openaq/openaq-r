# Get a single country from countries resource.

Get a single country from countries resource.

## Usage

``` r
get_country(
  countries_id,
  as_data_frame = TRUE,
  dry_run = FALSE,
  rate_limit = FALSE,
  api_key = NULL
)
```

## Arguments

- countries_id:

  An integer representing the OpenAQ countries_id.

- as_data_frame:

  A logical for toggling whether to return results as data frame or
  list, default is `TRUE`.

- dry_run:

  A logical for toggling a dry run of the request, default is `FALSE.`

- rate_limit:

  A logical for toggling automatic rate limiting based on rate limit
  headers, default is `FALSE`.

- api_key:

  A valid OpenAQ API key string, default is `NULL`.

## Value

A data frame or list of the results.

## Examples

``` r
if (FALSE) { # interactive()
country <- get_country(42)
}
```

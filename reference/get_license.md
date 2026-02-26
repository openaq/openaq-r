# Get a single license from the licenses resource.

Get a single license from the licenses resource.

## Usage

``` r
get_license(
  licenses_id,
  as_data_frame = TRUE,
  dry_run = FALSE,
  rate_limit = FALSE,
  api_key = NULL
)
```

## Arguments

- licenses_id:

  An integer representing the OpenAQ licenses_id.

- as_data_frame:

  A logical for toggling whether to return results as data frame or
  list, default is `TRUE`.

- dry_run:

  A logical for toggling a dry run of the request, default is `FALSE`.

- rate_limit:

  A logical for toggling automatic rate limiting based on rate limit
  headers, default is `FALSE`.

- api_key:

  A valid OpenAQ API key string, default is `NULL`.

## Value

A data frame or a list of the results.

## Examples

``` r
if (FALSE) { # interactive()
license <- get_license(42)
}
```

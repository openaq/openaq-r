# get a single license from the licenses resource.

get a single license from the licenses resource.

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

  An integer.

- as_data_frame:

  A logical for toggling whether to return results as data frame or list
  default is `TRUE`.

- dry_run:

  A logical for toggling a dry run of the request, defaults to `FALSE`.

- rate_limit:

  A logical for toggling automatic rate limiting based on rate limit
  headers, default is `FALSE`.

- api_key:

  A valid OpenAQ API key string, default is `NULL`.

## Value

A data frame.

## Examples

``` r
if (FALSE) { # interactive()
license <- get_license(42)
}
```

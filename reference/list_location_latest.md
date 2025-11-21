# Get the latest measurements by locations_id.

Get the latest measurements by locations_id.

## Usage

``` r
list_location_latest(
  locations_id,
  datetime_min = NULL,
  limit = NULL,
  page = NULL,
  as_data_frame = TRUE,
  dry_run = FALSE,
  rate_limit = FALSE,
  api_key = NULL
)
```

## Arguments

- locations_id:

  An integer.

- datetime_min:

  A string.

- limit:

  An integer.

- page:

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

A data frame or a list of the results.

## Examples

``` r
if (FALSE) { # interactive()
measurements <- list_location_latest(2178)
}
```

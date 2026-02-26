# Get a single manufacturer from the manufacturers resource.

Get a single manufacturer from the manufacturers resource.

## Usage

``` r
get_manufacturer(
  manufacturers_id,
  as_data_frame = TRUE,
  dry_run = FALSE,
  rate_limit = FALSE,
  api_key = NULL
)
```

## Arguments

- manufacturers_id:

  An integer representing the OpenAQ manufacturers_id.

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
manufacturer <- get_manufacturer(42)
}
```

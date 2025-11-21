# Get a list of countries from the countries resource.

Get a list of countries from the countries resource.

## Usage

``` r
list_countries(
  providers_id = NULL,
  parameters_id = NULL,
  order_by = NULL,
  sort_order = NULL,
  limit = NULL,
  page = NULL,
  as_data_frame = TRUE,
  dry_run = FALSE,
  rate_limit = FALSE,
  api_key = NULL
)
```

## Arguments

- providers_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  providers to use for filtering results. If multiple IDs are provided,
  results matching any of the IDs will be returned.

- parameters_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  parameters to use for filtering results. If multiple IDs are provided,
  results matching any of the IDs will be returned.

- order_by:

  A string.

- sort_order:

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
countries <- list_countries()
}
```

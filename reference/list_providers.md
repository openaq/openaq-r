# Get a list of providers from the providers resource.

Get a list of providers from the providers resource.

## Usage

``` r
list_providers(
  order_by = NULL,
  sort_order = NULL,
  limit = 100,
  page = 1,
  as_data_frame = TRUE,
  dry_run = FALSE,
  rate_limit = FALSE,
  api_key = NULL
)
```

## Arguments

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
providers <- list_providers()
}
```

# Get a list of owners from the owners resource.

Get a list of owners from the owners resource.

## Usage

``` r
list_owners(
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

- order_by:

  A string specifying the field to order results by.

- sort_order:

  A string specifying sort direction, either `"asc"` or `"desc"`.

- limit:

  An integer specifying the maximum number of results to return, default
  is `100`.

- page:

  An integer specifying the page number for paginated results, default
  is `1`.

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
owners <- list_owners()
}
```

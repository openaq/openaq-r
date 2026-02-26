# Get the latest measurements by parameters_id.

Get the latest measurements by parameters_id.

## Usage

``` r
list_parameter_latest(
  parameters_id,
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

- parameters_id:

  An integer representing the OpenAQ parameters_id

- datetime_min:

  A string specifying the minimum datetime for filtering results,
  default is `NULL`.

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
measurements <- list_parameter_latest(2)
}
```

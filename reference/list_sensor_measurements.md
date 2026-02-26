# Get a list of measurements by sensors_id.

Get a list of measurements by sensors_id.

## Usage

``` r
list_sensor_measurements(
  sensors_id,
  data = "measurements",
  rollup = NULL,
  datetime_from = NULL,
  datetime_to = NULL,
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

- sensors_id:

  An integer representing an OpenAQ sensors_id.

- data:

  A string a data interval to return, default is "measurements".

- rollup:

  A string representing the aggregation rollup, default is `NULL`.

- datetime_from:

  A POSIXct datetime (when `data` is `"measurements"` or `"hours"`) or a
  Date (when `data` is `"days"` or larger) to filter from, default is
  `NULL`.

- datetime_to:

  A POSIXct datetime (when `data` is `"measurements"` or `"hours"`) or a
  Date (when `data` is `"days"` or larger) to filter to, default is
  `NULL`.

- order_by:

  A string representing the field to order by, default is `NULL`.

- sort_order:

  A string, either "asc" or "desc", default is `NULL`.

- limit:

  An integer representing the number of results per page.

- page:

  An integer representing the page number.

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
measurements <- list_sensor_measurements(3920, "hours")
}
```

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

  A string a data interval to return, defaults to "measurements".

- rollup:

  A string.

- datetime_from:

  A POSIXct datetime to filter measurements

- datetime_to:

  A POSIXct datetime to filter measurements

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
measurements <- list_sensor_measurements(3920, "hours")
}
```

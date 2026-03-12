# Method for converting openaq_latest_list to data frame.

Method for converting openaq_latest_list to data frame.

## Usage

``` r
# S3 method for class 'openaq_latest_list'
as.data.frame(x, row.names = NULL, optional = FALSE, ...)
```

## Arguments

- x:

  A list of latest measurements as returned from list_location_latest or
  list_parameter_latest.

- row.names:

  `NULL` or a character vector giving the row names for the data frame.
  Missing values are not allowed.

- optional:

  logical. If TRUE, setting row names and converting column names (to
  syntactic names: see make.names) is optional. Note that all of R's
  base package as.data.frame() methods use optional only for column
  names treatment, basically with the meaning of data.frame(\*,
  check.names = !optional). See also the make.names argument of the
  matrix method.

- ...:

  additional arguments to be passed to or from methods.

## Value

A data frame class of the latest results, with the following columns:

- sensors_id:

  Numeric. The sensors identifier.

- locations_id:

  Numeric. The locations identifier.

- value:

  Numeric. The measurement value.

- datetime_local:

  POSIXct. The datetime of the measurement value, in local time

- datetime_utc:

  POSIXct. The datetime of the measurement value, in UTC time

- latitude:

  Numeric. The latitude, geographic Y, value for the measurement.

- longitude:

  Numeric. The longitude, geographic X, value for the measurement.

The data frame also includes a `meta` attribute from the original
`openaq_latest_list`.

## Examples

``` r
if (FALSE) { # interactive()
latest <- list_location_latest(2178, as_data_frame = FALSE)
as.data.frame(latest)
}
```

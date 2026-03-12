# Method for converting openaq_measurements_list to data frame.

Method for converting openaq_measurements_list to data frame.

## Usage

``` r
# S3 method for class 'openaq_measurements_list'
as.data.frame(x, row.names = NULL, optional = FALSE, ...)
```

## Arguments

- x:

  A list of measurements as returned from list_sensor_measurements.

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

A data frame class of the measurements results, with the following
columns:

- value:

  Numeric. The measurement value.

- parameter_id:

  Numeric. The parameter identifier for the measurement.

- parameter_name:

  Character. The name of the measured parameter.

- parameter_units:

  Character. The units of the measured parameter.

- period_label:

  Factor. The label describing the measurement period (e.g. "hour",
  "day").

- period_interval:

  Factor. The period of the measurement interval in HH:MM:SS format
  (e.g. "01:00:00").

- datetime_from:

  POSIXct. The start datetime of the measurement period in local time.

- datetime_to:

  POSIXct. The end datetime of the measurement period in local time.

- latitude:

  Numeric. The latitude, geographic Y, value for the measurement.

- longitude:

  Numeric. The longitude, geographic X, value for the measurement.

- min:

  Numeric. The minimum value within the measurement period.

- q02:

  Numeric. The 2nd percentile value within the measurement period.

- q25:

  Numeric. The 25th percentile value within the measurement period.

- median:

  Numeric. The median value within the measurement period.

- q75:

  Numeric. The 75th percentile value within the measurement period.

- q98:

  Numeric. The 98th percentile value within the measurement period.

- max:

  Numeric. The maximum value within the measurement period.

- avg:

  Numeric. The average value within the measurement period.

- sd:

  Numeric. The standard deviation of values within the measurement
  period.

- expected_count:

  Numeric. The expected number of measurements within the period.

- expected_interval:

  Factor. The expected measurement interval in HH:MM:SS format (e.g.
  "01:00:00").

- observed_count:

  Numeric. The observed number of measurements within the period.

- observed_interval:

  Factor. The observer measurement interval in HH:MM:SS format (e.g.
  "01:00:00").

- percent_complete:

  Numeric. The percentage of expected measurements that were observed.

- percent_coverage:

  Numeric. The percentage of time coverage for the measurement period.

The data frame also includes a `meta` attribute from the original
`openaq_measurements_list`.

## Examples

``` r
if (FALSE) { # interactive()
meas <- list_sensor_measurements(23707, limit = 500, as_data_frame = FALSE)
as.data.frame(meas)
}
```

# Method for converting openaq_sensors_list to data frame.

Method for converting openaq_sensors_list to data frame.

## Usage

``` r
# S3 method for class 'openaq_sensors_list'
as.data.frame(x, row.names = NULL, optional = FALSE, ...)
```

## Arguments

- x:

  A list of sensors as returned from get_sensor or
  list_location_sensors.

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

A data frame class of the sensors results, with the following columns:

- id:

  Numeric. The sensors identifier.

- name:

  Character.

- parameters_id:

  Numeric. .

- datetime_first_utc:

  POSIXct. The datetime of the first measurement in UTC.

- datetime_first_local:

  POSIXct. The datetime of the first measurement in local time.

- datetime_last_utc:

  POSIXct. The datetime of the last measurement in UTC.

- datetime_last_local:

  POSIXct. The datetime of the last measurement in local time.

- min:

  Numeric. The minimum measurement value recorded by the sensor.

- max:

  Numeric. The maximum measurement value recorded by the sensor.

- avg:

  Numeric. The average measurement value recorded by the sensor.

- expected_count:

  Numeric. The expected number of measurements for the sensor.

- expected_interval:

  Factor. The expected measurement interval in HH:MM:SS format (e.g.
  "01:00:00").

- observed_count:

  Numeric. The observed number of measurements for the sensor.

- observed_interval:

  Factor. The observed measurement interval in HH:MM:SS format (e.g.
  "01:00:00").

- percent_complete:

  Numeric. The percentage of expected measurements that were observed.

- percent_coverage:

  Numeric. The percentage of time coverage for the sensor.

- latest_value:

  Numeric. The most recent measurement value from the sensor.

- latest_datetime:

  POSIXct. The datetime of the most recent measurement.

- latest_latitude:

  Numeric. The latitude of the most recent measurement location.

- latest_longitude:

  Numeric. The longitude of the most recent measurement location

The data frame also includes a `meta` attribute from the original
`openaq_sensors_list`.

## Examples

``` r
if (FALSE) { # interactive()
sensor <- get_sensor(42, as_data_frame = FALSE)
as.data.frame(sensor)
}
```

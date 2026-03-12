# Method for converting openaq_locations_list to data frame.

Method for converting openaq_locations_list to data frame.

## Usage

``` r
# S3 method for class 'openaq_locations_list'
as.data.frame(x, row.names = NULL, optional = FALSE, ...)
```

## Arguments

- x:

  A list of locations as returned from list_locations.

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

A data frame class of the locations results, with the following columns:

- id:

  Numeric. The locations identifier.

- name:

  Character. The name of the location.

- is_mobile:

  Logical. Indicates whether the location is stationary or mobile.

- is_monitor:

  Logical. Indicates whether the location is considered a reference
  monitor.

- timezone:

  Factor. The IANA timezone of the location (e.g. "America/New_York").

- countries_id:

  Numeric. The countries identifier where the location is located.

- country_name:

  Character. The name of the country where the location is located

- country_iso:

  Factor. The ISO 3166-1 alpha-2 country code where the location is
  located

- latitude:

  Numeric.The latitude, geographic Y, value for the measurement.

- longitude:

  Numeric. The longitude, geographic X, value for the measurement.

- datetime_first:

  POSIXct. The datetime of the first measurement of this location.

- datetime_last:

  POSIXct. The datetime of the last measurement of this location.

- owner_name:

  Factor. The name of the owner of the location.

- providers_id:

  Numeric. The providers identifier for the location.

- provider_name:

  Character. The name of the provider for the location.

The data frame also includes a `meta` attribute from the original
`openaq_locations_list`.

## Examples

``` r
if (FALSE) { # interactive()
loc <- list_locations(as_data_frame = FALSE)
as.data.frame(loc)
}
```

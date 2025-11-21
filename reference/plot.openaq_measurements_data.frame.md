# Helper for plotting measurements

Helper for plotting measurements

## Usage

``` r
# S3 method for class 'openaq_measurements_data.frame'
plot(x, y, ...)
```

## Arguments

- x:

  A data frame of measurements results.

- y:

  default is `NULL`

- ...:

  Other options to be passed on to base::plot().

## Examples

``` r
if (FALSE) { # interactive()
meas <- list_sensor_measurements(23707, limit = 500, as_data_frame = FALSE)
plot(meas)
}
```

# Helper for plotting measurements from list

Helper for plotting measurements from list

## Usage

``` r
# S3 method for class 'openaq_measurements_list'
plot(x, y, ...)
```

## Arguments

- x:

  A list of measurements results.

- y:

  Other data

- ...:

  Other options to be passed on to base::plot().

## Examples

``` r
if (FALSE) { # interactive()
meas <- list_sensor_measurements(23707, limit = 500, as_data_frame = FALSE)
plot(meas)
}
```

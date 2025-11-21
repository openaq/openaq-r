# Helper for plotting locations from list.

Helper for plotting locations from list.

## Usage

``` r
# S3 method for class 'openaq_locations_list'
plot(x, y = NULL, ...)
```

## Arguments

- x:

  A list of locations results.

- y:

  default is `NULL`

- ...:

  Other options passed on to base::plot().

## Examples

``` r
if (FALSE) { # interactive()
loc <- list_locations(limit = 6, as_data_frame = FALSE)
plot(loc, pch = 19, col = 2)
}
```

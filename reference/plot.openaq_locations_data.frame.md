# Helper for plotting locations on map.

Plots location coordinates. If the `maps` package is installed, a world
boundary overlay is added. Install with `install.packages("maps")`.

## Usage

``` r
# S3 method for class 'openaq_locations_data.frame'
plot(x, y = NULL, ...)
```

## Arguments

- x:

  the coordinates of points in the plot. Alternatively, a single
  plotting structure, function or any R object with a plot method can be
  provided.

- y:

  the y coordinates of points in the plot, optional if x is an
  appropriate structure.

- ...:

  Other options passed on to base::plot().

## Examples

``` r
if (FALSE) { # interactive()
df <- list_locations(limit = 100)
plot(df, pch = 19, col = df$provider_name)
}
```

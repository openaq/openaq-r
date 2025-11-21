# Geospatial Queries

``` r
library(openaq)
library(sf)
library(maps)
```

The OpenAQ API has the ability to perform geospatial queries, enabling
you to retrieve data based on location. This vignette will guide you
through the two primary geospatial query methods available in `openaq`:
point and radius searches, and bounding box searches.

`openaq` provides access to two methods for querying locations on the
OpenAQ platform geospatially:

1.  Point and Radius: Searches around a given point coordinate
    (latitude, longitude) at a specified radius in meters. This is ideal
    for finding air quality data within a certain distance of a specific
    location.

2.  Bounding Box: Searches within a spatial bounding box defined as a
    list of four coordinates: `xmin`, `ymin`, `xmax`, and `ymax`. This
    method is useful for querying data within a rectangular area.

## Point and Radius

The `list_location()` function allows you to search for locations near a
given point. You provide the latitude and longitude of the center point,
as well as the radius within which to search. The radius is specified in
meters, with a maximum value of 25,000 (25 kilometers).

``` r
list_locations(
  coordinates = c(latitude = -73.0666, longitude = -36.7724), # the coordinates in Concepción, Chile.
  radius = 10000 # 10,000 meters or 10 kilometers
)
```

In this example, we are searching for locations within a 10 kilometer
radius of the specified latitude and longitude. The result will be a
list of locations that fall within this circular area.

## Bounding box

For queries covering a rectangular area, you can use the
[`list_locations()`](https://openaq.github.io/openaq-r/reference/list_locations.md)
function with the bbox argument. You need to provide the minimum and
maximum longitude (`xmin`, `xmax`) and latitude (`ymin`, `ymax`) values
that define the corners of your bounding box.

``` r
list_locations(
  bbox = c(
    xmin = -8.478184,
    ymin = 26.640174,
    xmax = 50.803066,
    ymax = 46.534067
  )
)
```

This query will return all locations within the defined rectangular
region.

``` r
bbox_coords <- c(-8.478184, 26.640174, 50.803066, 46.534067)
names(bbox_coords) <- c("xmin", "ymin", "xmax", "ymax")
bbox <- st_as_sfc(st_bbox(bbox_coords), crs = 4326)
world_sp <- maps::map("world", plot = FALSE, fill = TRUE)
world_sf <- st_as_sf(world_sp)
plot(st_geometry(world_sf), col = "lightgray", border = "black", xlim = st_bbox(bbox)[c("xmin", "xmax")], ylim = st_bbox(bbox)[c("ymin", "ymax")])
plot(st_geometry(bbox), lwd = 2, add = TRUE)
```

![The map above visually represents the bounding box used in the example
query.](figure/bbox-example-plot-1.png)

The map above visually represents the bounding box used in the example
query.

### Computing a bounding box from a polygon

Often, you’ll want to query data within a specific geographic area
defined by a polygon, rather than a simple rectangle. Real-world
boundaries are often complex shapes. For instance, consider the boundary
of the city of Los Angeles, which has a complex, irregular shape.

``` r
url <- "https://maps.lacity.org/lahub/rest/services/Boundaries/MapServer/7/query?outFields=*&where=1%3D1&f=geojson"
la <- sf::st_read(url)
```

``` r
plot(la["OBJECTID"])
```

![plot of chunk
los-angeles-boundaries-plot](figure/los-angeles-boundaries-plot-1.png)

plot of chunk los-angeles-boundaries-plot

We can use the `sf` package to read the GeoJSON data representing the
city boundary.

To derive a bounding box from this polygon, we can use the
[`sf::st_bbox()`](https://r-spatial.github.io/sf/reference/st_bbox.html)
method. This function calculates the minimum and maximum x and y
coordinates of the polygon, effectively creating a bounding box that
encompasses the entire shape. The output is a named numeric vector,
perfectly formatted for the bbox parameter in the `openaq` function.

``` r
bbox <- sf::st_bbox(la)
bbox
#>       xmin       ymin       xmax       ymax 
#> -118.66819   33.70366 -118.15537   34.33731
```

This output gives you the xmin, ymin, xmax, and ymax values needed for
your `openaq` query.

``` r
bbox <- sf::st_bbox(la)
world_sp <- maps::map("county", plot = FALSE, fill = TRUE)
world_sf <- st_as_sf(world_sp)
plot(
  st_geometry(world_sf),
  col = "lightgray",
  border = "black",
  xlim = st_bbox(bbox)[c("xmin", "xmax")],
  ylim = st_bbox(bbox)[c("ymin", "ymax")]
)
plot(sf::st_as_sfc(bbox), lwd = 2, lty = 2, add = TRUE)
plot(st_geometry(la), lwd = 2, add = TRUE)
```

![Los Angeles city boundary with bounding
box](figure/los-angeles-bbox-map-1.png)

Los Angeles city boundary with bounding box

This map shows the Los Angeles city boundary along with the calculated
bounding box.

``` r
locations <- list_locations(
  bbox = bbox
)
```

``` r
plot(
  st_geometry(world_sf),
  col = "lightgray",
  border = "black",
  xlim = st_bbox(bbox)[c("xmin", "xmax")],
  ylim = st_bbox(bbox)[c("ymin", "ymax")]
)
plot(st_geometry(la), lwd = 2, add = TRUE)
plot(sf::st_as_sfc(bbox), lwd = 2, lty = 2, add = TRUE)
points(locations$longitude, locations$latitude, col = "#6a5cd8", pch = 15)
```

![Los Angeles city boundary with bounding box and OpenAQ
locations](figure/los-angeles-bbox-query-plot-1.png)

Los Angeles city boundary with bounding box and OpenAQ locations

Now, you can directly use the `bbox` object generated by
[`sf::st_bbox()`](https://r-spatial.github.io/sf/reference/st_bbox.html)
in your
[`list_locations()`](https://openaq.github.io/openaq-r/reference/list_locations.md)
call. This will retrieve air quality data within the bounding box that
encompasses the city of Los Angeles.

For a detailed explanation about how the OpenAQ API works with these
methods, see the official OpenAQ API documentation at
<https://docs.openaq.org/using-the-api/geospatial>. This documentation
provides further information on the available parameters and how to
optimize your geospatial queries.

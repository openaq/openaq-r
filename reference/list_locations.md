# Get a list of locations from the locations resource.

Get a list of locations from the locations resource.

## Usage

``` r
list_locations(
  bbox = NULL,
  coordinates = NULL,
  radius = NULL,
  providers_id = NULL,
  parameters_id = NULL,
  owner_contacts_id = NULL,
  manufacturers_id = NULL,
  licenses_id = NULL,
  monitor = NULL,
  mobile = NULL,
  instruments_id = NULL,
  iso = NULL,
  countries_id = NULL,
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

- bbox:

  Named numeric vector with four coordinates in form X minimum, Y
  minimum, X maximum, Y maximum, named values must be `xmin`, `ymin`,
  `ymax` , `xmax`. default is `NULL`.

- coordinates:

  Named numeric vector with two numeric WGS84 (EPSG:4326) geographic
  coordinates, with named values `latitude` and `longitude`. Represents
  the central point to be used in conjunction with the radius parameter
  for geographic search. default is `NULL`.

- radius:

  An integer for the number of meters to search around the `coordinates`
  parameter for filtering locations within the radius. Value must be
  greater than zero and less than 25000 (25km). default is `NULL`.

- providers_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  provider(s) to use for filtering results. If multiple IDs are
  provided, results matching any of the IDs will be returned. default is
  `NULL`.

- parameters_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  parameter(s) to use for filtering results. If multiple IDs are
  provided, results matching any of the IDs will be returned. default is
  `NULL`.

- owner_contacts_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  owners(s) to use for filtering results. If multiple IDs are provided,
  results matching any of the IDs will be returned. default is `NULL`.

- manufacturers_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  manufacturers(s) to use for filtering results. If multiple IDs are
  provided, results matching any of the IDs will be returned. default is
  `NULL`.

- licenses_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  license(s) to use for filtering results. If multiple IDs are provided,
  results matching any of the IDs will be returned. default is `NULL`.

- monitor:

  A logical to filter results to regulatory monitors (TRUE) or air
  sensors (FALSE), both are included if NULL, default is `NULL`.

- mobile:

  A logical to filter results to mobile (TRUE) or stationary (FALSE)
  location, both are included if NULL, default is `NULL`.

- instruments_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  instrument(s) to use for filtering results. If multiple IDs are
  provided, results matching any of the IDs will be returned. default is
  `NULL`.

- iso:

  An ISO 3166-1 alpha-2 string of the country to filter the results, ,
  default is `NULL`.

- countries_id:

  A numeric vector of length 1 or more containing country IDs to use for
  filtering results. If multiple IDs are provided, results matching any
  of the IDs will be returned. default is `NULL`.

- order_by:

  A string specifying the field to order results by.

- sort_order:

  A string specifying sort direction, either `"asc"` or `"desc"`.

- limit:

  An integer specifying the maximum number of results to return, default
  is `100`.

- page:

  An integer specifying the page number for paginated results, default
  is `1`.

- as_data_frame:

  A logical for toggling whether to return results as data frame or
  list, default is `TRUE`.

- dry_run:

  A logical for toggling a dry run of the request, default is `FALSE`.

- rate_limit:

  A logical for toggling automatic rate limiting based on rate limit
  headers. default is `FALSE`.

- api_key:

  A valid OpenAQ API key string. default is `NULL`.

## Value

A data frame or list of results.

## Examples

``` r
if (FALSE) { # interactive()
locations <- list_locations()
}
```

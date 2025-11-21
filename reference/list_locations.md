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
  mininum, X maximum, Y maximum, named values must be `xmin`, `ymin`,
  `ymax` , `xmax`. Defaults to `NULL`.

- coordinates:

  Named numeric vector with two numeric WGS84 (EPSG:4326) geographic
  coordinates, with named values `latitude` and `longitude`. Represents
  the central point to be used in conjunction with the radius parameter
  for geographic search. Defaults to `NULL`.

- radius:

  An integer for the number of meters to search around the `coordinates`
  parameter for filtering locations within the radius. Defaults to
  `NULL`.

- providers_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  provider(s) to use for filtering results. If multiple IDs are
  provided, results matching any of the IDs will be returned. Defaults
  to `NULL`.

- parameters_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  parameter(s) to use for filtering results. If multiple IDs are
  provided, results matching any of the IDs will be returned. Defaults
  to `NULL`.

- owner_contacts_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  owners(s) to use for filtering results. If multiple IDs are provided,
  results matching any of the IDs will be returned. Defaults to `NULL`.

- manufacturers_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  manufacturers(s) to use for filtering results. If multiple IDs are
  provided, results matching any of the IDs will be returned. Defaults
  to `NULL`.

- licenses_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  license(s) to use for filtering results. If multiple IDs are provided,
  results matching any of the IDs will be returned. Defaults to `NULL`.

- monitor:

  A logical to filter results to regulatory monitors (TRUE) or air
  sensors (FALSE), both are included if NULL. Defaults to `NULL`.

- mobile:

  A logical to filter results to mobile (TRUE) or stationary (FALSE)
  location, both are included if NULL. Defaults to `NULL`.

- instruments_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  instrument(s) to use for filtering results. If multiple IDs are
  provided, results matching any of the IDs will be returned. Defaults
  to `NULL`.

- iso:

  An ISO 3166-1 alpha-2 string of the country to filter the results.

- countries_id:

  A numeric vector of length 1 or more, containing the ID(s) of the
  country(ies) to use for filtering results. If multiple IDs are
  provided, results matching any of the IDs will be returned. Defaults
  to `NULL`.

- order_by:

  A string. Defaults to `NULL`.

- sort_order:

  A string. Defaults to `NULL`.

- limit:

  An integer to limit the number of results per page. Defaults to
  `NULL`.

- page:

  An integer for the page number for paginating through results.
  Defaults to `NULL`.

- as_data_frame:

  A logical for toggling whether to return results as data frame or
  list. Defaults to `TRUE`

- dry_run:

  A logical for toggling a dry run of the request, defaults to `FALSE.`

- rate_limit:

  A logical for toggling automatic rate limiting based on rate limit
  headers. Defaults to `FALSE.`

- api_key:

  A valid OpenAQ API key string. Defaults to `NULL`.

## Value

A data frame or list of results.

## Examples

``` r
if (FALSE) { # interactive()
locations <- list_locations()
}
```

#' Get a single location from the locations resource.
#'
#' @param locations_id An integer representing the locations_id to request.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list default is `TRUE`.
#' @param dry_run A logical for toggling a dry run of the request, defaults to
#' `FALSE`.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, default is `FALSE`.
#' @param api_key A valid OpenAQ API key string, default is `NULL`.
#'
#' @return A data frame or list of results.
#'
#' @export
#'
#' @examplesIf interactive()
#' location <- get_location(42)
#'
get_location <- function(
    locations_id,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  path <- paste("locations", locations_id, sep = "/")
  data <- fetch(path,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_locations_list(structure(
      data,
      class = c("openaq_locations_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_locations_list", "list")
    ))
  }
}


#' Get a list of locations from the locations resource.
#'
#' @param bbox  Named numeric vector with four coordinates in form X minimum,
#' Y mininum, X maximum, Y maximum, named values must be `xmin`, `ymin`, `ymax`
#' , `xmax`. Defaults to `NULL`.
#' @param coordinates Named numeric vector with two numeric WGS84 (EPSG:4326)
#' geographic coordinates, with named values `latitude` and `longitude`.
#' Represents the central point to be used in conjunction with the radius
#' parameter for geographic search. Defaults to `NULL`.
#' @param radius An integer for the number of meters to search around the
#' `coordinates` parameter for filtering locations within the radius. Defaults
#' to `NULL`.
#' @param providers_id A numeric vector of length 1 or more, containing the
#' ID(s) of the provider(s) to use for filtering results. If multiple IDs are
#' provided, results matching any of the IDs will be returned. Defaults to
#' `NULL`.
#' @param parameters_id A numeric vector of length 1 or more, containing the
#' ID(s) of the parameter(s) to use for filtering results. If multiple IDs are
#' provided, results matching any of the IDs will be returned. Defaults to
#' `NULL`.
#' @param owner_contacts_id A numeric vector of length 1 or more, containing the
#' ID(s) of the owners(s) to use for filtering results. If multiple IDs are
#' provided, results matching any of the IDs will be returned. Defaults to
#' `NULL`.
#' @param manufacturers_id A numeric vector of length 1 or more, containing the
#' ID(s) of the manufacturers(s) to use for filtering results. If multiple IDs
#' are provided, results matching any of the IDs will be returned. Defaults to
#' `NULL`.
#' @param licenses_id A numeric vector of length 1 or more, containing the
#' ID(s) of the license(s) to use for filtering results. If multiple IDs are
#' provided, results matching any of the IDs will be returned. Defaults to
#' `NULL`.
#' @param instruments_id A numeric vector of length 1 or more, containing the
#' ID(s) of the instrument(s) to use for filtering results. If multiple IDs are
#' provided, results matching any of the IDs will be returned. Defaults to
#' `NULL`.
#' @param countries_id A numeric vector of length 1 or more, containing the
#' ID(s) of the country(ies) to use for filtering results. If multiple IDs are
#' provided, results matching any of the IDs will be returned. Defaults to
#' `NULL`.
#' @param monitor A logical to filter results to regulatory monitors (TRUE) or
#' air sensors (FALSE), both are included if NULL. Defaults to `NULL`.
#' @param mobile A logical to filter results to mobile (TRUE) or stationary
#' (FALSE) location, both are included if NULL. Defaults to `NULL`.
#' @param iso An ISO 3166-1 alpha-2 string of the country to filter the results.
#' @param order_by A string. Defaults to `NULL`.
#' @param sort_order A string. Defaults to `NULL`.
#' @param limit An integer to limit the number of results per page. Defaults to
#' `NULL`.
#' @param page An integer for the page number for paginating through results.
#' Defaults to `NULL`.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list. Defaults to `TRUE`
#' @param dry_run A logical for toggling a dry run of the request, defaults to
#' `FALSE.`
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers. Defaults to `FALSE.`
#' @param api_key A valid OpenAQ API key string. Defaults to `NULL`.
#'
#' @return A data frame or list of results.
#'
#' @export
#'
#' @examplesIf interactive()
#' locations <- list_locations()
#'
list_locations <- function(
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
    api_key = NULL) {
  param_defs <- list(
    bbox = list(
      default = NULL, validator = validate_bbox,
      transform = transform_vector_to_string
    ),
    coordinates = list(
      default = NULL, validator = validate_coordinates,
      transform = transform_vector_to_string
    ),
    radius = list(default = NULL, validator = validate_radius),
    providers_id = list(
      default = NULL, validator = validate_providers_id,
      transform = transform_vector_to_string
    ),
    parameters_id = list(
      default = NULL, validator = validate_parameters_id,
      transform = transform_vector_to_string
    ),
    owner_contacts_id = list(
      default = NULL,
      validator = validate_owner_contacts_id, transform = transform_vector_to_string
    ),
    manufacturers_id = list(
      default = NULL,
      validator = validate_manufacturers_id, transform = transform_vector_to_string
    ),
    licenses_id = list(
      default = NULL, validator = validate_licenses_id,
      transform = transform_vector_to_string
    ),
    monitor = list(default = NULL, validator = validate_monitor),
    mobile = list(default = NULL, validator = validate_mobile),
    instruments_id = list(
      default = NULL, validator = validate_instruments_id,
      transform = transform_vector_to_string
    ),
    iso = list(default = NULL, validator = validate_iso),
    countries_id = list(
      default = NULL, validator = validate_countries_id,
      transform = transform_vector_to_string
    ),
    order_by = list(default = NULL, validator = NULL),
    sort_order = list(default = NULL, validator = validate_sort_order),
    limit = list(default = 100, validator = validate_limit),
    page = list(default = 1, validator = validate_page)
  )
  params_list <- extract_parameters(param_defs,
    bbox = bbox,
    coordinates = coordinates,
    radius = radius,
    providers_id = providers_id,
    parameters_id = parameters_id,
    owner_contacts_id = owner_contacts_id,
    manufacturers_id = manufacturers_id,
    licenses_id = licenses_id,
    monitor = monitor,
    mobile = mobile,
    instruments_id = instruments_id,
    iso = iso,
    countries_id = countries_id,
    order_by = order_by,
    sort_order = sort_order,
    limit = limit,
    page = page
  )
  path <- "locations"

  data <- fetch(
    path,
    query_params = params_list,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_locations_list(structure(
      data,
      class = c("openaq_locations_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_locations_list", "list")
    ))
  }
}

#' Method for converting to data frame
#'
#' @param x A list of locations as returned from list_locations.
#' @param row.names `NULL` or a character vector giving the row names for the
#' data frame. Missing values are not allowed.
#' @param optional logical. If TRUE, setting row names and converting column
#' names (to syntactic names: see make.names) is optional. Note that all of R's
#' base package as.data.frame() methods use optional only for column names
#' treatment, basically with the meaning of data.frame(*, check.names =
#' !optional). See also the make.names argument of the matrix method.
#' @param ... additional arguments to be passed to or from methods.
#'
#' @export as.data.frame.openaq_locations_list
#' @export
#'
#' @examplesIf interactive()
#' loc <- list_locations()
#' write.csv(loc)
#'
as.data.frame.openaq_locations_list <- function(x, row.names = NULL, optional = FALSE, ...) { # nolint: object_name_linter
  tbl <- do.call(rbind, lapply(x, function(rw) {
    data.frame(
      id = rw$id,
      name = or(rw$name, ""),
      is_mobile = rw$isMobile,
      is_monitor = rw$isMonitor,
      timezone = rw$timezone,
      countries_id = rw$country$id,
      country_name = rw$country$name,
      country_iso = rw$country$code,
      latitude = rw$coordinates$latitude,
      longitude = rw$coordinates$longitude,
      datetime_first = parse_openaq_timestamp(rw$datetimeFirst),
      datetime_last = parse_openaq_timestamp(rw$datetimeLast),
      owner_name = rw$owner$name,
      providers_id = rw$provider$id,
      provider_name = rw$provider$name
    )
  }))
  tbl$country_iso <- as.factor(tbl$country_iso)
  tbl$countries_id <- as.numeric(tbl$countries_id)
  tbl$providers_id <- as.numeric(tbl$providers_id)
  tbl$owner_name <- as.factor(tbl$owner_name)
  tbl$timezone <- as.factor(tbl$timezone)
  tbl$is_mobile <- as.logical(tbl$is_mobile)
  tbl$is_monitor <- as.logical(tbl$is_monitor)
  attr(tbl, "meta") <- attr(x, "meta")
  attr(tbl, "params") <- attr(x, "params")
  attr(tbl, "headers") <- attr(x, "headers")

  structure(tbl, class = c("openaq_locations_data.frame", "data.frame"))
}

#' Helper for plotting locations on map.
#'
#'
#' @param x the coordinates of points in the plot. Alternatively, a single
#' plotting structure, function or any R object with a plot method can be provided.
#' @param y the y coordinates of points in the plot, optional if x is an
#' appropriate structure.
#' @param ... Other options passed on to base::plot().
#'
#' @export
#'
#' @examplesIf interactive()
#' df <- list_locations(limit = 100)
#' plot(df, pch = 19, col = df$provider)
#'
plot.openaq_locations_data.frame <- function(x, y = NULL, ...) {
  base::plot(latitude ~ longitude, x, ...)
  maps::map(database = "world", add = TRUE)
}

#' Helper for plotting locations from list.
#'
#' @param x A list of locations results.
#' @param y default is `NULL`
#' @param ... Other options passed on to base::plot().
#'
#' @export
#'
#' @examplesIf interactive()
#' loc <- list_locations(limit = 6, as_data_frame = FALSE)
#' plot(loc, pch = 19, col = 2)
#'
plot.openaq_locations_list <- function(x, y = NULL, ...) {
  plot(as.data.frame(x), ...)
}

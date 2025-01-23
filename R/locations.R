#' Get a single location from the locations resource.
#'
#' @param locations_id An integer representing the locations_id to request.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list defaults to TRUE.
#' @param dry_run A logical for toggling a dry run of the request, defaults to
#' FALSE.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, defaults to FALSE.
#' @param api_key A valid OpenAQ API key string, defaults to NULL.
#'
#' @return A data frame or list of results.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' location <- get_location(42)
#' }
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
#' @param bbox A list of 4 numerics, representing a geographic bounding box for
#' filtering results that are within, in the form \[minimum X, minimum Y,
#' maximum X, maximum Y\].
#' @param coordinates A list of 2 numerics, representing a central WGS84
#' geographic coordinate, in the form \[y,x\] or \[lat,lng\], for use with the
#' radius parameter.
#' @param radius An integer for the number of meters to search around the
#' `coordinates` parameter for filtering locations within.
#' @param providers_id An integer or list of integers representing the
#' providers_id to filter results on.
#' @param parameters_id An integer or list of integers representing the
#' parameters_id to filter results on.
#' @param owner_contacts_id An integer or list of integers representing the
#' owner_contacts_id to filter results on.
#' @param manufacturers_id An integer or list of integers representing the
#' manufacturers_id to filter results on.
#' @param licenses_id An integer or list of integers representing the
#' licenses_id to filter results on.
#' @param monitor A logical to filter results to regulatory monitors (TRUE) or
#' air sensors (FALSE), both are included if NULL.
#' @param mobile A logical to filter results to mobile (TRUE) or stationary
#' (FALSE) location, both are included if NULL.
#' @param instruments_id An integer or list of integers.
#' @param iso An ISO 3166-1 alpha-2 string of the country to filter the results.
#' @param countries_id An integer or list of integers of the countries_id(s) to
#' filter the results.
#' @param order_by A string.
#' @param sort_order A string.
#' @param limit An integer to limit the number of results.
#' @param page An integer for the page number for paginating through results.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list defaults to TRUE.
#' @param dry_run A logical for toggling a dry run of the request, defaults to
#' FALSE.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, defaults to FALSE.
#' @param api_key A valid OpenAQ API key string, defaults to NULL.
#'
#' @return A data frame or list of results.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' locations <- list_locations()
#' }
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
      transform = list_to_string
    ),
    coordinates = list(
      default = NULL, validator = validate_coordinates,
      transform = list_to_string
    ),
    radius = list(default = NULL, validator = validate_radius),
    providers_id = list(
      default = NULL, validator = validate_providers_id,
      transform = transform_list_or_item
    ),
    parameters_id = list(
      default = NULL, validator = validate_parameters_id,
      transform = transform_list_or_item
    ),
    owner_contacts_id = list(
      default = NULL,
      validator = validate_owner_contacts_id, transform = transform_list_or_item
    ),
    manufacturers_id = list(
      default = NULL,
      validator = validate_manufacturers_id, transform = transform_list_or_item
    ),
    licenses_id = list(
      default = NULL, validator = validate_licenses_id,
      transform = transform_list_or_item
    ),
    monitor = list(default = NULL, validator = validate_monitor),
    mobile = list(default = NULL, validator = validate_mobile),
    instruments_id = list(
      default = NULL, validator = validate_instruments_id,
      transform = transform_list_or_item
    ),
    iso = list(default = NULL, validator = validate_iso),
    countries_id = list(
      default = NULL, validator = validate_countries_id,
      transform = transform_list_or_item
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
#' @param data A list of locations as returned from list_locations.
#' @param ... Other options.
#'
#' @export as.data.frame.openaq_locations_list
#' @export
#'
#' @examples
#' \dontrun{
#' loc <- list_locations()
#' write.csv(loc)
#' }
as.data.frame.openaq_locations_list <- function(data, ...) {
  tbl <- do.call(rbind, lapply(data, function(x) {
    data.frame(
      id = x$id,
      name = or(x$name, ""),
      is_mobile = x$isMobile,
      is_monitor = x$isMonitor,
      timezone = x$timezone,
      countries_id = x$country$id,
      country_name = x$country$name,
      country_iso = x$country$code,
      latitude = x$coordinates$latitude,
      longitude = x$coordinates$longitude,
      datetime_first = parse_openaq_timestamp(x$datetimeFirst),
      datetime_last = parse_openaq_timestamp(x$datetimeLast),
      owner_name = x$owner$name,
      providers_id = x$provider$id,
      provider_name = x$provider$name
    )
  }))
  tbl$country_iso <- as.factor(tbl$country_iso)
  tbl$countries_id <- as.numeric(tbl$countries_id)
  tbl$providers_id <- as.numeric(tbl$providers_id)
  tbl$owner_name <- as.factor(tbl$owner_name)
  tbl$timezone <- as.factor(tbl$timezone)
  tbl$is_mobile <- as.logical(tbl$is_mobile)
  tbl$is_monitor <- as.logical(tbl$is_monitor)
  attr(tbl, "meta") <- attr(data, "meta")
  attr(tbl, "params") <- attr(data, "params")
  return(structure(tbl, class = c("openaq_locations_data.frame", "data.frame")))
}

#' Helper for plotting locations on map.
#'
#' @param loc A data frame of locations results.
#' @param database the maps package database of geographic boundaries to use,
#' defaults to "world".
#' @param ... Other options passed on to base::plot().
#'
#' @export
#'
#' @examples
#' \dontrun{
#' df <- list_locations(limit = 100)
#' plot(df, pch = 19, col = df$provider)
#' }
plot.openaq_locations_data.frame <- function(loc, database = "world", ...) {
  base::plot(latitude ~ longitude, loc, ...)
  maps::map(database = database, add = TRUE)
}

#' Helper for plotting locations from list.
#'
#' @param loc A list of locations results.
#' @param database the maps package database of geographic boundaries to use,
#' defaults to "world".
#' @param ... Other options passed on to base::plot().
#'
#' @export
#'
#' @examples
#' \dontrun{
#' loc <- list_locations(limit = 6, as_data_frame = FALSE)
#' plot(loc, pch = 19, col = 2)
#' }
plot.openaq_locations_list <- function(loc, database = "world", ...) {
  plot(as.data.frame(loc), database = database, ...)
}

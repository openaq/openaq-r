#' Get a single provider from providers resource.
#'
#' @param providers_id An integer.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list defaults to TRUE.
#' @param dry_run A logical for toggling a dry run of the request, defaults to
#' FALSE.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, defaults to FALSE.
#' @param api_key A valid OpenAQ API key string, defaults to NULL.
#'
#' @return A data frame or a list of the results.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' provider <- get_provider(42)
#' }
#'
get_provider <- function(
    providers_id,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  path <- paste("providers", providers_id, sep = "/")
  data <- fetch(path,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_providers_list(structure(
      data,
      class = c("openaq_providers_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_providers_list", "list")
    ))
  }
}


#' Get a list of providers from the providers resource.
#'
#' @param order_by A string.
#' @param sort_order A string.
#' @param limit An integer.
#' @param page An integer.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list defaults to TRUE.
#' @param dry_run A logical for toggling a dry run of the request, defaults to
#' FALSE.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, defaults to FALSE.
#' @param api_key A valid OpenAQ API key string, defaults to NULL.
#'
#' @return A data frame or a list of the results.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' providers <- list_providers()
#' }
#'
list_providers <- function(
    order_by = NULL,
    sort_order = NULL,
    limit = 100,
    page = 1,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  param_defs <- list(
    order_by = list(default = NULL, validator = NULL),
    sort_order = list(default = NULL, validator = validate_sort_order),
    limit = list(default = 100, validator = validate_limit),
    page = list(default = 1, validator = validate_page)
  )

  params_list <- extract_parameters(param_defs,
    order_by = order_by,
    sort_order = sort_order,
    limit = limit,
    page = page
  )
  path <- "providers"
  data <- fetch(path,
    query_params = params_list, dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_providers_list(structure(
      data,
      class = c("openaq_providers_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_providers_list", "list")
    ))
  }
}


#' Method for converting openaq_providers_list to data frame.
#'
#' @param data A list of countries as returned from list_providers.
#' @param ... Other options.
#'
#' @export as.data.frame.openaq_providers_list
#' @export
#'
#' @examples
#' \dontrun{
#' providers <- list_providers(as_data_frame = FALSE)
#' openaq_instruments_list.as.data.frame(providers)
#' }
as.data.frame.openaq_providers_list <- function(data, ...) {
  tbl <- do.call(rbind, lapply(data, function(x) {
    data.frame(
      id = x$id,
      name = x$name,
      source_name = x$sourceName,
      export_prefix = x$exportPrefix,
      datetime_added = parse_openaq_timestamp(x$datetimeAdded),
      datetime_first = parse_openaq_timestamp(x$datetimeFirst),
      datetime_last = parse_openaq_timestamp(x$datetimeLast),
      entities_id = x$entitiesId,
      parameters_ids = paste(lapply(x$parameters, function(x) {
        x$id
      }), collapse = ",")
    )
  }))
  tbl$id <- as.numeric(tbl$id)
  tbl$source_name <- as.factor(tbl$source_name)
  tbl$entities_id <- as.numeric(tbl$entities_id)
  attr(tbl, "meta") <- attr(data, "meta")
  return(structure(tbl,
    class = c("openaq_providers_data.frame", "data.frame")
  ))
}

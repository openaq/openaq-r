#' Get a single parameter from the parameters resource.
#'
#' @param parameters_id An integer.
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
#' parameter <- get_parameter(42)
#' }
#'
get_parameter <- function(
    parameters_id,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  path <- paste("parameters", parameters_id, sep = "/")
  data <- fetch(path,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_parameters_list(structure(
      data,
      class = c("openaq_parameters_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_parameters_list", "list")
    ))
  }
}


#' Get a list of parameters from the parameters resource.
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
#' parameters <- list_parameters()
#' }
#'
list_parameters <- function(
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
  path <- "parameters"
  data <- fetch(path,
    query_params = params_list, dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_parameters_list(structure(
      data,
      class = c("openaq_parameters_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_parameters_list", "list")
    ))
  }
}

#' Method for converting openaq_parameters_list to data frame.
#'
#' @param data A list of countries as returned from list_parameters.
#' @param ... Other options.
#'
#' @export as.data.frame.openaq_parameters_list
#' @export
#'
#' @examples
#' \dontrun{
#' instruments <- list_instruments()
#' openaq_parameters_list.as.data.frame(instruments)
#' }
as.data.frame.openaq_parameters_list <- function(x, row.names = NULL, optional = FALSE, ...) {
  tbl <- do.call(rbind, lapply(x, function(rw) {
    data.frame(
      id = rw$id,
      name = rw$name,
      units = rw$units,
      display_name = or(rw$displayName, NA),
      description = or(rw$description, NA)
    )
  }))
  tbl$id <- as.numeric(tbl$id)
  attr(tbl, "meta") <- attr(x, "meta")
  return(structure(tbl,
    class = c("openaq_parameters_data.frame", "data.frame")
  ))
}

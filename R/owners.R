#' Get a single owner from owners resource.
#'
#' @param owners_id An integer.
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
#' owners <- get_owner(42)
#' }
#'
get_owner <- function(
    owners_id,
    as_data_frame = TRUE,
    dry_run = FALSE,
    rate_limit = FALSE,
    api_key = NULL) {
  path <- paste("owners", owners_id, sep = "/")
  data <- fetch(path,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_owners_list(structure(
      data,
      class = c("openaq_owners_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_owners_list", "list")
    ))
  }
}


#' Get a list of owners from the owners resource.
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
#' owners <- list_owners()
#' }
#'
list_owners <- function(
    order_by = NULL,
    sort_order = NULL,
    limit = NULL,
    page = NULL,
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
  path <- "owners"
  data <- fetch(path,
    query_params = params_list,
    dry_run = dry_run,
    rate_limit = rate_limit,
    api_key = api_key
  )
  if (isTRUE(dry_run)) {
    return(data)
  }
  if (as_data_frame == TRUE) {
    return(as.data.frame.openaq_owners_list(structure(
      data,
      class = c("openaq_owners_list", "list")
    )))
  } else {
    return(structure(
      data,
      class = c("openaq_owners_list", "list")
    ))
  }
}

#' Method for converting openaq_owners_list to data frame.
#'
#' @param data A list of countries as returned from list_owners.
#' @param ... Other options.

#'
#' @export as.data.frame.openaq_owners_list
#' @export
#'
#' @examples
#' \dontrun{
#' instruments <- list_instruments()
#' openaq_owners_list.as.data.frame(instruments)
#' }
as.data.frame.openaq_owners_list <- function(x, row.names = NULL, optional = FALSE, ...) {
  tbl <- do.call(rbind, lapply(x, function(rw) {
    data.frame(
      id = rw$id,
      name = rw$name,
    )
  }))
  tbl$id <- as.numeric(tbl$id)
  attr(tbl, "meta") <- attr(x, "meta")
  return(structure(tbl,
    class = c("openaq_owners_data.frame", "data.frame")
  ))
}

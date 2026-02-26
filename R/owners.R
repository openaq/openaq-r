#' Get a single owner from owners resource.
#'
#' @param owners_id An integer representing the OpenAQ owners_id.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list, default is `TRUE`.
#' @param dry_run A logical for toggling a dry run of the request, default is
#' `FALSE`.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, default is `FALSE`.
#' @param api_key A valid OpenAQ API key string, default is `NULL`.
#'
#' @return A data frame or a list of the results.
#'
#' @export
#'
#' @examplesIf interactive()
#' owners <- get_owner(42)
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
  if (isTRUE(as_data_frame)) {
    as.data.frame.openaq_owners_list(structure(
      data,
      class = c("openaq_owners_list", "list")
    ))
  } else {
    structure(
      data,
      class = c("openaq_owners_list", "list")
    )
  }
}


#' Get a list of owners from the owners resource.
#'
#' @param order_by A string specifying the field to order results by.
#' @param sort_order A string specifying sort direction, either `"asc"` or `"desc"`.
#' @param limit An integer specifying the maximum number of results to return, default is `100`.
#' @param page An integer specifying the page number for paginated results, default is `1`.
#' @param as_data_frame A logical for toggling whether to return results as
#' data frame or list, default is `TRUE`.
#' @param dry_run A logical for toggling a dry run of the request, default is
#' `FALSE`.
#' @param rate_limit A logical for toggling automatic rate limiting based on
#' rate limit headers, default is `FALSE`.
#' @param api_key A valid OpenAQ API key string, default is `NULL`.
#'
#' @return A data frame or a list of the results.
#'
#' @export
#'
#' @examplesIf interactive()
#' owners <- list_owners()
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
  if (isTRUE(as_data_frame)) {
    as.data.frame.openaq_owners_list(structure(
      data,
      class = c("openaq_owners_list", "list")
    ))
  } else {
    structure(
      data,
      class = c("openaq_owners_list", "list")
    )
  }
}

#' Method for converting openaq_owners_list to data frame.
#'
#' @param x A list of owners as returned from list_owners.
#' @param row.names `NULL` or a character vector giving the row names for the
#' data frame. Missing values are not allowed.
#' @param optional logical. If TRUE, setting row names and converting column
#' names (to syntactic names: see make.names) is optional. Note that all of R's
#' base package as.data.frame() methods use optional only for column names
#' treatment, basically with the meaning of data.frame(*, check.names =
#' !optional). See also the make.names argument of the matrix method.
#' @param ... additional arguments to be passed to or from methods.
#'
#' @export as.data.frame.openaq_owners_list
#' @export
#'
#' @examplesIf interactive()
#' owners <- list_owners(as_data_frame = FALSE)
#' as.data.frame(owners)
#'
as.data.frame.openaq_owners_list <- function(x, row.names = NULL, optional = FALSE, ...) { # nolint: object_name_linter
  tbl <- do.call(rbind, lapply(x, function(rw) {
    data.frame(
      id = rw$id,
      name = rw$name
    )
  }))
  tbl$id <- as.numeric(tbl$id)
  attr(tbl, "meta") <- attr(x, "meta")
  structure(tbl,
    class = c("openaq_owners_data.frame", "data.frame")
  )
}

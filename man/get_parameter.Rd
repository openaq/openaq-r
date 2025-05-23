% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parameters.R
\name{get_parameter}
\alias{get_parameter}
\title{Get a single parameter from the parameters resource.}
\usage{
get_parameter(
  parameters_id,
  as_data_frame = TRUE,
  dry_run = FALSE,
  rate_limit = FALSE,
  api_key = NULL
)
}
\arguments{
\item{parameters_id}{An integer.}

\item{as_data_frame}{A logical for toggling whether to return results as
data frame or list default is \code{TRUE}.}

\item{dry_run}{A logical for toggling a dry run of the request, defaults to
\code{FALSE}.}

\item{rate_limit}{A logical for toggling automatic rate limiting based on
rate limit headers, default is \code{FALSE}.}

\item{api_key}{A valid OpenAQ API key string, default is \code{NULL}.}
}
\value{
A data frame or a list of the results.
}
\description{
Get a single parameter from the parameters resource.
}
\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
parameter <- get_parameter(42)
\dontshow{\}) # examplesIf}
}

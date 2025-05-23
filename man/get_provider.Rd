% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/providers.R
\name{get_provider}
\alias{get_provider}
\title{Get a single provider from providers resource.}
\usage{
get_provider(
  providers_id,
  as_data_frame = TRUE,
  dry_run = FALSE,
  rate_limit = FALSE,
  api_key = NULL
)
}
\arguments{
\item{providers_id}{An integer.}

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
Get a single provider from providers resource.
}
\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
provider <- get_provider(42)
\dontshow{\}) # examplesIf}
}

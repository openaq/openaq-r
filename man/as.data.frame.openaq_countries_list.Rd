% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/countries.R
\name{as.data.frame.openaq_countries_list}
\alias{as.data.frame.openaq_countries_list}
\title{Method for converting openaq_countries_list to data frame.}
\usage{
\method{as.data.frame}{openaq_countries_list}(data, ...)
}
\arguments{
\item{data}{A list of countries as returned from list_countries}

\item{...}{Other options}
}
\description{
Method for converting openaq_countries_list to data frame.
}
\examples{
\dontrun{
countries <- list_countries()
openaq_countries_list.as.data.frame(countries)
}
}

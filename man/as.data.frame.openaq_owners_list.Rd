% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/owners.R
\name{as.data.frame.openaq_owners_list}
\alias{as.data.frame.openaq_owners_list}
\title{Method for converting openaq_owners_list to data frame.}
\usage{
\method{as.data.frame}{openaq_owners_list}(x, row.names=NULL, optional=FALSE, ...)
}
\arguments{
\item{x}{A list of countries as returned from list_owners.}

\item{row.names}{‘NULL’ or a character vector giving the row names for
  the data frame.  Missing values are not allowed.}

\item{optional}{logical. Should we check names?}

\item{...}{Other options.}
}
\description{
Method for converting openaq_owners_list to data frame.
}
\examples{
\dontrun{
instruments <- list_instruments()
openaq_owners_list.as.data.frame(instruments)
}
}

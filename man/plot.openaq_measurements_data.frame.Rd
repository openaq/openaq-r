% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/measurements.R
\name{plot.openaq_measurements_data.frame}
\alias{plot.openaq_measurements_data.frame}
\title{Helper for plotting measurements}
\usage{
\method{plot}{openaq_measurements_data.frame}(x, y, ...)
}
\arguments{
\item{x}{A data frame of measurements results.}

\item{y}{default is \code{NULL}}

\item{...}{Other options to be passed on to base::plot().}
}
\description{
Helper for plotting measurements
}
\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
meas <- list_sensor_measurements(23707, limit = 500, as_data_frame = FALSE)
plot(meas)
\dontshow{\}) # examplesIf}
}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/deseason.R
\name{deseason}
\alias{deseason}
\title{Decompose the seasonal factor from timeseries}
\usage{
deseason(timeseries, type = "additive")
}
\arguments{
\item{timeseries}{The timeseries data you would like to apply}

\item{type}{Type of seasonal factor. (additive or multiplicative)}
}
\value{

}
\description{
Decompose the seasonal factor from timeseries
}
\examples{
deseason(timeseries, type="additive")
}

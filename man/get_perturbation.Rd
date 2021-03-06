% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utility.R
\name{get_perturbation}
\alias{get_perturbation}
\title{get_perturbation}
\usage{
get_perturbation(Wi, base, perturbation = 0.05)
}
\arguments{
\item{Wi}{raw count data row}

\item{base}{base OTU value}

\item{perturbation}{how much to purturb zero counts, defaults to 0.05}
}
\description{
This function purturbates a row of the raw count matrix. Likely will not be used directly.
}

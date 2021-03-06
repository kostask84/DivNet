% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimate_diversity.R
\name{divnet}
\alias{divnet}
\title{divnet}
\usage{
divnet(W, X = NULL, fitted_model = NULL, tuning = NULL,
  perturbation = NULL, network = NULL, base = NULL, ncores = NULL,
  variance = "parametric", B = 5, nsub = NULL, ...)
}
\arguments{
\item{W}{TODO}

\item{X}{TODO}

\item{fitted_model}{object produced by fit_aitchison}

\item{tuning}{TODO}

\item{perturbation}{Perturbation magnitude for zero values when calculating logratios.}

\item{network}{TODO}

\item{base}{Base taxon index.}

\item{ncores}{Number of cores to use for parallelization}

\item{variance}{method to get variance of estimates. Current options are "parametric" for parametric bootstrap, "nonparametric" for nonparametric bootstrap, and "none" for no variance estimates}

\item{B}{TODO}

\item{nsub}{TODO}

\item{...}{TODO}
}
\description{
divnet
}
\author{
Amy Willis
}

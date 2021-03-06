#' OLS function
#'
#' Function to simulate raw counts W from model fit
#'
#' @param X explanatory variables
#' @param Y response variables
#'
OLS <- function(X, Y) {
  
  p <- ncol(X)
  centY <- scale(Y, center=TRUE, scale = FALSE)
  
  # quick function to aid apply
  aFun <- function(ycol) {
    
    outcome <- try(tcrossprod(ginv(crossprod(X)), X) %*% ycol, silent = T)
    if (class(outcome) == "try-error") {
      cat("Tried to regress X on Y where X is\n")
      print(X)
      cat("and Y is \n")
      print(Y)
      stop("Non-conformable multiplication")
    } else {
      return(outcome)
    }
  }
  b <- apply(centY, 2, aFun)
  matrix(b, nrow = p)
}

#' get_mu
#'
#' Function to get mu from model output
#'
#' @param out model fit from LNM.EM or LNM.EM.nocov
#' @param X optional covariates
#'
#'
get_mu <- function(out, X = NULL) {
  N <- nrow(out$Y)
  if (!is.null(out$b)) {
    return(X %*% out$b + tcrossprod(rep(1, N), out$b0))
  } else {
    return(out$b0)
  }
}

#' get_perturbation
#'
#' This function purturbates a row of the raw count matrix. Likely will not be used directly.
#'
#' @param Wi raw count data row
#' @param base base OTU value
#' @param perturbation how much to purturb zero counts, defaults to 0.05
#'
get_perturbation <- function(Wi, base, perturbation = 0.05) {
  zeros <- which(Wi == 0)
  nz <- length(zeros)
  Q <- length(Wi)
  Z_purt <- rep(0, Q)
  if (nz != 0) {
    Z_purt[zeros] <- (Wi[zeros] + perturbation)/(sum(Wi) + perturbation * nz)
    Z_purt[-zeros] <- (Wi[-zeros])/(sum(Wi) + perturbation * nz)
  } else {
    Z_purt <- Wi/sum(Wi)
  }
  
  # Return Y_purt
  return(log(Z_purt[-base]/Z_purt[base]))
}

#' acomb3
#'
#' This function works like cbind, but along the third dimension of an array
#'
#' @param ... Array
#' 
acomb3 <- function(...) abind(..., along = 3)

pick_base <- function(W) {
  taxa_sums <- colSums(W)
  which.max(taxa_sums)
}


#' Make design matrix
#' 
#' @param phyloseq_object A phyloseq object
#' @param variables variable names
#' 
#' @importFrom phyloseq sample_data
#' @importFrom phyloseq get_variable
#' 
#' @export
make_design_matrix <- function(phyloseq_object, variables) {
  predictors <- phyloseq_object %>% sample_data %>% get_variable(variables)
  model.matrix( ~predictors, data = predictors)
}
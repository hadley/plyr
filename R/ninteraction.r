#' Numerical interaction
#' A purely numerical interaction function that powers \code{aaply}.
#' 
#' @param .variables list of variables
#' @param drop drop unusued factor levels?
#' @keywords internal
ninteraction <- function(.variables, drop = FALSE) {  
  if (length(.variables) == 0) {
    res <- structure(rep.int(1L, nrow(.variables)), n = 1L)
    return(res)
  }
  
  # Special case for single variable
  if (length(.variables) == 1) {
    var <- .variables[[1]]
    
    f <- addNA(as.factor(var), ifany = TRUE)
    res <- structure(as.integer(f), n = nunique(f))
    return(res)
  }
  
  # Convert to factors, if necessary
  not_factor <- !unlist(lapply(.variables, is.factor))
  .variables[not_factor] <- lapply(.variables[not_factor], factor,
    exclude=NULL)
  .variables <- lapply(.variables, addNA, ifany = TRUE)
  
  # Calculate dimensions

  ndistinct <- unlist(lapply(.variables, nunique))
  n <- prod(ndistinct)

  p <- length(.variables)
  combs <- c(1, cumprod(ndistinct[-p]))
  
  mat <- do.call("cbind", lapply(.variables, as.integer))
  res <- c((mat - 1L) %*% combs + 1L)
  
  # vdf <- data.frame(.variables)
  # names(vdf) <- paste("X", 1:ncol(vdf), sep="")
  # vdf$i <- res
  # browser()
  
  if (drop) {
    f <- factor(res) 
    n <- nunique(f)
    res <- as.integer(f)
  }
  
  attr(res, "n") <- n
  res
}
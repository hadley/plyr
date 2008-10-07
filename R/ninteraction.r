# Numerical interaction
# A purely numerical interaction function that powers \code{aaply}.
# 
# @keywords internal
ninteraction <- function(.variables, drop = FALSE) {  
  if (length(.variables) == 0) {
    res <- structure(rep.int(1L, nrow(.variables)), n = 1L)
    return(res)
  }
  
  if (length(.variables) == 1) {
    f <- as.factor(.variables[[1]])
    res <- structure(as.integer(f), n = nunique(f))
    return(res)
  }
  
  # Convert to factors, if necessary
  not_factor <- !unlist(lapply(.variables, is.factor))
  .variables[not_factor] <- llply(.variables[not_factor], factor, exclude=NULL)
  
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

# Number of unique values
# Calculate number of unique values of a variable as efficiently as possible.
# 
# @arguments vector
# @keyword internal
nunique <- function(x) {
  if (is.factor(x)) {
    length(levels(x))
  } else {
    length(unique(x))
  }
}

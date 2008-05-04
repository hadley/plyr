ninteraction <- function(vars, drop = FALSE) {  
  if (length(vars) == 0) {
    res <- structure(rep.int(1L, nrow(vars)), n = 1L)
    return(res)
  }
  
  if (length(vars) == 1) {
    f <- as.factor(vars[[1]])
    res <- structure(as.integer(f), n = nunique(f))
    return(res)
  }
  
  # Convert to factors, if necessary
  not_factor <- !unlist(lapply(vars, is.factor))
  vars[not_factor] <- llply(vars[not_factor], factor, exclude=NULL)
  
  # Calculate dimensions

  ndistinct <- unlist(lapply(vars, nunique))
  n <- prod(ndistinct)

  p <- length(vars)
  combs <- c(1, cumprod(ndistinct[-p]))
  
  mat <- do.call("cbind", lapply(vars, as.integer))
  res <- c((mat - 1L) %*% combs + 1L)
  
  # vdf <- data.frame(vars)
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
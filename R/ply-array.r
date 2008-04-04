# To arrays  ----------------------------------------------------------------

laply <-  function(data, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  f <- robustify(fun, .try = .try, .quiet = .quiet, .explode = .explode)
    
  data <- as.list(data)
  res <- llply(data, f, ..., .progress = .progress)
  
  atomic <- sapply(res, is.atomic)
  if (any(!atomic)) stop("Results must be atomic")
  
  dlength <- unique(llply(res, dims))
  if (length(dlength) != 1) stop("Results must have same number of dimensions")
  
  dims <- unique(do.call("rbind", llply(res, vdim)))
  if (nrow(dims) != 1) stop("Results must be equal length")
  
  # Should have nrow(labels) + nrow(resm) - 1 dimensions
  abind(res, along = 0, force.array = TRUE)    
  # resm <- do.call("rbind", res)
  
  
  # resm
  
}
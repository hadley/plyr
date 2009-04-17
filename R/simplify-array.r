
# List to array
# Reduce/simplify a list of homogenous objects to an array
# 
# @arguments list of input data
# @arguments a data frame of labels, one row for each element of res
# @arguments should extra dimensions be dropped (TRUE) or preserved (FALSE)
# @keyword internal
list_to_array <- function(res, labels = NULL, .drop = FALSE) {
  if (length(res) == 0) return(vector())
  n <- length(res)
  
  atomic <- sapply(res, is.atomic)
  if (all(atomic)) {
    # Atomics need to be same size
    dlength <- unique.default(llply(res, dims))
    if (length(dlength) != 1) 
      stop("Results must have the same number of dimensions.")

    dims <- unique(do.call("rbind", llply(res, amv_dim)))
    if (nrow(dims) != 1) 
      stop("Results must have the same dimensions.")    

    res_dim <- amv_dim(res[[1]])
    res_labels <- amv_dimnames(res[[1]])
    res_index <- expand.grid(res_labels)

    res <- unlist(res)
  } else {
    # Lists are degenerate case where every element is a singleton
    res_index <- as.data.frame(matrix(0, 1, 0))
    res_dim <- numeric()
    res_labels <- NULL
    
    attr(res, "split_type") <- NULL
    attr(res, "split_labels") <- NULL
    class(res) <- class(res)[2]
  }

  if (is.null(labels)) {
    labels <- data.frame(X = seq_len(n))
    in_labels <- list(NULL)
    in_dim <- n
  } else {
    in_labels <- lapply(labels, 
      function(x) if(is.factor(x)) levels(x) else unique(x))
    in_dim <- sapply(in_labels, length)        
  }
  
  index <- cbind(
    labels[rep(seq_len(nrow(labels)), each = nrow(res_index)), ,drop = FALSE],
    res_index[rep(seq_len(nrow(res_index)), nrow(labels)), , drop = FALSE]
  )
  
  out_dim <- unname(c(in_dim, res_dim))
  out_labels <- c(in_labels, res_labels)
  n <- prod(out_dim)

  overall <- ninteraction(index)
  if (length(overall) < n) {
    overall <- match(1:n, overall, nomatch = NA)
  } else {
    overall <- order(overall)
  }
  
  out_array <- res[overall]  
  dim(out_array) <- out_dim
  dimnames(out_array) <- out_labels
  if (.drop) reduce(out_array) else out_array
}
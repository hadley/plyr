# List to data frame
# Reduce/simplify a list of homogenous objects to a data frame
# 
# @arguments list of input data
# @arguments a data frame of labels, one row for each element of res
# @keywords internal
list_to_dataframe <- function(res, labels = NULL) { 
  if (length(res) == 0) return(data.frame())
  
  atomic <- unlist(llply(res, is.atomic))
  if (all(atomic)) {
    ulength <- unique(unlist(llply(res, length)))
    if (length(ulength) != 1) stop("Results are not equal lengths")
    
    if (length(res) > 1) {
      resdf <- as.data.frame(do.call("rbind", res))      
    } else {
      resdf <- data.frame(res[[1]])
    }
    rows <- rep(1, length(res))
  } else {
    l_ply(res, function(x) if(!is.null(x) & !is.data.frame(x)) stop("Not a data.frame!"))

    resdf <- do.call("rbind.fill", res)
    rows <- unlist(llply(res, function(x) if(is.null(x)) 0 else nrow(x)))
  }

  if (!is.null(labels) && nrow(labels) == length(res)) {
    cols <- setdiff(names(labels), names(resdf))
    resdf <- cbind(labels[rep(1:nrow(labels), rows), cols, drop=FALSE], resdf)
  }
  
  unrowname(resdf)
}


# List to array
# Reduce/simplify a list of homogenous objects to an array
# 
# @arguments list of input data
# @arguments a data frame of labels, one row for each element of res
# @arguments should extra dimensions be dropped (TRUE) or preserved (FALSE)
# @keywords internal
list_to_array <- function(res, labels = NULL, .drop = FALSE) {
  if (length(res) == 0) return(vector())
  n <- length(res)
  
  atomic <- sapply(res, is.atomic)
  if (all(atomic)) {
    # Atomics need to be same size
    dlength <- unique.default(llply(res, dims))
    if (length(dlength) != 1) stop("Results must have the same number of dimensions.")

    dims <- unique(do.call("rbind", llply(res, amv_dim)))
    if (nrow(dims) != 1) stop("Results must have the same dimensions.")    

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
    in_labels <- lapply(labels, unique)
    in_dim <- sapply(in_labels, length)        
  }
  
  index <- cbind(
    labels[rep(seq_len(nrow(labels)), each = nrow(res_index)), , drop = FALSE],
    res_index[rep(seq_len(nrow(res_index)), nrow(labels)), , drop = FALSE]
  )
  
  out_dim <- unname(c(in_dim, res_dim))
  out_labels <- c(in_labels, res_labels)
  n <- prod(out_dim)

  overall <- order(ninteraction(index))
  if (length(overall) < n) overall <- match(1:n, overall, nomatch = NA)
  
  out_array <- res[overall]  
  dim(out_array) <- out_dim
  dimnames(out_array) <- out_labels
  if (.drop) reduce(out_array) else out_array
}
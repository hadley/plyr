# To arrays  ----------------------------------------------------------------

laply <-  function(data., fun. = NULL, ..., progress. = "none", drop. = TRUE) {
  if (is.character(fun.)) fun. <- match.fun(fun.)
  
  if (!is(data., "split")) data. <- as.list(data.)
  res <- llply(data., fun., ..., progress. = progress.)
  
  if (length(res) == 0) return(vector())
  
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

  labels <- attr(data., "split_labels")
  if (is.null(labels)) {
    labels <- data.frame(X = seq_along(data.))
    in_labels <- list(NULL)
    in_dim <- length(data.)
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
  if (drop.) reduce(out_array) else out_array
}

#X daply(baseball, .(year), nrow)
#X
#X # Several different ways of summarising by variables that should not be 
#X # included in the summary
#X 
#X daply(baseball[, c(2, 6:9)], .(year), mean)
#X daply(baseball[, 6:9], .(baseball$year), mean)
#X daply(baseball, .(year), function(df) mean(df[, 6:9]))
daply <- function(data., variables., fun. = NULL, ..., progress. = "none", drop. = TRUE) {
  data. <- as.data.frame(data.)
  pieces <- splitter_d(data., variables.)
  
  laply(pieces, fun., progress. = progress., drop. = drop.)
}

#X aaply(ozone, 1, mean)
#X aaply(ozone, 3, mean)
#X aaply(ozone, c(1,2), mean)
#X
#X aaply(ozone, 1, each(min, max))
#X aaply(ozone, 3, each(min, max))
#X 
#X standardise <- function(x) (x - min(x)) / (max(x) - min(x))
#X aaply(ozone, 3, standardise)
#X aaply(ozone, 1:2, standardise)
aaply <- function(data., margins., fun. = NULL, ..., progress. = "none", drop. = TRUE) {
  pieces <- splitter_a(data., margins.)
  
  laply(pieces, fun., progress. = progress., drop. = drop.)
}
# Split list, apply function, and return results in an array
# For each element of a list, apply function then combine results into an array
# 
# All plyr functions use the same split-apply-combine strategy: they split the
# input into simpler pieces, apply \code{fun.} to each piece, and then combine
# the pieces into a single data structure.  This function splits lists by
# elements and combines the result into an array.  If there are no results,
# then this function will return a vector of length 0 (\code{vector()}).
# 
# \code{laply} is very similar in spirit to \code{\link{sapply}} except that
# it will always return an array, and the output is transposed with respect
# \code{sapply} - each element of the list corresponds to a column, not a 
# row.  
# 
# See \code{vignette("intro", "plyr")} for more details, description and case
# studies.
# 
# @keyword manip
# @arguments input list
# @arguments function to apply to each piece
# @arguments other arguments passed on to \code{fun.}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @arguments should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
# @value if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
# 
#X laply(baseball, is.factor)
#X # cf
#X ldply(baseball, is.factor)
#X colwise(is.factor)(baseball)
#X
#X laply(seq_len(10), identity)
#X laply(seq_len(10), rep, times = 4)
#X laply(seq_len(10), matrix, nrow = 2, ncol = 2)
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

# Split data frame, apply function, and return results in an array
# For each subset of data frame, apply function then combine results into an array
# 
# All plyr functions use the same split-apply-combine strategy: they split the
# input into simpler pieces, apply \code{fun.} to each piece, and then combine
# the pieces into a single data structure.  This function splits data frames
# by variable and combines the result into an array.  If there are no results,
# then this function will return a vector of length 0 (\code{vector()}).
# 
# \code{daply} with a function that operates column-wise is similar to
# \code{\link{aggregate}}. 
# 
# See \code{vignette("intro", "plyr")} for more details, description and case
# studies.
# 
# @keyword manip
# @arguments data frame to be processed
# @arguments function to apply to each piece
# @arguments variables to split data frame by, as quoted variables, a formula or character vector
# @arguments other arguments passed on to \code{fun.}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @arguments should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
# @value if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
# 
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
  variables. <- as.quoted(variables.)
  pieces <- splitter_d(data., variables.)
  
  laply(pieces, fun., ..., progress. = progress., drop. = drop.)
}

# Split array, apply function, and return results in an array
# For each slice of an array, apply function then combine results into an array
# 
# All plyr functions use the same split-apply-combine strategy: they split the
# input into simpler pieces, apply \code{fun.} to each piece, and then combine
# the pieces into a single data structure.  This function splits matrices,
# arrays and data frames by dimensions and combines the result into an array.
# If there are no results, then this function will return a vector of length 0 (\code{vector()}).
# 
# This function is very similar to \code{\link{apply}}, except that it will
# always return an array, and when the function returns >1 d data structures,
# those dimensions are added on to the highest dimensions, rather than the
# lowest dimensions.  This makes \code{aaply} idempotent, so that
# \code{apply(input, X, identity)} is equivalent to \code{aperm(input, X)}.
# 
# See \code{vignette("intro", "plyr")} for more details, description and case
# studies.
# 
# @keyword manip
# @arguments matrix, array or data frame to be processed
# @arguments a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions
# @arguments function to apply to each piece
# @arguments other arguments passed on to \code{fun.}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @arguments should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
# @value if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#
#X dim(ozone)
#X aaply(ozone, 1, mean)
#X aaply(ozone, 1, mean, drop. = FALSE)
#X aaply(ozone, 3, mean)
#X aaply(ozone, c(1,2), mean)
#X
#X dim(aaply(ozone, c(1,2), mean))
#X dim(aaply(ozone, c(1,2), mean, drop. = FALSE)) 
#X
#X aaply(ozone, 1, each(min, max))
#X aaply(ozone, 3, each(min, max))
#X 
#X standardise <- function(x) (x - min(x)) / (max(x) - min(x))
#X aaply(ozone, 3, standardise)
#X aaply(ozone, 1:2, standardise)
#X  
#X aaply(ozone, 1:2, diff)
aaply <- function(data., margins., fun. = NULL, ..., progress. = "none", drop. = TRUE) {
  pieces <- splitter_a(data., margins.)
  
  laply(pieces, fun., ..., progress. = progress., drop. = drop.)
}
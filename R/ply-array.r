# Split list, apply function, and return results in an array
# For each element of a list, apply function then combine results into an array
# 
# All plyr functions use the same split-apply-combine strategy: they split the
# input into simpler pieces, apply \code{.fun} to each piece, and then combine
# the pieces into a single data structure.  This function splits lists by
# elements and combines the result into an array.  If there are no results,
# then this function will return a vector of length 0 (\code{vector()}).
# 
# \code{laply} is very similar in spirit to \code{\link{sapply}} except that
# it will always return an array, and the output is transposed with respect
# \code{sapply} - each element of the list corresponds to a column, not a 
# row.
# 
# 
# @keyword manip
# @arguments input list
# @arguments function to apply to each piece
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @arguments should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
# @value if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#X laply(baseball, is.factor)
#X # cf
#X ldply(baseball, is.factor)
#X colwise(is.factor)(baseball)
#X
#X laply(seq_len(10), identity)
#X laply(seq_len(10), rep, times = 4)
#X laply(seq_len(10), matrix, nrow = 2, ncol = 2)
laply <-  function(.data, .fun = NULL, ..., .progress = "none", .drop = TRUE) {
  if (is.character(.fun)) .fun <- do.call("each", as.list(.fun))
  if (!is.function(.fun)) stop(".fun is not a function.")
  
  if (!inherits(.data, "split")) .data <- as.list(.data)
  res <- llply(.data = .data, .fun = .fun, ..., .progress = .progress)
  
  list_to_array(res, attr(.data, "split_labels"), .drop)
}


# Split data frame, apply function, and return results in an array
# For each subset of data frame, apply function then combine results into an array
# 
# All plyr functions use the same split-apply-combine strategy: they split the
# input into simpler pieces, apply \code{.fun} to each piece, and then combine
# the pieces into a single data structure.  This function splits data frames
# by variable and combines the result into an array.  If there are no results,
# then this function will return a vector of length 0 (\code{vector()}).
# 
# \code{daply} with a function that operates column-wise is similar to
# \code{\link{aggregate}}. 
# 
# @keyword manip
# @arguments data frame to be processed
# @arguments variables to split data frame by, as quoted variables, a formula or character vector
# @arguments function to apply to each piece
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @arguments should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
# @value if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#X daply(baseball, .(year), nrow)
#X
#X # Several different ways of summarising by variables that should not be 
#X # included in the summary
#X 
#X daply(baseball[, c(2, 6:9)], .(year), mean)
#X daply(baseball[, 6:9], .(baseball$year), mean)
#X daply(baseball, .(year), function(df) mean(df[, 6:9]))
daply <- function(.data, .variables, .fun = NULL, ..., .progress = "none", .drop = TRUE) {
  .data <- as.data.frame(.data)
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables)
  
  laply(.data = pieces, .fun = .fun, ..., .progress = .progress, .drop = .drop)
}

# Split array, apply function, and return results in an array
# For each slice of an array, apply function then combine results into an array
# 
# All plyr functions use the same split-apply-combine strategy: they split the
# input into simpler pieces, apply \code{.fun} to each piece, and then combine
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
# 
# @keyword manip
# @arguments matrix, array or data frame to be processed
# @arguments a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions
# @arguments function to apply to each piece
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @arguments should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
# @value if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#X dim(ozone)
#X aaply(ozone, 1, mean)
#X aaply(ozone, 1, mean, .drop = FALSE)
#X aaply(ozone, 3, mean)
#X aaply(ozone, c(1,2), mean)
#X
#X dim(aaply(ozone, c(1,2), mean))
#X dim(aaply(ozone, c(1,2), mean, .drop = FALSE)) 
#X
#X aaply(ozone, 1, each(min, max))
#X aaply(ozone, 3, each(min, max))
#X 
#X standardise <- function(x) (x - min(x)) / (max(x) - min(x))
#X aaply(ozone, 3, standardise)
#X aaply(ozone, 1:2, standardise)
#X  
#X aaply(ozone, 1:2, diff)
aaply <- function(.data, .margins, .fun = NULL, ..., .progress = "none", .drop = TRUE) {
  pieces <- splitter_a(.data, .margins)
  
  laply(.data = pieces, .fun = .fun, ..., .progress = .progress, .drop = .drop)
}
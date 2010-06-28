#' Split list, apply function, and return results in an array.
#' For each element of a list, apply function then combine results into an array
#' 
#' All plyr functions use the same split-apply-combine strategy: they split the
#' input into simpler pieces, apply \code{.fun} to each piece, and then combine
#' the pieces into a single data structure.  This function splits lists by
#' elements and combines the result into an array.  If there are no results,
#' then this function will return a vector of length 0 (\code{vector()}).
#' 
#' \code{laply} is very similar in spirit to \code{\link{sapply}} except that
#' it will always return an array, and the output is transposed with respect
#' \code{sapply} - each element of the list corresponds to a column, not a 
#' row.
#' 
#' 
#' @keywords manip
#' @param .data input list
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .drop should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
#' @return if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#' @export
#' @examples
#' laply(baseball, is.factor)
#' # cf
#' ldply(baseball, is.factor)
#' colwise(is.factor)(baseball)
#'
#' laply(seq_len(10), identity)
#' laply(seq_len(10), rep, times = 4)
#' laply(seq_len(10), matrix, nrow = 2, ncol = 2)
laply <-  function(.data, .fun = NULL, ..., .progress = "none", .drop = TRUE) {
  if (is.character(.fun)) .fun <- do.call("each", as.list(.fun))
  if (!is.function(.fun)) stop(".fun is not a function.")
  
  if (!inherits(.data, "split")) .data <- as.list(.data)
  res <- llply(.data = .data, .fun = .fun, ..., .progress = .progress)
  
  list_to_array(res, attr(.data, "split_labels"), .drop)
}


#' Split data frame, apply function, and return results in an array.
#' For each subset of data frame, apply function then combine results into an array
#' 
#' All plyr functions use the same split-apply-combine strategy: they split the
#' input into simpler pieces, apply \code{.fun} to each piece, and then combine
#' the pieces into a single data structure.  This function splits data frames
#' by variable and combines the result into an array.  If there are no results,
#' then this function will return a vector of length 0 (\code{vector()}).
#' 
#' \code{daply} with a function that operates column-wise is similar to
#' \code{\link{aggregate}}. 
#' 
#' @keywords manip
#' @param .data data frame to be processed
#' @param .variables variables to split data frame by, as quoted variables, a formula or character vector
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .drop should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
#' @return if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#' @export
#' @examples
#' daply(baseball, .(year), nrow)
#'
#' # Several different ways of summarising by variables that should not be 
#' # included in the summary
#' 
#' daply(baseball[, c(2, 6:9)], .(year), mean)
#' daply(baseball[, 6:9], .(baseball$year), mean)
#' daply(baseball, .(year), function(df) mean(df[, 6:9]))
daply <- function(.data, .variables, .fun = NULL, ..., .progress = "none", .drop = TRUE) {
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables)
  
  laply(.data = pieces, .fun = .fun, ..., .progress = .progress, .drop = .drop)
}

#' Split array, apply function, and return results in an array.
#' For each slice of an array, apply function then combine results into an array
#' 
#' All plyr functions use the same split-apply-combine strategy: they split the
#' input into simpler pieces, apply \code{.fun} to each piece, and then combine
#' the pieces into a single data structure.  This function splits matrices,
#' arrays and data frames by dimensions and combines the result into an array.
#' If there are no results, then this function will return a vector of length 0 (\code{vector()}).
#' 
#' This function is very similar to \code{\link{apply}}, except that it will
#' always return an array, and when the function returns >1 d data structures,
#' those dimensions are added on to the highest dimensions, rather than the
#' lowest dimensions.  This makes \code{aaply} idempotent, so that
#' \code{apply(input, X, identity)} is equivalent to \code{aperm(input, X)}.
#' 
#' 
#' @keywords manip
#' @param .data matrix, array or data frame to be processed
#' @param .margins a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .drop should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
#' @return if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#' @export
#' @examples
#' dim(ozone)
#' aaply(ozone, 1, mean)
#' aaply(ozone, 1, mean, .drop = FALSE)
#' aaply(ozone, 3, mean)
#' aaply(ozone, c(1,2), mean)
#'
#' dim(aaply(ozone, c(1,2), mean))
#' dim(aaply(ozone, c(1,2), mean, .drop = FALSE)) 
#'
#' aaply(ozone, 1, each(min, max))
#' aaply(ozone, 3, each(min, max))
#' 
#' standardise <- function(x) (x - min(x)) / (max(x) - min(x))
#' aaply(ozone, 3, standardise)
#' aaply(ozone, 1:2, standardise)
#'  
#' aaply(ozone, 1:2, diff)
aaply <- function(.data, .margins, .fun = NULL, ..., .progress = "none", .drop = TRUE) {
  pieces <- splitter_a(.data, .margins)
  
  laply(.data = pieces, .fun = .fun, ..., .progress = .progress, .drop = .drop)
}
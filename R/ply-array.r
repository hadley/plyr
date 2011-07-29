#' Split list, apply function, and return results in an array.
#'
#' For each element of a list, apply function then combine results into an
#' array. \code{laply} is similar in spirit to \code{\link{sapply}} except
#' that it will always return an array, and the output is transposed with
#' respect \code{sapply} - each element of the list corresponds to a column,
#' not a row.
#'
#' @template ply
#' @template l-
#' @template -a
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
laply <-  function(.data, .fun = NULL, ..., .progress = "none", .drop = TRUE, .parallel = FALSE) {
  if (is.character(.fun)) .fun <- do.call("each", as.list(.fun))
  if (!is.function(.fun)) stop(".fun is not a function.")
  
  if (!inherits(.data, "split")) .data <- as.list(.data)
  res <- llply(.data = .data, .fun = .fun, ..., 
    .progress = .progress, .parallel = .parallel)
  
  list_to_array(res, attr(.data, "split_labels"), .drop)
}


#' Split data frame, apply function, and return results in an array.
#'
#' For each subset of data frame, apply function then combine results into
#' an array.  \code{daply} with a function that operates column-wise is
#' similar to \code{\link{aggregate}}. 
#' 
#' @template ply
#' @section Input: This function splits data frames by variables.
#' @section Output:
#'   If there are no results, then this function will return a vector of
#'   length 0 (\code{vector()}).
#' @param .data data frame to be processed
#' @param .variables variables to split data frame by, as quoted
#'   variables, a formula or character vector
#' @param .drop_i should combinations of variables that do not appear in the 
#'   input data be preserved (FALSE) or dropped (TRUE, default)
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel 
#'   backend provided by foreach
#' @return if results are atomic with same type and dimensionality, a
#'   vector, matrix or array; otherwise, a list-array (a list with
#'   dimensions)
#' @param .drop_o should extra dimensions of length 1 in the output be
#'   dropped, simplifying the output.  Defaults to \code{TRUE}
#' @family array output
#' @family data frame input
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
daply <- function(.data, .variables, .fun = NULL, ..., .progress = "none", .drop_i = TRUE, .drop_o = TRUE, .parallel = FALSE) {
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables, drop = .drop_i)
  
  laply(.data = pieces, .fun = .fun, ..., 
    .progress = .progress, .drop = .drop_o, .parallel = .parallel)
}

#' Split array, apply function, and return results in an array.
#'
#' For each slice of an array, apply function, keeping results as an array.
#' This function is very similar to \code{\link{apply}}, except that it will
#' always return an array, and when the function returns >1 d data structures,
#' those dimensions are added on to the highest dimensions, rather than the
#' lowest dimensions.  This makes \code{aaply} idempotent, so that
#' \code{apply(input, X, identity)} is equivalent to \code{aperm(input, X)}.
#' 
#' @template ply
#' @template a-
#' @template -a
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
aaply <- function(.data, .margins, .fun = NULL, ..., .expand = TRUE, .progress = "none", .drop = TRUE, .parallel = FALSE) {
  pieces <- splitter_a(.data, .margins, .expand)
  
  laply(.data = pieces, .fun = .fun, ..., 
    .progress = .progress, .drop = .drop, .parallel = .parallel)
}
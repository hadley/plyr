#' Split list of data frames, apply function, and return results in an array.
#'
#' For each subset of list of data frames, apply function then combine results into
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
#' @return if results are atomic with same type and dimensionality, a
#'   vector, matrix or array; otherwise, a list-array (a list with
#'   dimensions)
#' @param .drop_o should extra dimensions of length 1 in the output be
#'   dropped, simplifying the output.  Defaults to \code{TRUE}
#' @family array output
#' @family data frame input
#' @export
baply <- function(.data, .variables, .fun = NULL, ..., .progress = "none",
                  .inform = FALSE, .drop_i = TRUE, .drop_o = TRUE, .parallel = FALSE,
                  .paropts = NULL) {
  .variables <- as.quoted(.variables)
  pieces <- splitter_b(.data, .variables, drop = .drop_i)

  laply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform, .drop = .drop_o,
    .parallel = .parallel, .paropts = .paropts)
}

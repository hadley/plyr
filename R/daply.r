#' Split data frame, apply function, and return results in an array.
#'
#' For each subset of data frame, apply function then combine results into
#' an array.  \code{daply} with a function that operates column-wise is
#' similar to \code{\link{aggregate}}.
#' To apply a function for each row, use \code{\link{aaply}} with
#' \code{.margins} set to \code{1}.
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
#' @examples
#' daply(baseball, .(year), nrow)
#'
#' # Several different ways of summarising by variables that should not be
#' # included in the summary
#'
#' daply(baseball[, c(2, 6:9)], .(year), colwise(mean))
#' daply(baseball[, 6:9], .(baseball$year), colwise(mean))
#' daply(baseball, .(year), function(df) colwise(mean)(df[, 6:9]))
daply <- function(.data, .variables, .fun = NULL, ..., .progress = "none",
                  .inform = FALSE, .drop_i = TRUE, .drop_o = TRUE, .parallel = FALSE,
                  .paropts = NULL) {
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables, drop = .drop_i)

  laply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform, .drop = .drop_o,
    .parallel = .parallel, .paropts = .paropts)
}

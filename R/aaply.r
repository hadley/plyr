#' Split array, apply function, and return results in an array.
#'
#' For each slice of an array, apply function, keeping results as an array.
#'
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
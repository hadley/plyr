#' Split array, apply function, and return results in a list.
#'
#' For each slice of an array, apply function then combine results into a
#' list.
#'
#' \code{alply} is somewhat similar to \code{\link{apply}} for cases
#' where the results are not atomic.
#'
#' @template ply
#' @template a-
#' @template -l
#' @export
#' @examples
#' alply(ozone, 3, quantile)
#' alply(ozone, 3, function(x) table(round(x)))
alply <- function(.data, .margins, .fun = NULL, ..., .expand = TRUE,
                  .progress = "none", .parallel = FALSE) {
  pieces <- splitter_a(.data, .margins, .expand)

  llply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .parallel = .parallel)
}

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
#' @param .dims If TRUE, the result will be a list-array with
#' dimensions determined by the margins.
#' @export
#' @examples
#' alply(ozone, 3, quantile)
#' alply(ozone, 3, function(x) table(round(x)))
alply <- function(.data, .margins, .fun = NULL, ..., .expand = TRUE,
                  .progress = "none", .inform = FALSE, .parallel = FALSE,
                  .paropts = NULL, .dims=FALSE) {
  pieces <- splitter_a(.data, .margins, .expand)

  res <- llply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)

  if (.dims) {
    labels <- attr(pieces, "split_labels")
    res_labels <- lapply(labels,
      function(x) if(is.factor(x)) levels(x) else sort(unique(x)))
    res_dim <- sapply(res_labels, length)
    dim(res) <-  res_dim
    dimnames(res) <- res_labels
  }
  res
}

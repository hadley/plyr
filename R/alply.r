#' Split array, apply function, and return results in a list.
#'
#' For each slice of an array, apply function then combine results into a
#' list.
#'
#' The list will have "dims" and "dimnames" corresponding to the
#' margins given. For instance \code{llply(x, c(3,2))} where \code{x}
#' has dims \code{c(4,3,2)} will give a result with dims \code{c(2,3)}.
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
                  .progress = "none", .inform = FALSE, .parallel = FALSE,
                  .paropts = NULL, .dims=FALSE) {
  pieces <- splitter_a(.data, .margins, .expand)

  res <- llply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)

  labels <- attr(pieces, "split_labels")
  res_labels <- lapply(labels, function(x) as.character(unique(x)))
  res_dim <- sapply(res_labels, length)
  dim(res) <-  res_dim
  dimnames(res) <- res_labels
  res
}

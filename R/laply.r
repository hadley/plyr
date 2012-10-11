#' Split list, apply function, and return results in an array.
#'
#' For each element of a list, apply function then combine results into an
#' array.
#'
#' \code{laply} is similar in spirit to \code{\link{sapply}} except
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

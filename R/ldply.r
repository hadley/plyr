#' Split list, apply function, and return results in a data frame.
#'
#' For each element of a list, apply function then combine results into a data
#' frame.
#'
#' @template ply
#' @template l-
#' @template -d
#' @export
ldply <- function(.data, .fun = NULL, ..., .progress = "none", .inform = FALSE,
                  .parallel = FALSE, .paropts = NULL) {
  if (!inherits(.data, "split")) .data <- as.list(.data)
  res <- llply(.data = .data, .fun = .fun, ...,
    .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)

  list_to_dataframe(res, attr(.data, "split_labels"))
}

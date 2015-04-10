#' Split array, apply function, and discard results.
#'
#' For each slice of an array, apply function and discard results
#'
#' @template ply
#' @template a-
#' @template -_
#' @export
a_ply <- function(.data, .margins, .fun = NULL, ..., .expand = TRUE,
                  .progress = "none", .inform = FALSE,
                  .print = FALSE, .parallel = FALSE, .paropts = NULL) {
  pieces <- splitter_a(.data, .margins, .expand)

  l_ply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform, .print = .print,
    .parallel = .parallel, .paropts = .paropts)
}

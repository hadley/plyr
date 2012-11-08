#' Split data frame, apply function, and discard results.
#'
#' For each subset of a data frame, apply function and discard results
#'
#' @template ply
#' @template d-
#' @template -_
#' @export
d_ply <- function(.data, .variables, .fun = NULL, ..., .progress = "none",
                  .inform = FALSE, .drop = TRUE, .print = FALSE,
                  .parallel = FALSE, .paropts = NULL) {
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables, drop = .drop)

  l_ply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform, .print = .print,
    .parallel = .parallel, .paropts = .paropts)
}

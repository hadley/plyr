#' Split array, apply function, and return results in a data frame.
#'
#' For each slice of an array, apply function then combine results into a data
#' frame.
#'
#' @template ply
#' @template a-
#' @template -d
#' @export
adply <- function(.data, .margins, .fun = NULL, ..., .expand = TRUE,
                  .progress = "none", .inform = FALSE, .parallel = FALSE,
                  .paropts = NULL) {
  pieces <- splitter_a(.data, .margins, .expand)

  ldply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)
}

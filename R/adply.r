#' Split array, apply function, and return results in a data frame.
#'
#' For each slice of an array, apply function then combine results into a data
#' frame.
#'
#' @template ply
#' @template a-
#' @template -d
#' @param .id name(s) of the index column(s).
#'   Pass \code{NULL} to avoid creation of the index column(s).
#'   Omit or pass \code{NA} to use the default names
#'   \code{"X1"}, \code{"X2"}, \ldots.
#'   Otherwise, this argument must have the same length as
#'   \code{.margins}.
#' @export
adply <- function(.data, .margins, .fun = NULL, ..., .expand = TRUE,
                  .progress = "none", .inform = FALSE, .parallel = FALSE,
                  .paropts = NULL, .id = NA) {
  pieces <- splitter_a(.data, .margins, .expand, .id)
  .id <- NA
  if (is.null(attr(pieces, "split_labels"))) {
    .id <- NULL
  }

  ldply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts,
    .id = .id)
}

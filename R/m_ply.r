#' Call function with arguments in array or data frame, discarding results.
#'
#' Call a multi-argument function with values taken from columns of an
#' data frame or array, and discard results into a list.
#'
#' @template ply
#' @template m-
#' @template -_
#' @export
m_ply <- function(.data, .fun = NULL, ..., .expand = TRUE, .progress = "none",
                  .inform = FALSE, .print = FALSE, .parallel = FALSE,
                  .paropts = NULL) {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  a_ply(.data = .data, .margins = 1, .fun = f, ..., .expand = .expand,
    .progress = .progress, .inform = .inform, .print = .print,
    .parallel = .parallel, .paropts = .paropts)
}

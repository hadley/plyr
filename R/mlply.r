#' Call function with arguments in array or data frame, returning a list.
#'
#' Call a multi-argument function with values taken from columns of an
#' data frame or array, and combine results into a list.
#'
#' @template ply
#' @template m-
#' @template -l
#' @export
#' @examples
#' mlply(cbind(1:4, 4:1), rep)
#' mlply(cbind(1:4, times = 4:1), rep)
#'
#' mlply(cbind(1:4, 4:1), seq)
#' mlply(cbind(1:4, length = 4:1), seq)
#' mlply(cbind(1:4, by = 4:1), seq, to = 20)
mlply <- function(.data, .fun = NULL, ..., .expand = TRUE, .progress = "none",
                  .inform = FALSE, .parallel = FALSE, .paropts = NULL) {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  alply(.data = .data, .margins = 1, .fun = f, ...,
    .expand = .expand, .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)
}

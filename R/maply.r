#' Call function with arguments in array or data frame, returning an array.
#'
#' Call a multi-argument function with values taken from columns of an
#' data frame or array, and combine results into an array
#'
#' @template ply
#' @template m-
#' @template -a
#' @export
#' @examples
#' maply(cbind(mean = 1:5, sd = 1:5), rnorm, n = 5)
#' maply(expand.grid(mean = 1:5, sd = 1:5), rnorm, n = 5)
#' maply(cbind(1:5, 1:5), rnorm, n = 5)
maply <- function(.data, .fun = NULL, ..., .expand = TRUE, .progress = "none",
                  .inform = FALSE, .drop = TRUE, .parallel = FALSE,
                  .paropts = NULL) {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  aaply(.data = .data, .margins = 1, .fun = f, ...,
    .expand = .expand, .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts, .drop = .drop)
}

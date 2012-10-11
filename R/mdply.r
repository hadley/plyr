#' Call function with arguments in array or data frame, returning a data frame.
#'
#' Call a multi-argument function with values taken from columns of an
#' data frame or array, and combine results into a data frame
#'
#' @template ply
#' @template m-
#' @template -d
#' @export
#' @examples
#' mdply(data.frame(mean = 1:5, sd = 1:5), rnorm, n = 2)
#' mdply(expand.grid(mean = 1:5, sd = 1:5), rnorm, n = 2)
#' mdply(cbind(mean = 1:5, sd = 1:5), rnorm, n = 5)
#' mdply(cbind(mean = 1:5, sd = 1:5), as.data.frame(rnorm), n = 5)
mdply <- function(.data, .fun = NULL, ..., .expand = TRUE, .progress = "none",
                  .inform = FALSE, .parallel = FALSE, .paropts = NULL) {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  adply(.data = .data, .margins = 1, .fun = f, ...,
    .expand = .expand, .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)
}

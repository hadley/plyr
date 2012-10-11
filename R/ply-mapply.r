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
mdply <- function(.data, .fun = NULL, ..., .expand = TRUE, .progress = "none", .parallel = FALSE) {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  adply(.data = .data, .margins = 1, .fun = f, ...,
    .expand = .expand, .progress = .progress, .parallel = .parallel)
}

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
  .drop = TRUE, .parallel = FALSE) {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  aaply(.data = .data, .margins = 1, .fun = f, ...,
    .expand = .expand, .progress = .progress, .parallel = .parallel,
    .drop = drop)
}

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
mlply <- function(.data, .fun = NULL, ..., .expand = TRUE, .progress = "none", .parallel = FALSE) {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  alply(.data = .data, .margins = 1, .fun = f, ...,
    .expand = .expand, .progress = .progress, .parallel = .parallel)
}

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
                  .print = FALSE, .parallel = FALSE ) {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  a_ply(.data = .data, .margins = 1, .fun = f, ..., .expand = .expand,
    .progress = .progress, .print = .print, .parallel = .parallel)
}

.matrix_to_df <- function(.data) {
  cnames <- colnames(.data)
  if (is.null(cnames)) cnames <- rep("", ncol(.data))
  .data <- as.data.frame(.data, stringsAsFactors = FALSE)
  colnames(.data) <- cnames
  .data
}

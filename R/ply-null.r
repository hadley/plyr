#' Split list, apply function, and discard results.
#'
#' For each element of a list, apply function and discard results
#'
#' @template ply
#' @template l-
#' @template -_
#' @export
l_ply <- function(.data, .fun = NULL, ..., .progress = "none", .print = FALSE,
                  .parallel = FALSE) {
  if (is.character(.fun) || is.list(.fun)) .fun <- each(.fun)
  if (!is.function(.fun)) stop(".fun is not a function.")

  progress <- create_progress_bar(.progress)
  progress$init(length(.data))
  on.exit(progress$term())

  if (.parallel) {
    if (.print) message("Printing disabled for parallel processing")
    if (.progress != "none") message("Progress disabled for parallel processing")

    setup_parallel()
    ignore <- function(...) NULL
    foreach(d = .data, .combine = ignore) %dopar% .fun(d, ...)
  } else {
    .data <- as.list(.data)
    for(i in seq_along(.data)) {
      x <- .fun(.data[[i]], ...)
      if (.print) print(x)
      progress$step()
    }
  }

  invisible()
}

#' Split data frame, apply function, and discard results.
#'
#' For each subset of a data frame, apply function and discard results
#'
#' @template ply
#' @template d-
#' @template -_
#' @export
d_ply <- function(.data, .variables, .fun = NULL, ..., .progress = "none",
                  .drop = TRUE, .print = FALSE, .parallel = FALSE) {
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables, .drop = .drop)

  l_ply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .print = .print, .parallel = .parallel)
}

#' Split array, apply function, and discard results.
#'
#' For each slice of an array, apply function and discard results
#'
#' @template ply
#' @template a-
#' @template -_
#' @export
a_ply <- function(.data, .margins, .fun = NULL, ..., .expand = TRUE,
                  .progress = "none", .print = FALSE, .parallel = FALSE) {
  pieces <- splitter_a(.data, .margins, .expand)

  l_ply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .print = .print, .parallel = .parallel)
}

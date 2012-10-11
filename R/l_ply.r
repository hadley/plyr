#' Split list, apply function, and discard results.
#'
#' For each element of a list, apply function and discard results
#'
#' @template ply
#' @template l-
#' @template -_
#' @export
l_ply <- function(.data, .fun = NULL, ..., .progress = "none", .inform = FALSE,
                  .print = FALSE, .parallel = FALSE, .paropts = NULL) {
  if (is.character(.fun) || is.list(.fun)) .fun <- each(.fun)
  if (!is.function(.fun)) stop(".fun is not a function.")

  progress <- create_progress_bar(.progress)
  progress$init(length(.data))
  on.exit(progress$term())

  if (.parallel) {
    if (.print) message("Printing disabled for parallel processing")
    if (.progress != "none") message("Progress disabled for parallel processing")

    setup_parallel()
    .paropts$.combine <- function(...) NULL
    fe_call <- as.call(c(list(as.name("foreach"), d = as.name(".data")),
      .paropts))
    fe <- eval(fe_call)

    fe %dopar% .fun(d, ...)
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

#' Split list, apply function, and discard results.
#'
#' For each element of a list, apply function and discard results
#'
#' @template ply
#' @template l-
#' @template -_
#' @export
#' @examples
#' l_ply(llply(mtcars, round), table, .print = TRUE)
#' l_ply(baseball, function(x) print(summary(x)))
l_ply <- function(.data, .fun = NULL, ..., .progress = "none", .inform = FALSE,
                  .print = FALSE, .parallel = FALSE, .paropts = NULL) {
  if (is.character(.fun) || is.list(.fun)) .fun <- each(.fun)
  if (!is.function(.fun)) stop(".fun is not a function.")

  pieces <- as.list(.data)

  n <- length(pieces)
  if (n == 0) return(invisible())

  if (.parallel && .progress != "none") {
    message("Progress disabled when using parallel plyr")
    .progress <- "none"
  }

  progress <- create_progress_bar(.progress)
  progress$init(n)
  on.exit(progress$term())

  if (.parallel && .print) {
    message("Printing disabled for parallel processing")
    .print <- FALSE
  }

  do.ply <- function(i) {
    piece <- pieces[[i]]

    # Display informative error messages, if desired
    if (.inform) {
      res <- try(.fun(piece, ...))
      if (inherits(res, "try-error")) {
        piece <- paste(utils::capture.output(print(piece)), collapse = "\n")
        stop("with piece ", i, ": \n", piece, call. = FALSE)
      }
    } else {
      res <- .fun(piece, ...)
    }
    if (.print) {
      print(res)
    }
    progress$step()
  }
  if (.parallel) {
    setup_parallel()
    .paropts$.combine <- function(...) NULL

    i <- seq_len(n)
    fe_call <- as.call(c(list(quote(foreach::foreach), i = i), .paropts))
    fe <- eval(fe_call)

    foreach::`%dopar%`(fe, do.ply(i))
  } else {
    for (i in seq_len(n)) {
      do.ply(i)
    }
  }

  invisible()
}

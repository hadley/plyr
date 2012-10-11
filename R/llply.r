#' Split list, apply function, and return results in a list.
#'
#' For each element of a list, apply function, keeping results as a list.
#'
#' \code{llply} is equivalent to \code{\link{lapply}} except that it will
#' preserve labels and can display a progress bar.
#'
#' @template ply
#' @template l-
#' @template -l
#' @param .inform produce informative error messages?  This is turned off by
#'   by default because it substantially slows processing speed, but is very
#'   useful for debugging
#' @param .paropts a list of additional options passed into
#'   the \code{\link[foreach]{foreach}} function when parallel computation
#'   is enabled.  This is important if (for example) your code relies on
#'   external data or packages: use the \code{.export} and \code{.packages}
#'   arguments to supply them so that all cluster nodes have the correct
#'   environment set up for computing.
#' @export
#' @examples
#' llply(llply(mtcars, round), table)
#' llply(baseball, summary)
#' # Examples from ?lapply
#' x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
#'
#' llply(x, mean)
#' llply(x, quantile, probs = 1:3/4)
llply <- function(.data, .fun = NULL, ..., .progress = "none", .inform = FALSE,
                  .parallel = FALSE, .paropts = NULL) {
  if (is.null(.fun)) return(as.list(.data))
  if (is.character(.fun) || is.list(.fun)) .fun <- each(.fun)
  if (!is.function(.fun)) stop(".fun is not a function.")

  if (!inherits(.data, "split")) {
    pieces <- as.list(.data)

    # This special case can be done much faster with lapply, so do it.
    fast_path <- .progress == "none" && !.inform && !.parallel
    if (fast_path) {
      return(structure(lapply(pieces, .fun, ...), dim = dim(pieces)))
    }

  } else {
    pieces <- .data
  }

  n <- length(pieces)
  if (n == 0) return(list())

  if (.parallel && .progress != "none") {
    message("Progress disabled when using parallel plyr")
    .progress <- "none"
  }

  progress <- create_progress_bar(.progress)
  progress$init(n)
  on.exit(progress$term())

  result <- vector("list", n)
  do.ply <- function(i) {
    piece <- pieces[[i]]

    # Display informative error messages, if desired
    if (.inform) {
      res <- try(.fun(piece, ...))
      if (inherits(res, "try-error")) {
        piece <- paste(capture.output(print(piece)), collapse = "\n")
        stop("with piece ", i, ": \n", piece, call. = FALSE)
      }
    } else {
      res <- .fun(piece, ...)
    }
    progress$step()
    res
  }
  if (.parallel) {
    setup_parallel()
    fe <- parallel_fe(n, .paropts)

    result <- fe %dopar% do.ply(i)
  } else {
    result <- loop_apply(n, do.ply)
  }

  attributes(result)[c("split_type", "split_labels")] <-
    attributes(pieces)[c("split_type", "split_labels")]
  names(result) <- names(pieces)

  # Only set dimension if not null, otherwise names are removed
  if (!is.null(dim(pieces))) {
    dim(result) <- dim(pieces)
  }

  result
}

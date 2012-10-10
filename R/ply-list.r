#' Split list, apply function, and return results in a list.
#'
#' For each element of a list, apply function, keeping results as a list.
#' \code{llply} is equivalent to \code{\link{lapply}} except that it will
#' preserve labels and can display a progress bar.
#'
#' @template ply
#' @template l-
#' @template -l
#' @param .inform produce informative error messages?  This is turned off by
#'   by default because it substantially slows processing speed, but is very
#'   useful for debugging
#' @export
#' @examples
#' llply(llply(mtcars, round), table)
#' llply(baseball, summary)
#' # Examples from ?lapply
#' x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
#'
#' llply(x, mean)
#' llply(x, quantile, probs = 1:3/4)
llply <- function(.data, .fun = NULL, ..., .progress = "none", .inform = FALSE, .parallel = FALSE,
  .captured_args = NULL, .captured_env = parent.frame()) {

  if (is.null(.fun)) return(as.list(.data))
  if (is.character(.fun) || is.list(.fun)) .fun <- each(.fun)
  if (!is.function(.fun)) stop(".fun is not a function.")

  dot_args = match.call(expand.dots = FALSE)$...
  if (!is.null(dot_args)) {
    if (!is.null(.captured_args)) {
      stop("Can't have both .captured_args and ... arguments.")
    } else {
      .captured_args = dot_args
    }
  }


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
    all_args <- c(list(piece), .captured_args)

    # Display informative error messages, if desired
    if (.inform) {
      res <- try(do.call(.fun, all_args, envir = .captured_env))
      if (inherits(res, "try-error")) {
        piece <- paste(capture.output(print(piece)), collapse = "\n")
        stop("with piece ", i, ": \n", piece, call. = FALSE)
      }
    } else {
      res <- do.call(.fun, all_args, envir = .captured_env)
    }
    progress$step()
    res
  }
  if (.parallel) {
    setup_parallel()
    result <- foreach(i = seq_len(n)) %dopar% do.ply(i)
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

#' Split data frame, apply function, and return results in a list.
#'
#' For each subset of a data frame, apply function then combine results into a
#' list. \code{dlply} is similar to \code{\link{by}} except that the results
#' are returned in a different format.
#'
#' @template ply
#' @template d-
#' @template -l
#' @export
#' @examples
#' linmod <- function(df) {
#'   lm(rbi ~ year, data = mutate(df, year = year - min(year)))
#' }
#' models <- dlply(baseball, .(id), linmod)
#' models[[1]]
#'
#' coef <- ldply(models, coef)
#' with(coef, plot(`(Intercept)`, year))
#' qual <- laply(models, function(mod) summary(mod)$r.squared)
#' hist(qual)
dlply <- function(.data, .variables, .fun = NULL, ..., .progress = "none", .drop = TRUE, .parallel = FALSE) {
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables, drop = .drop)

  llply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .parallel = .parallel)
}

#' Split array, apply function, and return results in a list.
#'
#' For each slice of an array, apply function then combine results into a
#' list. \code{alply} is somewhat similar to \code{\link{apply}} for cases
#' where the results are not atomic.
#'
#' @template ply
#' @template a-
#' @template -l
#' @export
#' @examples
#' alply(ozone, 3, quantile)
#' alply(ozone, 3, function(x) table(round(x)))
alply <- function(.data, .margins, .fun = NULL, ..., .expand = TRUE, .progress = "none", .parallel = FALSE) {
  pieces <- splitter_a(.data, .margins, .expand)

  llply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .parallel = .parallel)
}

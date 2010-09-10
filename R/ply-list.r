#' Split list, apply function, and return results in a list.
#' For each element of a list, apply function then combine results into a list
#' 
#' All plyr functions use the same split-apply-combine strategy: they split the
#' input into simpler pieces, apply \code{.fun} to each piece, and then combine
#' the pieces into a single data structure.  This function splits lists by
#' elements and combines the result into a list.  If there are no results, then
#' this function will return a list of length 0  (\code{list()}).
#' 
#' \code{llply} is equivalent to \code{\link{lapply}} except that it will 
#' preserve labels and can display a progress bar.
#' 
#' 
#' @keywords manip
#' @param .data list to be processed
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .inform produce informative error messages?  This is turned off by
#'   by default because it substantially slows processing speed, but is very
#'   useful for debugging
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel 
#'   backend provided by foreach
#' @return list of results
#' @export
#' @examples
#' llply(llply(mtcars, round), table)
#' llply(baseball, summary)
#' # Examples from ?lapply
#' x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
#'
#' llply(x, mean)
#' llply(x, quantile, probs = 1:3/4)
llply <- function(.data, .fun = NULL, ..., .progress = "none", .inform = FALSE, .parallel = FALSE) {
  if (is.null(.fun)) return(as.list(.data))
  if (is.character(.fun)) .fun <- each(.fun)
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
    if (!require("foreach")) {
      stop("foreach package required for parallel plyr operation", 
        call. = FALSE)
    }
    if (getDoParWorkers() == 1) {
      warning("No parallel backend registered", call. = TRUE)
    }
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
#' For each subset of a data frame, apply function then combine results into a  list
#' 
#' All plyr functions use the same split-apply-combine strategy: they split the
#' input into simpler pieces, apply \code{.fun} to each piece, and then combine
#' the pieces into a single data structure.  This function splits data frames
#' by variables and combines the result into a list.  If there are no results,
#' then this function will return a list of length 0  (\code{list()}).
#' 
#' \code{dlply} is similar to \code{\link{by}} except that the results are 
#' returned in a different format.
#' 
#' 
#' @keywords manip
#' @param .data data frame to be processed
#' @param .variables variables to split data frame by, as quoted variables, a formula or character vector
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .drop should combinations of variables that do not appear in the 
#'   data be preserved (FALSE) or dropped (TRUE, default)
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel 
#'   backend provided by foreach
#' @return if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#' @export
#' @examples
#' linmod <- function(df) lm(rbi ~ year, data = transform(df, year = year - min(year)))
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
#' For each slice of an array, apply function then combine results into a list
#' 
#' All plyr functions use the same split-apply-combine strategy: they split the
#' input into simpler pieces, apply \code{.fun} to each piece, and then combine
#' the pieces into a single data structure.  This function splits matrices,
#' arrays and data frames by dimensions and combines the result into a list. 
#' If there are no results, then this function will return a list of length 0 
#' (\code{list()}).
#' 
#' \code{alply} is somewhat similar to \code{\link{apply}} for cases where the
#' results are not atomic.
#' 
#' 
#' @keywords manip
#' @export
#' @param .data matrix, array or data frame to be processed
#' @param .margins a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .expand if \code{.data} is a data frame, should output be 1d 
#'   (expand = FALSE), with an element for each row; or nd (expand = TRUE),
#'    with a dimension for each variable.
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel 
#'   backend provided by foreach
#' @return list of results
#' @examples
#' alply(ozone, 3, quantile)
#' alply(ozone, 3, function(x) table(round(x)))
alply <- function(.data, .margins, .fun = NULL, ..., .expand = TRUE, .progress = "none", .parallel = FALSE) {
  pieces <- splitter_a(.data, .margins, .expand)
  
  llply(.data = pieces, .fun = .fun, ..., 
    .progress = .progress, .parallel = .parallel)
}

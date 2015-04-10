#' Experimental iterator based version of llply.
#'
#' Because iterators do not have known length, \code{liply} starts by
#' allocating an output list of length 50, and then doubles that length
#' whenever it runs out of space.  This gives O(n ln n) performance rather
#' than the O(n ^ 2) performance from the naive strategy of growing the list
#' each time.
#'
#' @section Warning:Deprecated, do not use in new code.
#' @seealso \code{\link{plyr-deprecated}}
#' @keywords manip
#' @param .iterator iterator object
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @export
# EXCLUDE COVERAGE START
liply <- function(.iterator, .fun = NULL, ...) {
  .Deprecated("llply")
  stopifnot(inherits(.iterator, "iter"))
  if (is.null(.fun)) return(as.list(.iterator))

  iterator <- itertools::ihasNext(.iterator)

  if (is.character(.fun)) .fun <- each(.fun)
  if (!is.function(.fun)) stop(".fun is not a function.")

  result <- vector("list", 50)
  i <- 0

  while(itertools::hasNext(iterator)) {
    piece <- iterators::nextElem(iterator)
    res <- .fun(piece, ...)

    # Double length of vector when necessary.  Gives O(n ln n) performance
    # instead of naive O(n^2)
    i <- i + 1
    if (i > length(result)) {
      length(result) <- length(result) * 2
    }
    if (!is.null(res)) result[[i]] <- res
  }
  length(result) <- i

  result
}

#' Split iterator that returns values, not indices.
#'
#' @section Warning:Deprecated, do not use in new code.
#' @seealso \code{\link{plyr-deprecated}}
#' @keywords internal
#' @export
isplit2 <- function (x, f, drop = FALSE, ...)  {
  .Deprecated(c("splitter_d", "splitter_a"))
  it <- iterators::isplit(seq_len(nrow(x)), f, drop = drop, ...)
  nextEl <- function() {
    i <- iterators::nextElem(it)
    x[i$value, , drop = FALSE]
  }
  structure(list(nextElem = nextEl), class = c("abstractiter", "iter"))
}
# EXCLUDE COVERAGE END

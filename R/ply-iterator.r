#' Experimental iterator based version of llply.
#' 
#' Because iterators do not have known length, \code{liply} starts by 
#' allocating an output list of length 50, and then doubles that length 
#' whenever it runs out of space.  This gives O(n ln n) performance rather 
#' than the O(n ^ 2) performance from the naive strategy of growing the list
#' each time.
#' 
#' @keywords manip
#' @param .iterator iterator object
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @examples
#' if(require("itertools")) {
#'   baseball_id <- plyr:::isplit2(baseball, baseball$id)
#'   liply(baseball_id, summarise, mean_rbi = mean(rbi, na.rm = TRUE))
#'   system.time(dlply(baseball, "id", summarise, mean_rbi = mean(rbi)))
#' }
liply <- function(.iterator, .fun = NULL, ...) {
  stopifnot(iterator::is.iterator(.iterator))
  if (is.null(.fun)) return(as.list(.iterator))
  
  iterator <- iterator::icanhasnext(.iterator)
  
  if (is.character(.fun)) .fun <- each(.fun)
  if (!is.function(.fun)) stop(".fun is not a function.")
  
  result <- vector("list", 50)
  i <- 0

  while(iterator$hasNext()) {
    piece <- iterator$nextElem()
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
#' @keywords internal
isplit2 <- function (x, f, drop = FALSE, ...)  {
  it <- iterator::isplit(seq_len(nrow(x)), f, drop = drop, ...)
  nextEl <- function() {
    i <- iterator::nextElem(it)
    x[i$value, , drop = FALSE]
  }
  iterator::new_iterator(nextEl)
}

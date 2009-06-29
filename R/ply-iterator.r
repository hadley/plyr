liply <- function(.iterator, .fun = NULL, ...) {
  stopifnot(is.iterator(.iterator))
  if (is.null(.fun)) return(as.list(.iterator))
  
  iterator <- icanhasnext(.iterator)
  
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
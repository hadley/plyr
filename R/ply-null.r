# To nothing -----------------------------------------------------------------
#  - purely for side effects (graphics, io, etc)
#  - remember to print lattice and ggplot2 graphics

l_ply <- function(data, fun = NULL, ..., .progress = NULL) {
  if (is.character(fun)) fun <- match.fun(fun)
  
  if (is.null(.progress))  .progress <- progress_null()
  .progress$init(length(data))
  
  data <- as.list(data)
  for(i in seq_along(data)) {
    fun(data[[i]], ...)
    .progress$step()
  }
  
  .progress$term()
  invisible()
}

d_ply <- function(data, vars, fun = NULL, ..., .progress = NULL) {
  data <- as.data.frame(data)
  pieces <- splitter_d(data, vars)
  
  l_ply(pieces, fun, .progress = .progress)
}

a_ply <- function(data, margins, fun = NULL, ..., .progress = NULL) {
  pieces <- splitter_a(data, margins)
  
  l_ply(pieces, fun, .progress = .progress)
}
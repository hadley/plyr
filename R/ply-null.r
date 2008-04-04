# To nothing -----------------------------------------------------------------
#  - purely for side effects (graphics, io, etc)
#  - remember to print lattice and ggplot2 graphics

l_ply <- function(data, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  f <- robustify(fun, .try = .try, .quiet = .quiet, .explode = .explode)
  
  if (is.null(.progress))  .progress <- progress_null()
  .progress$init(length(data))
  
  data <- as.list(data)
  for(i in seq_along(data)) {
    f(data[[i]], ...)
    .progress$step()
  }
  
  .progress$term()
  invisible()
}

d_ply <- function(data, vars, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  data <- as.data.frame(data)
  pieces <- splitter_d(data, vars)
  
  l_ply(pieces, fun, .try = .try, .quiet = .quiet, .explode = .explode, .progress = .progress)
}

a_ply <- function(data, margins, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  pieces <- splitter_a(data, margins)
  
  l_ply(pieces, fun, .try = .try, .quiet = .quiet, .explode = .explode, .progress = .progress)
}
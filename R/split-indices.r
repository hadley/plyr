# l(plyr)
# dyn.load("src/split-numeric.so")
# split_indices(1L:5L, c(1L, 1L, 1L, 2L, 2L), 2L)

#' Split indices.
#' An optimised version of split for the special case of splitting row
#' indices into groups, as used by \code{\link{splitter_d}}
#' @useDynLib plyr
split_indices <- function(x, f, n = max(f))
  .Call("split_indices", x, f, as.integer(n))
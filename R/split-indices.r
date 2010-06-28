#' Split indices.
#' An optimised version of split for the special case of splitting row
#' indices into groups, as used by \code{\link{splitter_d}}
#'
#' @param index integer indices
#' @param group integer groups
#' @param n largest integer (may not appear in index)
#' @useDynLib plyr
#' @keywords internal manip
split_indices <- function(index, group, n = max(group)) {
  if (length(index) == 0) return(integer())
  .Call("split_indices", index, group, as.integer(n))
}
  
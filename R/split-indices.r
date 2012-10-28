#' Split indices.
#'
#' An optimised version of split for the special case of splitting row
#' indices into groups, as used by \code{\link{splitter_d}}
#'
#' @param index integer indices
#' @param group integer groups
#' @param n largest integer (may not appear in index)
#' @useDynLib plyr
#' @keywords internal manip
#' @export
split_indices <- function(group, n = max(group)) {
  if (length(group) == 0) return(integer())
  stopifnot(is.integer(group))
  n <- as.integer(n)

  .Call("split_indices", group, as.integer(n))
}

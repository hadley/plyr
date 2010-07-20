#' Split indices.
#' An optimised version of split for the special case of splitting row
#' indices into groups, as used by \code{\link{splitter_d}}
#'
#' @param index integer indices
#' @param group integer groups
#' @param n largest integer (may not appear in index)
#' @useDynLib plyr
#' @keywords internal manip
loop_apply <- function(n, f, env = parent.frame()) {
  .Call("loop_apply", as.integer(n), f, env)
}
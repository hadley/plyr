#' Loop apply
#'
#' An optimised version of lapply for the special case of operating on
#' \code{seq_len(n)}
#'
#' @param n length of sequence
#' @param f function to apply to each integer
#' @param env environment in which to evaluate function
#' @keywords internal manip
loop_apply <- function(n, f, env = parent.frame()) {
  .Call(loop_apply_, as.integer(n), f, env)
}

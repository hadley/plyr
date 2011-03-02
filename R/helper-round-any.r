#' Round to multiple of any number.
#' 
#' @param x numeric vector to round
#' @param accuracy number to round to
#' @param f rounding function: \code{\link{floor}}, \code{\link{ceiling}} or 
#'  \code{\link{round}}
#' @keywords manip
#' @export
#' @examples
#' round_any(135, 10)
#' round_any(135, 100)
#' round_any(135, 25)
#' round_any(135, 10, floor)
#' round_any(135, 100, floor)
#' round_any(135, 25, floor)
#' round_any(135, 10, ceiling)
#' round_any(135, 100, ceiling)
#' round_any(135, 25, ceiling)
round_any <- function(x, accuracy, f = round) {
  f(x / accuracy) * accuracy
}
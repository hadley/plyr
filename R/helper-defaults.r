#' Set defaults.
#'
#' Convient method for combining a list of values with their defaults.
#'
#' @param x list of values
#' @param y defaults
#' @keywords manip
#' @export
defaults <- function(x, y)  {
  c(x, y[setdiff(names(y), names(x))])
}

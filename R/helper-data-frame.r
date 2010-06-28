#' Make a function return a data frame.
#' Create a new function that returns the existing function wrapped in a data.frame
#' 
#' This is useful when calling \code{*dply} functions with a function that
#' returns a vector, and you want the output in rows, rather than columns
#' 
#' @keywords manip
#' @param x function to make return a data frame
#' @param row.names necessary to match the generic, but not used
#' @param optional necessary to match the generic, but not used
#' @param ... necessary to match the generic, but not used
#' @method as.data.frame function
#' @export
as.data.frame.function <- function(x, row.names, optional, ...) {
  name <- deparse(substitute(x))
  function(...) data.frame(value = x(...))
}
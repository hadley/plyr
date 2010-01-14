#' Determine if a vector is discrete
#' A discrete vector is a factor or a character vector
#' 
#' @param x vector to test
#' @keywords internal
#' @export
#' @examples
#' is.discrete(1:10)
#' is.discrete(c("a", "b", "c"))
#' is.discrete(factor(c("a", "b", "c")))
is.discrete <- function(x) is.factor(x) || is.character(x) || is.logical(x)

#' Un-rowname
#' Strip rownames from an object
#' 
#' @keywords internal
#' @param x data frame
#' @export
unrowname <- function(x) {
  rownames(x) <- NULL
  x
}

#' Function that always returns true
#' 
#' @param ... all input ignored
#' @return \code{TRUE}
#' @keywords internal
#' @seealso \code{\link{colwise}} which uses it
#' @export
true <- function(...) TRUE
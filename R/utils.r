is.discrete <- function(x) is.character(x) || is.factor(x) || is.logical(x)

unrowname <- function(x) {
  rownames(x) <- NULL
  x
}

# Determine if a vector is discrete
# A discrete vector is a factor or a character vector
# 
# @arguments vector to test
# @keyword internal
#X is.discrete(1:10)
#X is.discrete(c("a", "b", "c"))
#X is.discrete(factor(c("a", "b", "c")))
is.discrete <- function(x) is.factor(x) || is.character(x) || is.logical(x)

unrowname <- function(x) {
  rownames(x) <- NULL
  x
}

reorder.character <- function(x, X, FUN = mean, ...) {
  reorder(factor(x), X = X, FUN = FUN, ...)
}
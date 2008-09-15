# Determine if a vector is discrete
# A discrete vector is a factor or a character vector
# 
# @arguments vector to test
# @keyword internal
#X is.discrete(1:10)
#X is.discrete(c("a", "b", "c"))
#X is.discrete(factor(c("a", "b", "c")))
is.discrete <- function(x) is.factor(x) || is.character(x) || is.logical(x)

# Un-rowname
# Strip rownames from an object
# 
# @keywords internal
unrowname <- function(x) {
  rownames(x) <- NULL
  x
}

# Reorder character
# Make it possible to reorder character vectors
# 
# Should be removed once this is built into R.
# 
# @keyword internal
reorder.character <- function(x, X, FUN = mean, ...) {
  reorder(factor(x), X = X, FUN = FUN, ...)
}
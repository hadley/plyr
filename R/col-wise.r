# Column-wise function
# Turn a function that operates on a vector into a function that operates column-wise on a data.frame
#
# \code{catcolwise} and \code{numcolwise} provide version that only operate
# on discrete and numeric variables respectively
# 
# @arguments function
# @arguments should the function with wrapped with \code{\link{failwith}(NA)} 
# @arguments function that tests columns for inclusion
# @alias catcolwise
# @alias numcolwise
colwise <- function(fun, .try = FALSE, .if = function(x) TRUE) {
  f <- if (.try) failwith(NA, fun) else fun
  function(df, ...) laply(Filter(.if, df), f, ...)  
}

catcolwise <- function(fun, .try = FALSE) 
  colwise(fun, .try = .try, .if = is.discrete)
}
numcolwise <- function(fun, .try = FALSE) {
  colwise(fun, .try = .try, .if = is.numeric)
}


is.discrete <- function(x) is.character(x) || is.factor(x) || is.logical(x)

# Aggregate multiple functions into a single function
# Combine multiple functions to a single function returning a named vector of outputs
# 
# Each function should produce a single number as output
# 
# @arguments functions to combine
# @keyword manip
#X each(min, max)(1:10)
#X each(length, mean, var)(rnorm(100))
each <- function(...) {
  fnames <- laply(match.call()[-1], deparse)
  fs <- list(...)
  n <- length(fs)
  
  function(x, ...) {
    results <- vector("numeric", length=n)
    for(i in 1:n) results[[i]] <- fs[[i]](x, ...)
    names(results) <- fnames
    results
  }
}
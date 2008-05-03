colwise <- function(fun, .try = FALSE, .if = function(x) TRUE) {
  f <- if (.try) failwith(NA, fun) else fun
  function(df, ...) laply(Filter(.if, df), f, ...)  
}

is.discrete <- function(x) is.character(x) || is.factor(x) || is.logical(x)

catcolwise <- function(fun, .try = FALSE) {
  colwise(fun, .try = .try, .if = is.discrete)
}
numcolwise <- function(fun, .try = FALSE) {
  colwise(fun, .try = .try, .if = is.numeric)
}

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
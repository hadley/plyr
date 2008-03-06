colwise <- function(fun, ..., .try = FALSE, .if = function(x) TRUE) {
  f <- if (.try) failwith(NA, fun) else fun
  function(df) t(sapply(df[sapply(df, .if)], f, ...))
  # function(df) laply(df, f, ..., .filter = .if, .try = TRUE)
  
}

is.discrete <- function(x) is.character(x) || is.factor(x)

catcolwise <- function(fun, ..., .try = FALSE) {
  colwise(fun, ..., .try = .try, .if = is.discrete)
}
numcolwise <- function(fun, ..., .try = FALSE) {
  colwise(fun, ..., .try = .try, .if = is.numeric)
}

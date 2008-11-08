# Column-wise function
# Turn a function that operates on a vector into a function that operates column-wise on a data.frame
#
# \code{catcolwise} and \code{numcolwise} provide version that only operate
# on discrete and numeric variables respectively
# 
# @arguments function
# @arguments function that tests columns for inclusion
# @alias catcolwise
# @alias numcolwise
colwise <- function(.fun, .if = function(x) TRUE) {
  function(df, ...) {
    filtered <- Filter(.if, df)
    if (ncol(filtered) == 0) return(data.frame())
    
    df <- do.call("data.frame", alply(filtered, 2, .fun, ...))
    names(df) <- names(filtered)
    df
  }
}

catcolwise <- function(.fun, .try = FALSE) {
  colwise(.fun, .if = is.discrete)
}
numcolwise <- function(.fun, .try = FALSE) {
  colwise(.fun, .if = is.numeric)
}


# Column-wise function
# Turn a function that operates on a vector into a function that operates column-wise on a data.frame
#
# \code{catcolwise} and \code{numcolwise} provide version that only operate
# on discrete and numeric variables respectively
# 
# @arguments function
# @arguments either function that tests columns for inclusion, or a quoted object giving which columns to process
# @alias catcolwise
# @alias numcolwise
#X # Count number of missing values
#X nmissing <- function(x) sum(is.na(x))
#X
#X # Apply to every column in a data frame 
#X colwise(nmissing)(baseball)
#X # This syntax looks a little different.  It is shorthand for the 
#X # the following:
#X f <- colwise(nmissing)
#X f(baseball)
#X
#X # This is particularly useful in conjunction with d*ply
#X ddply(baseball, .(year), colwise(nmissing))
#X 
#X # To operate only on specified columns, supply them as the second
#X # argument.  Many different forms are accepted.
#X ddply(baseball, .(year), colwise(nmissing, .(sb, cs, so)))
#X ddply(baseball, .(year), colwise(nmissing, c("sb", "cs", "so")))
#X ddply(baseball, .(year), colwise(nmissing, ~ sb + cs + so))
#X
#X # Alternatively, you can specify a boolean function that determines
#X # whether or not a column should be included
#X ddply(baseball, .(year), colwise(nmissing, is.character))
#X ddply(baseball, .(year), colwise(nmissing, is.numeric))
#X ddply(baseball, .(year), colwise(nmissing, is.discrete))
#X
#X # These last two cases are particularly common, so some shortcuts are 
#X # provided:
#X ddply(baseball, .(year), numcolwise(nmissing))
#X ddply(baseball, .(year), catcolwise(nmissing))
colwise <- function(.fun, .cols = function(x) TRUE) {
  if (!is.function(.cols)) {
    .cols <- as.quoted(.cols)
    filter <- function(df) as.data.frame(eval.quoted(.cols, df))
  } else {
    filter <- function(df) Filter(.cols, df)
  }
  
  function(df, ...) {
    filtered <- filter(df)
    if (ncol(filtered) == 0) return(data.frame())
    
    df <- do.call("data.frame", alply(filtered, 2, .fun, ...))
    names(df) <- names(filtered)
    df
  }
}

catcolwise <- function(.fun, .try = FALSE) {
  colwise(.fun, is.discrete)
}
numcolwise <- function(.fun, .try = FALSE) {
  colwise(.fun, is.numeric)
}


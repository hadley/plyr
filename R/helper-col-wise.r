#' Column-wise function.
#' Turn a function that operates on a vector into a function that operates
#' column-wise on a data.frame.
#'
#' By default, the generated function preserves the rownames of the data.frame.
#' To set the rownames differently, you can specify an argument \code{row.names}
#' to the generated function.
#' All other arguments for the generated function will be handed down
#' into the vector function.
#'
#' \code{catcolwise} and \code{numcolwise} provide versions that only operate
#' on discrete and numeric columns respectively.
#' 
#' @param .fun function operating on a vector
#' @param .cols either a function that tests columns for inclusion, or a quoted object giving which columns to process
#' @aliases colwise catcolwise numcolwise
#' @export colwise numcolwise catcolwise
#' @examples
#' # Count number of missing values
#' nmissing <- function(x) sum(is.na(x))
#'
#' # Apply to every column in a data frame 
#' colwise(nmissing)(baseball)
#' # This syntax looks a little different.  It is shorthand for the 
#' # the following:
#' f <- colwise(nmissing)
#' f(baseball)
#'
#' # This is particularly useful in conjunction with d*ply
#' ddply(baseball, .(year), colwise(nmissing))
#' 
#' # To operate only on specified columns, supply them as the second
#' # argument.  Many different forms are accepted.
#' ddply(baseball, .(year), colwise(nmissing, .(sb, cs, so)))
#' ddply(baseball, .(year), colwise(nmissing, c("sb", "cs", "so")))
#' ddply(baseball, .(year), colwise(nmissing, ~ sb + cs + so))
#'
#' # Alternatively, you can specify a boolean function that determines
#' # whether or not a column should be included
#' ddply(baseball, .(year), colwise(nmissing, is.character))
#' ddply(baseball, .(year), colwise(nmissing, is.numeric))
#' ddply(baseball, .(year), colwise(nmissing, is.discrete))
#'
#' # These last two cases are particularly common, so some shortcuts are 
#' # provided:
#' ddply(baseball, .(year), numcolwise(nmissing))
#' ddply(baseball, .(year), catcolwise(nmissing))
colwise <- function(.fun, .cols = true) {
  if (!is.function(.cols)) {
    .cols <- as.quoted(.cols)
    filter <- function(df) as.data.frame(eval.quoted(.cols, df))
  } else {
    filter <- function(df) Filter(.cols, df)
  }
  
  function(df, row.names = NULL, ...) {
    if (is.null(row.names)) row.names = rownames(df)
    stopifnot(is.data.frame(df))
    filtered <- filter(df)
    if (ncol(filtered) == 0) return(data.frame(row.names = row.names))
    
    df <- as.data.frame(lapply(filtered, .fun, ...), row.names = row.names)
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


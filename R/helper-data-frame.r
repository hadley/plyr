# Make a function return a data frame
# Create a new function that returns the existing function wrapped in a data.frame
# 
# This is useful when calling \code{*dply} functions with a function that
# returns a vector, and you want the output in rows, rather than columns
# 
# @keyword manip
# @argument function to make return a data frame
# @argument other arguments necessary to match the generic, but not used
as.data.frame.function <- function(x, row.names, optional, ...) {
  name <- deparse(substitute(x))
  function(...) data.frame(value = x(...))
}
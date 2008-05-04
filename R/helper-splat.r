# `Splat' arguments to a function
# Wraps a function in do.call 
# 
# @arguments function to splat
#X f <- function(mpg, wt, ...) data.frame(mw = mpg / wt)
#X ddply(mtcars, .(cyl), splat(f))
splat <- function(flat) {
  function(...) do.call(flat, ...)
}
# `Splat' arguments to a function
# Wraps a function in do.call 
# 
# This is useful when you want to pass a function a row of data frame or
# array, and don't want to manually pull it apart in your function.
# 
# @arguments function to splat
# @value a function
# 
#X hp_per_cyl <- function(hp, cyl, ...) hp / cyl
#X splat(hp_per_cyl)(mtcars[1,])
#X splat(hp_per_cyl)(mtcars)
#X
#X f <- function(mpg, wt, ...) data.frame(mw = mpg / wt)
#X ddply(mtcars, .(cyl), splat(f))
splat <- function(flat) {
  function(args, ...) {
    do.call(flat, c(args, list(...)))
  }
}
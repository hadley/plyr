#X f <- function(mpg, wt, ...) mpg / wt

#X ddply(mtcars, .(cyl), splat(f))
splat <- function(flat) {
  function(...) do.call(flat, ...)
}
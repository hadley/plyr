#' `Splat' arguments to a function.
#'
#' Wraps a function in do.call, so instead of taking multiple arguments, it
#' takes a single named list which will be interpreted as its arguments.
#'
#' This is useful when you want to pass a function a row of data frame or
#' array, and don't want to manually pull it apart in your function.
#'
#' @param flat function to splat
#' @return a function
#' @export
#' @examples
#' hp_per_cyl <- function(hp, cyl, ...) hp / cyl
#' splat(hp_per_cyl)(mtcars[1,])
#' splat(hp_per_cyl)(mtcars)
#'
#' f <- function(mpg, wt, ...) data.frame(mw = mpg / wt)
#' ddply(mtcars, .(cyl), splat(f))
splat <- function(flat) {
  function(args, ...) {
    do.call(flat, c(args, list(...)))
  }
}

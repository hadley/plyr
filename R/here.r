#' Capture current evaluation context.
#'
#' This function captures the current context, making it easier
#' to use \code{**ply} with functions that do special evaluation and
#' need access to the environment where ddply was called from.
#'
#' @author Peter Meilstrup, \url{https://github.com/crowding}
#' @param f a function that does non-standard evaluation
#' @export
#' @examples
#' df <- data.frame(a = rep(c("a","b"), each = 10), b = 1:20)
#' f1 <- function(label) {
#'    ddply(df, "a", mutate, label = paste(label, b))
#' }
#' \dontrun{f1("name:")}
#' # Doesn't work because mutate can't find label in the current scope
#'
#' f2 <- function(label) {
#'    ddply(df, "a", here(mutate), label = paste(label, b))
#' }
#' f2("name:")
#' # Works :)
here <- function(f) {
  call <- substitute(function(...) (f)(...), list(f = f)) # nolint
  fun <- eval(call, parent.frame())
  attr(fun, "srcref") <- srcfilecopy("<text>", deparse(call))
  fun
}

e2f <- function(expr) {
  eval.parent(substitute(function(...) expr))
}
constif <- function(x) trace_ast(x, visit_constif)

visit_constif <- function(x) UseMethod("visit_constif", x)

#' @export
visit_constif.default <- identity

#' @export
visit_constif.if <- function(x) {
  if (is.atomic(x[[2]])) {
    if (isTRUE(x[[2]]))
      x[[3]]
    else
      x[[4]]
  } else {
    x
  }
}

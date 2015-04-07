trace_ast <- function(x, visitor, ...) UseMethod("trace_ast", x)

#' @export
trace_ast.default <- function(x, visitor, ...) stop("Unknown class ", class(x))

#' @export
trace_ast.list <- function(x, visitor, ...) {
  x <- visitor(x, ...)
  x <- lapply(x, trace_ast, visitor, ...)
  x
}

#' @export
trace_ast.pairlist <-  function(x, visitor, ...) {
  x <- trace_ast.list(x, visitor, ...)
  as.pairlist(x)
}

#' @export
trace_ast.function <- function(x, visitor, ...) {
  x <- visitor(x, ...)
  formals(x) <- trace_ast(formals(x), visitor, ...)
  body(x) <- trace_ast(body(x), visitor, ...)
  x
}

#' @export
trace_ast.call <- function(x, visitor, ...) {
  x <- trace_ast.list(x, visitor, ...)
  as.call(x)
}

#' @export
`trace_ast.{` <- trace_ast.call

#' @export
`trace_ast.<-` <- trace_ast.call

#' @export
trace_ast.if <- trace_ast.call

#' @export
trace_ast.name <- function(x, visitor, ...) {
  visitor(x, ...)
}

#' @export
trace_ast.character <- trace_ast.name

#' @export
trace_ast.logical <- trace_ast.name

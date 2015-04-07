varsubst <- function(x, ...) trace_ast(x, visit_varsubst, ...)

visit_varsubst <- function(x, ...) UseMethod("visit_varsubst", x)

#' @export
visit_varsubst.default <- function(x, ...) x

#' @export
visit_varsubst.name <- function(x, ...) {
  args <- list(...)
  cx <- as.character(x)
  if (cx %in% names(args)) {
    args[[cx]]
  } else {
    x
  }
}

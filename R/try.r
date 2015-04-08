#' Fail with specified value.
#'
#' Modify a function so that it returns a default value when there is an
#' error.
#'
#' @param default default value
#' @param f function
#' @param quiet all error messages be suppressed?
#' @return a function
#' @seealso \code{\link{try_default}}
#' @keywords debugging
#' @export
#' @examples
#' f <- function(x) if (x == 1) stop("Error!") else 1
#' \dontrun{
#' f(1)
#' f(2)
#' }
#'
#' safef <- failwith(NULL, f)
#' safef(1)
#' safef(2)
failwith <- function(default = NULL, f, quiet = FALSE) {
  f <- match.fun(f)
  function(...) try_default(f(...), default, quiet = quiet)
}

#' Try, with default in case of error.
#'
#' \code{try_default} wraps try so that it returns a default value in the case of error.
#' \code{tryNULL} provides a useful special case when dealing with lists.
#'
#' @param expr expression to try
#' @param default default value in case of error
#' @param quiet should errors be printed (TRUE) or ignored (FALSE, default)
#' @export
#' @keywords internal
#' @seealso \code{\link{tryapply}}
try_default <- function(expr, default, quiet = FALSE) {
  result <- default
  if (quiet) {
    tryCatch(result <- expr, error = function(e) NULL)
  } else {
    try(result <- expr)
  }
  result
}

#' @rdname try_default
#' @export
tryNULL <- function(expr) try_default(expr, NULL, quiet = TRUE)


#' Apply with built in try.
#' Uses compact, lapply and tryNULL
#'
#' @param list list to apply function \code{f} on
#' @param f function
#' @param ... further arguments to \code{f}
#' @keywords internal
#' @export
tryapply <- function(list, fun, ...) {
  compact(lapply(list, function(x) tryNULL(fun(x, ...))))
}

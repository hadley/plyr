# Fail with
# Modify a function so that it returns a default value when there is an error.
# 
# @arguments default value
# @arguments function
# @argument should all error messages be suppressed?
# @value a function
# @seealso \code{\link{try_default}}
# @keyword debugging
#X f <- function(x) if (x == 1) stop("Error!") else 1
#X \dontrun{
#X f(1)
#X f(2)
#X }
#X
#X safef <- failwith(NULL, f)
#X safef(1)
#X safef(2) 
failwith <- function(default = NULL, f, quiet = FALSE) {
  f <- match.fun(f)
  function(...) try_default(f(...), default, quiet = quiet)
}

# Try, with default in case of error
# \code{try_default} wraps try so that it returns a default value in the case of error.
# 
# \code{tryNULL} provides a useful special case when dealing with lists.
# 
# @alias tryNULL
# @arguments expression to try
# @arguments default value in case of error
# @keyword internal
# @seealso \code{\link{tryapply}}
try_default <- function(expr, default = NA, quiet = FALSE) {
  result <- default
  if (quiet) {
    tryCatch(result <- expr, error = function(e) {})    
  } else {
    try(result <- expr)
  }
  result
}
tryNULL <- function(expr) try_default(expr, NULL, quiet = TRUE)


# Apply with built in try
# Uses compact, lapply and tryNULL
# 
# @keyword internal
tryapply <- function(list, fun, ...) {
  compact(lapply(list, function(x) tryNULL(fun(x, ...))))
}
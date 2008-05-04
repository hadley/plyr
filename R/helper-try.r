
failwith <- function(default = NULL, f, quiet = FALSE) {
  function(...) try_default(f(...), default, quiet = quiet)
}

try_default <- function(expr, default = NA, quiet = FALSE) {
  result <- default
  if (quiet) {
    tryCatch(result <- expr, error = function(e) {})    
  } else {
    try(result <- expr)
  }
  result
}

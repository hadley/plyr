progress_dots <- function() {
  n <- 0
  
  list(
    init = function(x) n <<- x,
    step = function()  cat("."),
    term = function()  cat("\n")
  )
}

progress_null <- function() {
  list(
    init = function(x) {},
    step = function()  {},
    term = function()  {}
  )
}
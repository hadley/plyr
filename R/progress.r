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

progress_txt <- function(style = 3, ...) {
  n <- 0
  txt <- NULL
  
  list(
    init = function(x) txt <<- txtProgressBar(max = x, style = style, ...),
    step = function() {
      n <<- n + 1
      setTxtProgressBar(txt, n)
    },
    term = function() cat("\n")
  )
}
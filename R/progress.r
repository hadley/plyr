# Create progress bar
# Create progress bar object from text string.
# 
# @arguments type of progress bar to create
# @arguments progress
create_progress_bar <- function(name = "none") {
  match.fun(paste("progress", name, sep="_"))()
}

progress_none <- function() {
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
    term = function() close(txt)
  )
}

progress_tk <- function(title = "plyr progress", ...) {
  stopifnot(require("tcltk", quiet=TRUE))
  n <- 0
  tk <- NULL
  
  list(
    init = function(x) tk <<- tkProgressBar(max = x, title = title, ...),
    step = function() {
      n <<- n + 1
      setTkProgressBar(tk, n)
    },
    term = function() close(txt)
  )
}

progress_win <- function(title = "plyr progress", ...) {
  n <- 0
  win <- NULL
  
  list(
    init = function(x) win <<- winProgressBar(max = x, title = title, ...),
    step = function() {
      n <<- n + 1
      setWinProgressBar(win, n)
    },
    term = function() close(txt)
  )
}
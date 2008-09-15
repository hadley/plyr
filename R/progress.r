# Create progress bar
# Create progress bar object from text string.
# 
# There are currently four types of progress bar:  "none", "text", "tk", and
#  "win".  See the individual documentation for more details.
# 
# @arguments type of progress bar to create
# @seealso \code{\link{progress_none}}, \code{\link{progress_text}}, \code{\link{progress_tk}}, \code{\link{progress_win}}
# @keywords asdf
create_progress_bar <- function(name = "none") {
  if (!is.character(name)) return(name)
  match.fun(paste("progress", name, sep="_"))()
}

# Null progress bar
# A progress bar that does nothing
# 
# This the default progress bar used by plyr functions.  It's very simple to
# understand - it does nothing!
# 
# @keywords internal
#X l_ply(1:100, progress. = "none")
progress_none <- function() {
  list(
    init = function(x) {},
    step = function()  {},
    term = function()  {}
  )
}

# Text progress bar
# A textual progress bar
# 
# This progress bar displays a textual progress bar that works on all 
# platforms.  It is a thin wrapper around the built-in 
# \code{\link{setTxtProgressBar}} and can be customised in the same way.
#
# @argument style of text bar, see Details section of \code{\link{txtProgressBar}}
#X l_ply(1:1000, identity, progress. = "text")
#X l_ply(1:1000, identity, progress. = progress_text(char = "-"))
progress_text <- function(style = 3, ...) {
  n <- 0
  txt <- NULL
  
  list(
    init = function(x) {
      txt <<- txtProgressBar(max = x, style = style, ...)
      setTxtProgressBar(txt, 0)
    },
    step = function() {
      n <<- n + 1
      setTxtProgressBar(txt, n)
    },
    term = function() close(txt)
  )
}

# Tk progress
progress_tk <- function(title = "plyr progress", label = "Working...", ...) {
  stopifnot(require("tcltk", quiet=TRUE))
  n <- 0
  tk <- NULL
  
  list(
    init = function(x) {
      tk <<- tkProgressBar(max = x, title = title, label = label, ...)
      setTkProgressBar(tk, 0)
    },
    step = function() {
      n <<- n + 1
      setTkProgressBar(tk, n)
    },
    term = function() close(tk)
  )
}

progress_win <- function(title = "plyr progress", ...) {
  n <- 0
  win <- NULL
  
  list(
    init = function(x) {
      win <<- winProgressBar(max = x, title = title, ...)
      setWinProgressBar(win, 0)
    },
    step = function() {
      n <<- n + 1
      setWinProgressBar(win, n)
    },
    term = function() close(win)
  )
}
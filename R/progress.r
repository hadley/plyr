# Create progress bar
# Create progress bar object from text string.
# 
# Progress bars give feedback on how apply step is proceeding.  This
# is mainly useful for long running functions, as for short functions, the 
# time taken up by splitting and combining may be on the same order (or 
# longer) as the apply step.  Additionally, for short functions, the time
# needed to update the progress bar can significantly slow down the process.
# For the trivial examples below, using the tk progress bar slows things down
# by a factor of a thousand.
# 
# Note the that progress bar is approximate, and if the time taken by
# individual function applications is highly non-uniform it may not be very
# informative of the time left.
# 
# There are currently four types of progress bar:  "none", "text", "tk", and
# "win".  See the individual documentation for more details.  In plyr 
# functions, these can either be specified by name, or you can create the
# progress bar object yourself if you want more control over its apperance.
# See the examples.
# 
# @arguments type of progress bar to create
# @seealso \code{\link{progress_none}}, \code{\link{progress_text}}, \code{\link{progress_tk}}, \code{\link{progress_win}}
# @keyword utilities
#X l_ply(1:1000, identity, .progress = "none")
#X l_ply(1:1000, identity, .progress = "tk")
#X l_ply(1:1000, identity, .progress = "text")
#X l_ply(1:1000, identity, .progress = progress_text(char = "-"))
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
# @keyword internal
#X l_ply(1:100, identity, .progress = "none")
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
#X l_ply(1:1000, identity, .progress = "text")
#X l_ply(1:1000, identity, .progress = progress_text(char = "-"))
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

# Graphical progress bar, powered by Tk
# A graphical progress bar displayed in a Tk window
# 
# This graphical progress will appear in a separate window.
# 
# @arguments window title
# @arguments progress bar label (inside window)
# @arguments other arguments passed on to \code{\link[tcltk]{tkProgressBar}}
# @seealso \code{\link[tcltk]{tkProgressBar}} for the function that powers this progress bar
#X l_ply(1:1000, identity, .progress = "tk")
#X l_ply(1:1000, identity, .progress = progress_tk(width=400))
#X l_ply(1:1000, identity, .progress = progress_tk(label=""))
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

# Graphical progress bar, powered by Windows
# A graphical progress bar displayed in a separate window
# 
# This graphical progress only works on Windows.
# 
# @arguments window title
# @arguments other arguments passed on to \code{\link[utils]{winProgressBar}}
# @seealso \code{\link[utils]{winProgressBar}} for the function that powers this progress bar
#X if(exists("winProgressBar")) {
#X l_ply(1:1000, identity, .progress = "win")
#X l_ply(1:1000, identity, .progress = progress_win(title="Working..."))
#X }
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
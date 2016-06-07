#' Create progress bar.
#'
#' Create progress bar object from text string.
#'
#' Progress bars give feedback on how apply step is proceeding.  This
#' is mainly useful for long running functions, as for short functions, the
#' time taken up by splitting and combining may be on the same order (or
#' longer) as the apply step.  Additionally, for short functions, the time
#' needed to update the progress bar can significantly slow down the process.
#' For the trivial examples below, using the tk progress bar slows things down
#' by a factor of a thousand.
#'
#' Note the that progress bar is approximate, and if the time taken by
#' individual function applications is highly non-uniform it may not be very
#' informative of the time left.
#'
#' There are currently four types of progress bar:  "none", "text", "tk", and
#' "win".  See the individual documentation for more details.  In plyr
#' functions, these can either be specified by name, or you can create the
#' progress bar object yourself if you want more control over its apperance.
#' See the examples.
#'
#' @param name type of progress bar to create
#' @param ... other arguments passed onto progress bar function
#' @seealso \code{\link{progress_none}}, \code{\link{progress_text}}, \code{\link{progress_tk}}, \code{\link{progress_win}}
#' @keywords utilities
#' @export
#' @examples
#' # No progress bar
#' l_ply(1:100, identity, .progress = "none")
#' \dontrun{
#' # Use the Tcl/Tk interface
#' l_ply(1:100, identity, .progress = "tk")
#' }
#' # Text-based progress (|======|)
#' l_ply(1:100, identity, .progress = "text")
#' # Choose a progress character, run a length of time you can see
#' l_ply(1:10000, identity, .progress = progress_text(char = "."))
create_progress_bar <- function(name = "none", ...) {
  if (!is.character(name)) return(name)
  name <- paste("progress", name, sep="_")

  if (!exists(name, mode = "function")) {
    warning("Cannot find progress bar ", name, call. = FALSE)
    progress_none()
  } else {
    match.fun(name)(...)
  }
}

#' Null progress bar
#'
#' A progress bar that does nothing
#'
#' This the default progress bar used by plyr functions.  It's very simple to
#' understand - it does nothing!
#'
#' @keywords internal
#' @family progress bars
#' @export
#' @examples
#' l_ply(1:100, identity, .progress = "none")
progress_none <- function() {
  list(
    init = function(x) NULL,
    step = function()  NULL,
    term = function()  NULL
  )
}

#' Text progress bar.
#'
#' A textual progress bar
#'
#' This progress bar displays a textual progress bar that works on all
#' platforms.  It is a thin wrapper around the built-in
#' \code{\link{setTxtProgressBar}} and can be customised in the same way.
#'
#' @param style style of text bar, see Details section of \code{\link{txtProgressBar}}
#' @param ... other arugments passed on to \code{\link{txtProgressBar}}
#' @family progress bars
#' @export
#' @examples
#' l_ply(1:100, identity, .progress = "text")
#' l_ply(1:100, identity, .progress = progress_text(char = "-"))
progress_text <- function(style = 3, ...) {
  n <- 0
  txt <- NULL

  list(
    init = function(x) {
      txt <<- utils::txtProgressBar(max = x, style = style, ...)
      utils::setTxtProgressBar(txt, 0)
    },
    step = function() {
      n <<- n + 1
      utils::setTxtProgressBar(txt, n)
    },
    term = function() close(txt)
  )
}

#' Graphical progress bar, powered by Tk.
#'
#' A graphical progress bar displayed in a Tk window
#'
#' This graphical progress will appear in a separate window.
#'
#' @param title window title
#' @param label progress bar label (inside window)
#' @param ... other arguments passed on to \code{\link[tcltk]{tkProgressBar}}
#' @seealso \code{\link[tcltk]{tkProgressBar}} for the function that powers this progress bar
#' @family progress bars
#' @export
#' @examples
#' \dontrun{
#' l_ply(1:100, identity, .progress = "tk")
#' l_ply(1:100, identity, .progress = progress_tk(width=400))
#' l_ply(1:100, identity, .progress = progress_tk(label=""))
#' }
progress_tk <- function(title = "plyr progress", label = "Working...", ...) {
  stopifnot(requireNamespace("tcltk", quietly = TRUE))
  n <- 0
  tk <- NULL

  list(
    init = function(x) {
      tk <<- tcltk::tkProgressBar(max = x, title = title, label = label, ...)
      tcltk::setTkProgressBar(tk, 0)
    },
    step = function() {
      n <<- n + 1
      tcltk::setTkProgressBar(tk, n)
    },
    term = function() close(tk)
  )
}

#' Graphical progress bar, powered by Windows.
#'
#' A graphical progress bar displayed in a separate window
#'
#' This graphical progress only works on Windows.
#'
#' @param title window title
#' @param ... other arguments passed on to \code{winProgressBar}
#' @seealso \code{winProgressBar} for the function that powers this progress bar
#' @export
#' @family progress bars
#' @examples
#' if(exists("winProgressBar")) {
#' l_ply(1:100, identity, .progress = "win")
#' l_ply(1:100, identity, .progress = progress_win(title="Working..."))
#' }
progress_win <- function(title = "plyr progress", ...) {
  n <- 0
  win <- NULL

  list(
    init = function(x) {
      win <<- utils::winProgressBar(max = x, title = title, ...) # nolint
      utils::setWinProgressBar(win, 0) # nolint
    },
    step = function() {
      n <<- n + 1
      utils::setWinProgressBar(win, n) # nolint
    },
    term = function() close(win)
  )
}

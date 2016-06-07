#' Text progress bar with time.
#'
#' A textual progress bar that estimates time remaining. It displays the
#' estimated time remaining and, when finished, total duration.
#'
#' @family progress bars
#' @export
#' @examples
#' l_ply(1:100, function(x) Sys.sleep(.01), .progress = "time")
progress_time <- function() {
  n <- 0
  txt <- NULL
  list(
    init = function(x) {
      txt <<- txtTimerBar(x)
      utils::setTxtProgressBar(txt, 0)
    },
    step = function() {
      n <<- n + 1
      utils::setTxtProgressBar(txt, n)
    },
    term = function() close(txt)
  )
}

txtTimerBar <- function(n = 1) {
  # nolint start
  start <- .last_update_time <- proc.time()[3]
  times <- numeric(n)
  # nolint end
  value <- NULL

  killed <- FALSE

  width <- getOption("width") - nchar('||100%  ~ 999.9 h remaining.')

  update <- function(i) {
    if (i == 0) return()

    value <<- i
    times[i] <- proc.time()[3] - start

    avg <- times[i] / i
    time_left <- (n - i) * avg

    nbars <- trunc(i / n * width)

    cat_line("|", str_rep("=", nbars), str_rep(" ", width - nbars), "|",
      format(i / n * 100, width = 3), "% ~", show_time(time_left), " remaining")
  }
  getVal <- function() value
  kill <- function(){
    if (killed) return()
    killed <<- TRUE

    if (value == n) {
      cat_line("|", str_rep("=", width), "|100%")
      cat("Completed after", show_time(proc.time()[3] - start), "\n")
    } else {
      cat("Killed after", show_time(proc.time()[3] - start), "\n")
    }
  }

  cat_line("|", str_rep(" ", width), "|  0%")

  structure(
    list(getVal = getVal, up = update, kill = kill),
    class = "txtProgressBar")
}

show_time <- function(x) {
  if (x < 60) {
    paste(round(x), "s")
  } else if (x < 60 * 60) {
    paste(round(x / 60), "m")
  } else {
    paste(round(x / (60 * 60)), "h")
  }
}

cat_line <- function(...) {
  msg <- paste(..., sep = "", collapse = "")
  gap <- max(c(0, getOption("width") - nchar(msg, "width")))
  cat("\r", msg, rep.int(" ", gap), sep = "")
  utils::flush.console()
}

str_rep <- function(x, i) {
  paste(rep.int(x, i), collapse = "")
}

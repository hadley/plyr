#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .progress name of the progress bar to use, see
#'   \code{\link{create_progress_bar}}
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel
#'   backend provided by foreach
#' @keywords manip
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy
#'   for Data Analysis. Journal of Statistical Software, 40(1), 1-29.
#'   \url{http://www.jstatsoft.org/v40/i01/}.

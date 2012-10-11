#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .inform produce informative error messages?  This is turned off by
#'   by default because it substantially slows processing speed, but is very
#'   useful for debugging
#' @param .progress name of the progress bar to use, see
#'   \code{\link{create_progress_bar}}
#' @keywords manip
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy
#'   for Data Analysis. Journal of Statistical Software, 40(1), 1-29.
#'   \url{http://www.jstatsoft.org/v40/i01/}.

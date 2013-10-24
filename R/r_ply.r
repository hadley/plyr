#' Replicate expression and discard results.
#'
#' Evalulate expression n times then discard results
#'
#' This function runs an expression multiple times, discarding the results.
#' This function is equivalent to \code{\link{replicate}}, but never returns
#' anything
#'
#' @keywords manip
#' @param .n number of times to evaluate the expression
#' @param .expr expression to evaluate
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .print automatically print each result? (default: \code{FALSE})
#' @export
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy for
#'   Data Analysis. Journal of Statistical Software, 40(1), 1-29.
#'   \url{http://www.jstatsoft.org/v40/i01/}.
#' @examples
#' r_ply(10, plot(runif(50)))
#' r_ply(25, hist(runif(1000)))
r_ply <- function(.n, .expr, .progress = "none", .print = FALSE) {
  .rlply_worker(.n, .progress,
                eval.parent(substitute(function() .expr)),
                .discard = TRUE, .print = .print)
  invisible(NULL)
}

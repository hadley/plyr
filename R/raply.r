#' Replicate expression and return results in a array.
#'
#' Evalulate expression n times then combine results into an array
#'
#' This function runs an expression multiple times, and combines the
#' result into a data frame.  If there are no results, then this function
#' returns a vector of length 0 (\code{vector(0)}).
#' This function is equivalent to \code{\link{replicate}}, but will always
#' return results as a vector, matrix or array.
#'
#' @keywords manip
#' @param .n number of times to evaluate the expression
#' @param .expr expression to evaluate
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @return if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#' @param .drop should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
#' @export
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy for
#'   Data Analysis. Journal of Statistical Software, 40(1), 1-29.
#'   \url{http://www.jstatsoft.org/v40/i01/}.
#' @examples
#' raply(100, mean(runif(100)))
#' raply(100, each(mean, var)(runif(100)))
#'
#' raply(10, runif(4))
#' raply(10, matrix(runif(4), nrow=2))
#'
#' # See the central limit theorem in action
#' hist(raply(1000, mean(rexp(10))))
#' hist(raply(1000, mean(rexp(100))))
#' hist(raply(1000, mean(rexp(1000))))
raply <- function(.n, .expr, .progress = "none", .drop = TRUE) {
  res <- .rlply_worker(.n, .progress,
                       eval.parent(substitute(function() .expr)))
  list_to_array(res, NULL, .drop)
}

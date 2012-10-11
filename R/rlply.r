#' Replicate expression and return results in a list.
#'
#' Evalulate expression n times then combine results into a list
#'
#' This function runs an expression multiple times, and combines the
#' result into a list.  If there are no results, then this function will return
#' a list of length 0  (\code{list()}). This function is equivalent to
#' \code{\link{replicate}}, but will always return results as a list.
#'
#'
#' @keywords manip
#' @param .n number of times to evaluate the expression
#' @param .expr expression to evaluate
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @return list of results
#' @export
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy for
#'   Data Analysis. Journal of Statistical Software, 40(1), 1-29.
#'   \url{http://www.jstatsoft.org/v40/i01/}.
#' @examples
#' mods <- rlply(100, lm(y ~ x, data=data.frame(x=rnorm(100), y=rnorm(100))))
#' hist(laply(mods, function(x) summary(x)$r.squared))
rlply <- function(.n, .expr, .progress = "none") {
  if (is.function(.expr)) {
    f <- .expr
  } else {
    f <- eval.parent(substitute(function() .expr))
  }

  progress <- create_progress_bar(.progress)
  result <- vector("list", length = .n)

  progress$init(.n)
  on.exit(progress$term())

  for(i in seq_len(.n)) {
    result[i] <- list(f())
    progress$step()
  }

  result
}

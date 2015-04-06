#' Replicate expression and return results in a data frame.
#'
#' Evaluate expression n times then combine results into a data frame
#'
#' This function runs an expression multiple times, and combines the result into
#' a data frame.  If there are no results, then this function returns a data
#' frame with zero rows and columns (\code{data.frame()}). This function is
#' equivalent to \code{\link{replicate}}, but will always return results as a
#' data frame.
#'
#'
#' @keywords manip
#' @param .n number of times to evaluate the expression
#' @param .expr expression to evaluate
#' @param .progress name of the progress bar to use, see
#'   \code{\link{create_progress_bar}}
#' @param .id name of the index column. Pass \code{NULL} to avoid creation of
#'   the index column. For compatibility, omit this argument or pass \code{NA}
#'   to use \code{".n"} as column name.
#' @return a data frame
#' @export
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy for Data
#'   Analysis. Journal of Statistical Software, 40(1), 1-29.
#'   \url{http://www.jstatsoft.org/v40/i01/}.
#' @examples
#' rdply(20, mean(runif(100)))
#' rdply(20, each(mean, var)(runif(100)))
#' rdply(20, data.frame(x = runif(2)))
rdply <- function(.n, .expr, .progress = "none", .id = NA) {
  res <- .rlply_worker(.n, .progress,
                       eval.parent(substitute(function() .expr)))
  names(res) <- seq_len(.n)
  if (is.null(.id)) {
      labels <- NULL
  } else {
    labels <- data.frame(.n = seq_len(.n))
    if (!is.na(.id)) {
      names(labels) <- .id
    }
  }
  list_to_dataframe(res, labels)
}

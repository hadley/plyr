#' Call function with arguments in array or data frame, returning a data frame.
#'
#' Call a multi-argument function with values taken from columns of an data frame or array, and combine results into a data frame
#' 
#' The \code{m*ply} functions are the \code{plyr} version of \code{mapply},
#' specialised according to the type of output they produce.  These functions
#' are just a convenient wrapper around \code{a*ply} with \code{margins = 1}
#' and \code{.fun} wrapped in \code{\link{splat}}.
#' 
#' This function combines the result into a data frame.  If there are no
#' results, then this function will return a data frame with zero rows and
#' columns (\code{data.frame()}).
#' 
#' 
#' @keywords manip
#' @param .data matrix or data frame to use as source of arguments
#' @param .fun function to be called with varying arguments
#' @param ... other arguments passed on to \code{.fun}
#' @param .expand should output be 1d (expand = FALSE), with an element for
#'   each row; or nd (expand = TRUE), with a dimension for each variable.
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel 
#'   backend provided by foreach
#' @return a data frame
#' @export
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy for
#'   Data Analysis. Journal of Statistical Software, 40(1), 1-29. 
#'   \url{http://www.jstatsoft.org/v40/i01/}.
#' @examples
#' mdply(data.frame(mean = 1:5, sd = 1:5), rnorm, n = 2)
#' mdply(expand.grid(mean = 1:5, sd = 1:5), rnorm, n = 2)
#' mdply(cbind(mean = 1:5, sd = 1:5), rnorm, n = 5)
#' mdply(cbind(mean = 1:5, sd = 1:5), as.data.frame(rnorm), n = 5)
mdply <- function(.data, .fun = NULL, ..., .expand = TRUE, .progress = "none", .parallel = FALSE) {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  adply(.data = .data, .margins = 1, .fun = f, ..., 
    .expand = .expand, .progress = .progress, .parallel = .parallel)
}

#' Call function with arguments in array or data frame, returning an array.
#'
#' Call a multi-argument function with values taken from columns of an data frame or array, and combine results into an array
#' 
#' The \code{m*ply} functions are the \code{plyr} version of \code{mapply},
#' specialised according to the type of output they produce.  These functions
#' are just a convenient wrapper around \code{a*ply} with \code{margins = 1}
#' and \code{.fun} wrapped in \code{\link{splat}}.
#' 
#' This function combines the result into an array.  If there are no results,
#' then this function will return a vector of length 0 (\code{vector()}).
#' 
#' 
#' @keywords manip
#' @param .data matrix or data frame to use as source of arguments
#' @param .fun function to be called with varying arguments
#' @param ... other arguments passed on to \code{.fun}
#' @param .expand should output be 1d (expand = FALSE), with an element for
#'   each row; or nd (expand = TRUE), with a dimension for each variable.
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel 
#'   backend provided by foreach
#' @return if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#' @export
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy for
#'   Data Analysis. Journal of Statistical Software, 40(1), 1-29. 
#'   \url{http://www.jstatsoft.org/v40/i01/}.
#' @examples
#' maply(cbind(mean = 1:5, sd = 1:5), rnorm, n = 5)
#' maply(expand.grid(mean = 1:5, sd = 1:5), rnorm, n = 5)
#' maply(cbind(1:5, 1:5), rnorm, n = 5)
maply <- function(.data, .fun = NULL, ..., .expand = TRUE, .progress = "none", .parallel = FALSE) {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)
  
  f <- splat(.fun)
  aaply(.data = .data, .margins = 1, .fun = f, ..., 
    .expand = .expand, .progress = .progress, .parallel = .parallel)
}

#' Call function with arguments in array or data frame, returning a list.
#'
#' Call a multi-argument function with values taken from columns of an data frame or array, and combine results into a list
#' 
#' The \code{m*ply} functions are the \code{plyr} version of \code{mapply},
#' specialised according to the type of output they produce.  These functions
#' are just a convenient wrapper around \code{a*ply} with \code{margins = 1}
#' and \code{.fun} wrapped in \code{\link{splat}}.
#' 
#' This function combines the result into a list.  If there are no results,
#' then this function will return a list of length 0  (\code{list()}).
#' 
#' 
#' @keywords manip
#' @param .data matrix or data frame to use as source of arguments
#' @param .fun function to be called with varying arguments
#' @param ... other arguments passed on to \code{.fun}
#' @param .expand should output be 1d (expand = FALSE), with an element for
#'   each row; or nd (expand = TRUE), with a dimension for each variable.
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel 
#'   backend provided by foreach
#' @return list of results
#' @export
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy for
#'   Data Analysis. Journal of Statistical Software, 40(1), 1-29. 
#'   \url{http://www.jstatsoft.org/v40/i01/}.
#' @examples
#' mlply(cbind(1:4, 4:1), rep)
#' mlply(cbind(1:4, times = 4:1), rep)
#' 
#' mlply(cbind(1:4, 4:1), seq)
#' mlply(cbind(1:4, length = 4:1), seq)
#' mlply(cbind(1:4, by = 4:1), seq, to = 20)
mlply <- function(.data, .fun = NULL, ..., .expand = TRUE, .progress = "none", .parallel = FALSE) {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  alply(.data = .data, .margins = 1, .fun = f, ..., 
    .expand = .expand, .progress = .progress, .parallel = .parallel)
}

#' Call function with arguments in array or data frame, discarding results.
#'
#' Call a multi-argument function with values taken from columns of an data frame or array, and discard results
#' 
#' The \code{m*ply} functions are the \code{plyr} version of \code{mapply},
#' specialised according to the type of output they produce.  These functions
#' are just a convenient wrapper around \code{a*ply} with \code{margins = 1}
#' and \code{.fun} wrapped in \code{\link{splat}}.
#' 
#' This function combines the result into a list.  If there are no results,
#' then this function will return a list of length 0  (\code{list()}).
#' 
#' @keywords manip
#' @param .data matrix or data frame to use as source of arguments
#' @param .fun function to be called with varying arguments
#' @param ... other arguments passed on to \code{.fun}
#' @param .expand should output be 1d (expand = FALSE), with an element for
#'   each row; or nd (expand = TRUE), with a dimension for each variable.
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @export
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy for
#'   Data Analysis. Journal of Statistical Software, 40(1), 1-29. 
#'   \url{http://www.jstatsoft.org/v40/i01/}.
m_ply <- function(.data, .fun = NULL, ..., .expand = TRUE, .progress = "none") {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  a_ply(.data = .data, .margins = 1, .fun = f, ..., 
    .expand = .expand, .progress = .progress)
}

.matrix_to_df <- function(.data) {
  cnames <- colnames(.data)
  if (is.null(cnames)) cnames <- rep("", ncol(.data))
  .data <- as.data.frame(.data, stringsAsFactors = FALSE)
  colnames(.data) <- cnames
  .data  
}

# Call function with arguments in array or data frame, returning a data frame
# Call a multi-argument function with values taken from columns of an data frame or array, and combine results into a data frame
# 
# The \code{m*ply} functions are the \code{plyr} version of \code{mapply},
# specialised according to the type of output they produce.  These functions
# are just a convenient wrapper around \code{a*ply} with \code{margins = 1}
# and \code{.fun} wrapped in \code{\link{splat}}.
# 
# This function combines the result into a data frame.  If there are no
# results, then this function will return a data frame with zero rows and
# columns (\code{data.frame()}).
# 
# 
# @keyword manip
# @arguments matrix or data frame to use as source of arguments
# @arguments function to be called with varying arguments
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value a data frame
#X mdply(data.frame(mean = 1:5, sd = 1:5), rnorm, n = 2)
#X mdply(expand.grid(mean = 1:5, sd = 1:5), rnorm, n = 2)
#X mdply(cbind(mean = 1:5, sd = 1:5), rnorm, n = 5)
mdply <- function(.data, .fun = NULL, ..., .progress = "none") {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  adply(.data = .data, .margins = 1, .fun = f, ..., .progress = .progress)
}

# Call function with arguments in array or data frame, returning an array
# Call a multi-argument function with values taken from columns of an data frame or array, and combine results into an array
# 
# The \code{m*ply} functions are the \code{plyr} version of \code{mapply},
# specialised according to the type of output they produce.  These functions
# are just a convenient wrapper around \code{a*ply} with \code{margins = 1}
# and \code{.fun} wrapped in \code{\link{splat}}.
# 
# This function combines the result into an array.  If there are no results,
# then this function will return a vector of length 0 (\code{vector()}).
# 
# 
# @keyword manip
# @arguments matrix or data frame to use as source of arguments
# @arguments function to be called with varying arguments
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#X maply(cbind(mean = 1:5, sd = 1:5), rnorm, n = 5)
#X maply(cbind(1:5, 1:5), rnorm, n = 5)
#X maply(expand.grid(mean = 1:5, sd = 1:5), rnorm, n = 5)
maply <- function(.data, .fun = NULL, ..., .progress = "none") {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)
  
  f <- splat(.fun)
  aaply(.data = .data, .margins = 1, .fun = f, ..., .progress = .progress)
}

# Call function with arguments in array or data frame, returning a list
# Call a multi-argument function with values taken from columns of an data frame or array, and combine results into a list
# 
# The \code{m*ply} functions are the \code{plyr} version of \code{mapply},
# specialised according to the type of output they produce.  These functions
# are just a convenient wrapper around \code{a*ply} with \code{margins = 1}
# and \code{.fun} wrapped in \code{\link{splat}}.
# 
# This function combines the result into a list.  If there are no results,
# then this function will return a list of length 0  (\code{list()}).
# 
# 
# @keyword manip
# @arguments matrix or data frame to use as source of arguments
# @arguments function to be called with varying arguments
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value list of results
#X mlply(cbind(1:4, 4:1), rep)
#X mlply(cbind(1:4, times = 4:1), rep)
#X 
#X mlply(cbind(1:4, 4:1), seq)
#X mlply(cbind(1:4, length = 4:1), seq)
#X mlply(cbind(1:4, by = 4:1), seq, to = 20)
mlply <- function(.data, .fun = NULL, ..., .progress = "none") {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  alply(.data = .data, .margins = 1, .fun = f, ..., .progress = .progress)
}

# Call function with arguments in array or data frame, discarding results
# Call a multi-argument function with values taken from columns of an data frame or array, and discard results
# 
# The \code{m*ply} functions are the \code{plyr} version of \code{mapply},
# specialised according to the type of output they produce.  These functions
# are just a convenient wrapper around \code{a*ply} with \code{margins = 1}
# and \code{.fun} wrapped in \code{\link{splat}}.
# 
# This function combines the result into a list.  If there are no results,
# then this function will return a list of length 0  (\code{list()}).
# 
# 
# @keyword manip
# @arguments matrix or data frame to use as source of arguments
# @arguments function to be called with varying arguments
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
m_ply <- function(.data, .fun = NULL, ..., .progress = "none") {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  a_ply(.data = .data, .margins = 1, .fun = f, ..., .progress = .progress)
}

.matrix_to_df <- function(.data) {
  cnames <- colnames(.data)
  if (is.null(cnames)) cnames <- rep("", ncol(.data))
  .data <- as.data.frame(.data, stringsAsFactors = FALSE)
  colnames(.data) <- cnames
  .data  
}

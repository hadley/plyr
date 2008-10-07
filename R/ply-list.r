# Split list, apply function, and return results in a list
# For each element of a list, apply function then combine results into a list
# 
# All plyr functions use the same split-apply-combine strategy: they split the
# input into simpler pieces, apply \code{.fun} to each piece, and then combine
# the pieces into a single data structure.  This function splits lists by
# elements and combines the result into a list.  If there are no results, then
# this function will return a list of length 0  (\code{list()}).
# 
# \code{llply} is equivalent to \code{\link{lapply}} except that it will 
# preserve labels and can display a progress bar.
# 
# See \code{vignette("intro", "plyr")} for more details, description and case
# studies.
# 
# @keyword manip
# @arguments list to be processed
# @arguments function to apply to each piece
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value list of results
# 
#X llply(llply(mtcars, round), table)
#X llply(baseball, summary)
#X # Examples from ?lapply
#X x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
#X
#X llply(x, mean)
#X llply(x, quantile, probs = 1:3/4)
llply <- function(.data, .fun = NULL, ..., .progress = "none") {
  if (!is(.data, "split")) .data <- as.list(.data)
  if (is.null(.fun)) return(.data)
  if (length(.data) == 0) return(list())
  
  if (is.character(.fun)) .fun <- match.fun(.fun)
  if (!is.function(.fun)) stop(".fun is not a function.")
  
  progress <- create_progress_bar(.progress)
  
  progress$init(length(.data))

  f2 <- function(...) {
    res <- .fun(...)
    progress$step()
    res
  }
  
  result <- lapply(.data, f2, ...)
  mostattributes(result) <- attributes(.data)
  progress$term()
  
  result
}

# Split data frame, apply function, and return results in a list
# For each subset of a data frame, apply function then combine results into a  list
# 
# All plyr functions use the same split-apply-combine strategy: they split the
# input into simpler pieces, apply \code{.fun} to each piece, and then combine
# the pieces into a single data structure.  This function splits data frames
# by variables and combines the result into a list.  If there are no results,
# then this function will return a list of length 0  (\code{list()}).
# 
# \code{dlply} is similar to \code{\link{by}} except that the results are 
# returned in a different format.
# 
# See \code{vignette("intro", "plyr")} for more details, description and case
# studies.
# 
# @keyword manip
# @arguments data frame to be processed
# @arguments variables to split data frame by, as quoted variables, a formula or character vector
# @arguments function to apply to each piece
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
# @value list of results
#X linmod <- function(df) lm(rbi ~ year, data = transform(df, year = year - min(year)))
#X models <- dlply(baseball, .(id), linmod)
#X models[[1]]
#X
#X coef <- ldply(models, coef)
#X with(coef, plot(`(Intercept)`, year))
#X qual <- laply(models, function(mod) summary(mod)$r.squared)
#X hist(qual)
dlply <- function(.data, .variables, .fun = NULL, ..., .progress = "none") {
  .data <- as.data.frame(.data)
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables)
  
  llply(.data = pieces, .fun = .fun, ..., .progress = .progress)
}

# Split array, apply function, and return results in a list
# For each slice of an array, apply function then combine results into a list
# 
# All plyr functions use the same split-apply-combine strategy: they split the
# input into simpler pieces, apply \code{.fun} to each piece, and then combine
# the pieces into a single data structure.  This function splits matrices,
# arrays and data frames by dimensions and combines the result into a list. 
# If there are no results, then this function will return a list of length 0 
# (\code{list()}).
# 
# \code{alply} is somewhat similar to \code{\link{apply}} for cases where the
# results are not atomic.
# 
# See \code{vignette("intro", "plyr")} for more details, description and case
# studies.
# 
# @keyword manip
# @arguments matrix, array or data frame to be processed
# @arguments a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions
# @arguments function to apply to each piece
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value list of results
# 
#X alply(ozone, 3, quantile)
#X alply(ozone, 3, function(x) table(round(x)))
alply <- function(.data, .margins, .fun = NULL, ..., .progress = "none") {
  pieces <- splitter_a(.data, .margins)
  
  llply(.data = pieces, .fun = .fun, ..., .progress = .progress)
}

# Split list, apply function, and return results in a data frame
# For each element of a list, apply function then combine results into a data  frame
# 
# All plyr functions use the same split-apply-combine strategy: they split the
# input into simpler pieces, apply \code{.fun} to each piece, and then combine
# the pieces into a single data structure.  This function splits lists by
# elements and combines the result into a data frame.  If there are no
# results, then this function will return a data frame with zero rows and
# columns (\code{data.frame()}).
# 
# The most unambiguous behaviour is achieved when \code{.fun} returns a 
# data frame - in that case pieces will be combined with
# \code{\link{rbind.fill}}.  If \code{.fun} returns an atomic vector of fixed
# length, it will be \code{rbind}ed together and converted to a data frame.
# Any other values will result in an error.
# 
# 
# @keyword manip
# @arguments list to be processed
# @arguments function to apply to each piece
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value a data frame
ldply <- function(.data, .fun = NULL, ..., .progress = "none") {
  if (!inherits(.data, "split")) .data <- as.list(.data)
  res <- llply(.data = .data, .fun = .fun, ..., .progress = .progress)

  
  list_to_dataframe(res, attr(.data, "split_labels"))
}

# Split data frame, apply function, and return results in a data frame
# For each subset of a data frame, apply function then combine results into a  data frame
# 
# All plyr functions use the same split-apply-combine strategy: they split the
# input into simpler pieces, apply \code{.fun} to each piece, and then combine
# the pieces into a single data structure.  This function splits data frames
# by variables and combines the result into a data frame.  If there are no 
# results, then this function will return a data frame with zero rows and
# columns (\code{data.frame()}).
# 
# The most unambiguous behaviour is achieved when \code{.fun} returns a 
# data frame - in that case pieces will be combined with
# \code{\link{rbind.fill}}.  If \code{.fun} returns an atomic vector of fixed
# length, it will be \code{rbind}ed together and converted to a data frame.
# Any other values will result in an error.
# 
# 
# @keyword manip
# @arguments data frame to be processed
# @arguments variables to split data frame by, as quoted variables, a formula or character vector
# @arguments function to apply to each piece
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value a data frame
#X mean_rbi <- function(df) mean(df$rbi, na.rm=TRUE)
#X rbi <- ddply(baseball, .(year), mean_rbi)
#X with(rbi, plot(year, V1, type="l"))
#X 
#X mean_rbi <- function(rbi, ...) mean(rbi, na.rm=TRUE)
#X rbi <- ddply(baseball, .(year), splat(mean_rbi))
#X
#X ddply(baseball, .(year), numcolwise(mean), na.rm=TRUE)
#X base2 <- ddply(baseball, .(id), function(df) {
#X  transform(df, career_year = year - min(year) + 1)
#X })
ddply <- function(.data, .variables, .fun = NULL, ..., .progress = "none", .drop = TRUE) {
  .data <- as.data.frame(.data)
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables, drop = .drop)
  
  ldply(.data = pieces, .fun = .fun, ..., .progress = .progress)
}

# Split array, apply function, and return results in a data frame
# For each slice of an array, apply function then combine results into a data frame
# 
# All plyr functions use the same split-apply-combine strategy: they split the
# input into simpler pieces, apply \code{.fun} to each piece, and then combine
# the pieces into a single data structure. This function splits matrices,
# arrays and data frames by dimensions and combines the result into a data
# frame. If there are no results, then this function will return a data frame
# with zero rows and columns (\code{data.frame()}).
# 
# 
# @keyword manip
# @arguments matrix, array or data frame to be processed
# @arguments a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions
# @arguments function to apply to each piece
# @arguments other arguments passed on to \code{.fun}
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value a data frame
adply <- function(.data, .margins, .fun = NULL, ..., .progress = "none") {
  pieces <- splitter_a(.data, .margins)
  
  ldply(.data = pieces, .fun = .fun, ..., .progress = .progress)
}
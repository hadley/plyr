# Combine objects by row, filling in missing columns
# \code{rbind}s a list of data frames filling missing columns with NA 
# 
# This is a minor enhancement to \code{\link{rbind}} which adds in columns
# that are not present in all inputs.
# 
# @arguments data frames to row bind together
# @keyword manip
#X rbind.fill(mtcars[c("mpg", "wt")], mtcars[c("wt", "cyl")])
rbind.fill <- function(...) {
  dfs <- list(...)
  if (length(dfs) == 0) return(list())

  all.names <- unique(unlist(lapply(dfs, names)))
  do.call("rbind", compact(lapply(dfs, function(df) {
    if (length(df) == 0 || nrow(df) == 0) return(NULL)
    
    missing..variables <- setdiff(all.names, names(df))
    if (length(missing..variables) > 0) df[, missing..variables] <- NA
    df
  })))
}


# Compact list
# Remove all NULL entries from a list
# 
# @arguments list
# @keyword manip 
compact <- function(l) Filter(Negate(is.null), l)

# Combine objects by row, filling in missing columns
# \code{rbind}s a list of data frames filling missing columns with NA 
# 
# This is a minor enhancement to \code{\link{rbind}} which adds in columns
# that are not present in all inputs.
# 
# @arguments data frames to row bind together
# @keyword manip
#X rbind.fill(mtcars[c("mpg", "wt")], mtcars[c("wt", "cyl")])
#X 
#X bplayer <- split(baseball, baseball$id)
#X system.time(b1 <- do.call("rbind", bplayer))
#X rownames(b1) <- NULL
#X system.time(b2 <- rbind.fill(bplayer))
#X stopifnot(all.equal(b1, b2))
rbind.fill <- function(...) {
  dfs <- list(...)
  if (length(dfs) == 0) return(list())
  if (is.list(dfs[[1]]) && !is.data.frame(dfs[[1]])) {
    dfs <- dfs[[1]]
  }
  
  rows <- unlist(lapply(dfs, nrow))
  n <- sum(rows)
  
  output <- list()
  pos <- matrix(cumsum(rbind(1, rows - 1)), ncol = 2, byrow = T)
  # head(cbind(pos, pos[,2] - pos[,1] + 1, rows))
  
  for(i in rev(seq_along(rows))) {
    rng <- pos[i, 1]:pos[i, 2]
    df <- dfs[[i]]
    
    for(var in names(df)) {
      output[[var]][rng] <- df[[var]]
    }
  }
  
  as.data.frame(output, stringsAsFactors = FALSE)
}

# Compact list
# Remove all NULL entries from a list
# 
# @arguments list
# @keyword manip 
compact <- function(l) Filter(Negate(is.null), l)
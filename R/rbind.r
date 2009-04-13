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
  
  output <- list()

  # Set up factors
  factors <- names(dfs[[1]])[laply(dfs[[1]], is.factor)]
  for(var in factors) {
    all <- llply(dfs, function(df) levels(df[[var]]))
    output[[var]] <- factor(levels = unique(unlist(all)))
  }

  # Compute start and end positions for each matrix
  pos <- matrix(cumsum(rbind(1, rows - 1)), ncol = 2, byrow = T)
  
  # Do in reverse so first step expands to largest size
  for(i in rev(seq_along(rows))) { 
    rng <- pos[i, 1]:pos[i, 2]
    df <- dfs[[i]]
    
    for(var in names(df)) {
      if (length(df[[var]]) > 0) output[[var]][rng] <- df[[var]]
    }
  }

  # Ensure all variables are the same length.  They might not be if the 
  # last data frame does not contain all rows.
  for(var in names(output)) {
    length(output[[var]]) <- sum(rows)
  }
  
  as_df(output)
}

# Compact list
# Remove all NULL entries from a list
# 
# @arguments list
# @keyword manip 
compact <- function(l) Filter(Negate(is.null), l)

# Convert list to data frame
# Works like cbind, but crams everything into a column
# 
# @keyword internal
as_df <- function(output) {
  if (length(output) == 0) return(data.frame())
  # Convert list to data.frame
  #  Complication necessary to support stamp from reshape, which may
  #  have columns containing data frames
  
  df <- data.frame(matrix(ncol = 0, nrow = length(output[[1]])))
  for(var in names(output)) {
    df[var] <- output[var]
  }
  df  
}
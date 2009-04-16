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
#X 
#X a <- data.frame(a = factor(letters[1:3]), b = 1:3, c = date())
#X b <- data.frame(a = factor(letters[3:5]), 
#X    d = as.Date(c("2008-01-01", "2009-01-01", "2010-01-01")))
#X ab1 <- rbind.fill(a, b)[, letters[1:4]]
#X ab2 <- rbind.fill(b, a)[c(4:6, 1:3), letters[1:4]]
#X ab2$a <- factor(ab2$a, levels(ab1$a))
#X rownames(ab2) <- NULL
#X stopifnot(all.equal(ab1, ab2))
rbind.fill <- function(...) {
  dfs <- list(...)
  if (length(dfs) == 0) return(list())
  if (is.list(dfs[[1]]) && !is.data.frame(dfs[[1]])) {
    dfs <- dfs[[1]]
  }
  
  rows <- unlist(lapply(dfs, nrow))
  nrows <- sum(rows)
  
  output <- list()
  seen <- character()

  # Set up factors
  factors <- names(dfs[[1]])[laply(dfs[[1]], is.factor)]
  for(var in factors) {
    all <- llply(dfs, function(df) levels(df[[var]]))
    output[[var]] <- factor(levels = unique(unlist(all)))
    length(output[[var]]) <- nrows
    seen <- c(seen, var)
  }

  # Compute start and end positions for each matrix
  pos <- matrix(cumsum(rbind(1, rows - 1)), ncol = 2, byrow = T)
  
  for(i in seq_along(rows)) { 
    rng <- pos[i, 1]:pos[i, 2]
    df <- dfs[[i]]
    
    for(var in names(df)) {
      if (length(df[[var]]) > 0) {
        if (!var %in% seen) {
          
          output[[var]] <- rep(df[[var]], length.out = nrows)
          output[[var]][] <- NA

          seen <- c(seen, var)
        }

        output[[var]][rng] <- df[[var]]
        
      }
    }
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
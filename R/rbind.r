# Combine objects by row, filling in missing columns
# \code{rbind}s a list of data frames filling missing columns with NA 
# 
# This is a minor enhancement to \code{\link{rbind}} which adds in columns
# that are not present in all inputs.
# 
#' @param ... data frames to row bind together
#' @keywords manip
#' @examples
#' rbind.fill(mtcars[c("mpg", "wt")], mtcars[c("wt", "cyl")])
rbind.fill <- function(...) {
  dfs <- list(...)
  if (length(dfs) == 0) return(list())
  if (is.list(dfs[[1]]) && !is.data.frame(dfs[[1]])) {
    dfs <- dfs[[1]]
  }
  dfs <- compact(dfs)
  
  # About 6 times faster than using nrow
  rows <- unlist(lapply(dfs, .row_names_info, 2L))
  nrows <- sum(rows)
  
  # Build up output template -------------------------------------------------
  vars <- unique(unlist(lapply(dfs, base::names)))   # ~ 125,000/s
  output <- rep(list(rep(NA, nrows)), length(vars))  # ~ 70,000,000/s
  names(output) <- vars
  
  seen <- rep(FALSE, length(output))
  names(seen) <- vars
    
  for(df in dfs) {    
    if (all(seen)) break  # Quit as soon as all done

    matching <- intersect(names(df), vars[!seen])
    for(var in matching) {
      value <- df[[var]]
      if (is.factor(value))
        output[[var]] <- factor(value)
      else {
        class(output[[var]]) <- class(value)
      }
    }
    seen[matching] <- TRUE
  }

  # Set up factors
  factors <- names(output)[unlist(lapply(output, is.factor))]
  for(var in factors) {
    all <- llply(dfs, function(df) levels(df[[var]]))
    levels(output[[var]]) <- unique(unlist(all))
  }
  
  # Compute start and end positions for each data frame
  pos <- matrix(cumsum(rbind(1, rows - 1)), ncol = 2, byrow = T)
  
  for(i in seq_along(rows)) { 
    rng <- pos[i, 1]:pos[i, 2]
    df <- dfs[[i]]
    
    for(var in names(df)) {
      output[[var]][rng] <- df[[var]]
    }
  }  
  
  as_df(output)
}

#' Compact list
#' Remove all NULL entries from a list
#' 
#' @param l list
#' @keywords manip 
compact <- function(l) Filter(Negate(is.null), l)

#' Convert list to data frame
#' Works like cbind, but crams everything into a column
#' 
#' @param output output list to turn into a data frame
#' @keywords internal
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
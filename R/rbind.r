#' Combine objects by row, filling in missing columns.
#' \code{rbind}s a list of data frames filling missing columns with NA.
#' 
#' This is an enhancement to \code{\link{rbind}} which adds in columns
#' that are not present in all inputs, accepts a list of data frames, and 
#' operates substantially faster
#' 
#' @param ... data frames to row bind together
#' @keywords manip
#' @export
#' @examples
#' rbind.fill(mtcars[c("mpg", "wt")], mtcars[c("wt", "cyl")])
rbind.fill <- function(...) {
  dfs <- list(...)
  if (length(dfs) == 0) return(list())
  if (is.list(dfs[[1]]) && !is.data.frame(dfs[[1]])) {
    dfs <- dfs[[1]]
  }
  dfs <- Filter(Negate(empty), dfs)
  
  if (length(dfs) == 1) return(dfs[[1]])
  
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
      if (is.factor(value)) {
        output[[var]] <- factor(output[[var]])
      } else if (is.list(value)) {
        output[[var]] <- vector("list", nrows)
      } else if (is.array(value)) {
      } else {
        class(output[[var]]) <- class(value)
      }
    }
    seen[matching] <- TRUE
  }

  # Set up factors
  factors <- names(output)[unlist(lapply(output, is.factor))]
  for(var in factors) {
    all <- unique(lapply(dfs, function(df) levels(df[[var]])))
    levels(output[[var]]) <- unique(unlist(all))
  }
  
  # Compute start and end positions for each data frame
  pos <- matrix(cumsum(rbind(1, rows - 1)), ncol = 2, byrow = TRUE)
  
  for(i in seq_along(rows)) { 
    rng <- pos[i, 1]:pos[i, 2]
    df <- dfs[[i]]
    
    for(var in names(df)) {
      output[[var]][rng] <- df[[var]]
    }
  }  
  
  quickdf(output)
}
# Split a data frame by variables
# Split a data frame into pieces based on variable contained in that data frame
# 
# This is the workhorse of the \code{d*ply} functions.  Based on the variables
# you supply, it breaks up a single data frame into a list of data frames,
# each containing a single combination from the levels of the specified
# variables.
# 
# This is basically a thin wrapper around \code{\link{split}} which
# evaluates the variables in the context of the data, and includes enough
# information to reconstruct the labelling of the data frame after 
# other operations.
# 
# @seealso \code{\link{.}} for quoting variables, \code{\link{split}}
# @arguments data frame
# @arguments a \link{quoted} list of variables, a formula, or character vector
# @value a list of data.frames, with attributes that record split details
#X splitter_d(mtcars, .(cyl))
#X splitter_d(mtcars, .(vs, am))
#X splitter_d(mtcars, .(am, vs))
#X
#X mtcars$cyl2 <- factor(mtcars$cyl, levels = c(2, 4, 6, 8, 10))
#X splitter_d(mtcars, .(cyl2), drop = TRUE)
#X splitter_d(mtcars, .(cyl2), drop = FALSE)
#X
#X mtcars$cyl3 <- ifelse(mtcars$vs == 1, NA, mtcars$cyl)
#X splitter_d(mtcars, .(cyl3))
#X splitter_d(mtcars, .(cyl3, vs))
#X splitter_d(mtcars, .(cyl3, vs), drop = FALSE)
splitter_d <- function(data, .variables = NULL, drop = TRUE) {
  splits <- eval.quoted(.variables, data, parent.frame())
  
  splitv <- ninteraction(splits, drop = drop)
  split_labels <- split_labels(splits, drop = drop)

  index <- tapply(1:nrow(data), splitv, list)

  if (!drop) {
    # ensure that all values occur in index.
    all <- seq_len(attr(splitv,"n"))
    missing <- setdiff(all, names(index))
 
    index[missing] <- rep(list(integer()), length(missing))
    index <- index[order(as.numeric(names(index)))]
  }
  
  il <- indexed_df(environment(), index)
  
  structure(
    il,
    class = c(class(il), "split", "list"),
    split_type = "data.frame",
    split_labels = split_labels
  )
}

# Generate labels for split data frame
# Create data frame giving labels for split data frame.
# 
# @arguments list of variables to split up by
# @argument whether all possible combinations should be considered, or only those present in the data
# @keyword internal
split_labels <- function(splits, drop) {
  
  if (drop) {
    splitv <- ninteraction(splits, drop = drop)

    # Need levels which occur in data
    representative <- which(!duplicated(splitv))[order(unique(splitv))]
    data.frame(lapply(splits, function(x) x[representative]))    
  } else {
    factors <- llply(splits, addNA, ifany = TRUE)
    # Need all combinations of levels
    factor_levels <- lapply(factors, levels)
    names(factor_levels) <- names(splits)
    rev(expand.grid(rev(factor_levels)))
  }
}

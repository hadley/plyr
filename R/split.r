# Split objects into lists.
# 
# List (l)
#   * recursive? 
#   * way to work like mapply?  (kind of like a data.frame, list of lists of same length)


splitter_d <- function(data, vars = NULL) {
  splits <- evalu(vars, data, parent.frame())

  splitv <- interaction(splits, drop=TRUE)
  
  representative <- which(!duplicated(splitv))[order(unique(splitv))]
  split_labels <- data.frame(lapply(splits, function(x) x[representative]))
  
  structure(
    split(data, splitv),
    class = c("split", "list"),
    split_type = "data.frame",
    split_labels = split_labels
  )
}

splitter_a <- function(data, margins = 1) {
  dimensions <- lapply(dim(data), seq, from=1)
  dimensions[-margins] <- list(TRUE) 
  indices <- expand.grid(dimensions, KEEP.OUT.ATTRS = FALSE)
  names(indices) <- paste("X", 1:ncol(indices), sep="")
  
  pieces <- lapply(1:nrow(indices), 
    function(i) do.call("[",c(list(data), unname(indices[i, ,drop=TRUE]), drop=TRUE))
  )
  dim(pieces) <- dim(data)[margins]
  
  structure(
    pieces,
    class = c("split", "list"),
    split_type = "list",
    split_labels = indices
  )
}


print.split <- function(x, ...) print(unclass(x))

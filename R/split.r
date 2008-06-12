# Split objects into lists.
# 
# The resulting list should contain enough information to be able
# to reconstruct the original, with appropriate labels etc.

# Split a data frame by variables
splitter_d <- function(data, variables. = NULL) {
  splits <- eval.quoted(variables., data, parent.frame())
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

# Split an array by margins.
splitter_a <- function(data, margins. = 1) {
  if (!all(margins. %in% seq_len(dims(data)))) stop("Invalid margin")
  
  dimensions <- lapply(dim(data), seq, from=1)
  dimensions[-margins.] <- list(TRUE) 
  indices <- expand.grid(dimensions, KEEP.OUT.ATTRS = FALSE)
  names(indices) <- paste("X", 1:ncol(indices), sep="")
  
  pieces <- lapply(1:nrow(indices), 
    function(i) do.call("[",c(list(data), unname(indices[i, ,drop=TRUE]), drop=TRUE))
  )
  dim(pieces) <- dim(data)[margins.]
  
  dnames <- dimnames2(data)
  split_labels <- expand.grid(dnames[margins.])
  colnames <- names(dnames)[margins.]
  if (!is.null(colnames)) names(split_labels) <- colnames

  structure(
    pieces,
    class = c("split", "list"),
    split_type = "array",
    split_labels = split_labels
  )
}


# Needs to print out essence of structure
print.split <- function(x, ...) print(unclass(x))

# Subset splits
# Subset splits, ensuring that labels keep matching
"[.split" <- function(x, i, ...) {
  structure(
    NextMethod(),
    class = c("split", "list"),
    split_type = attr(x, "split_type"),
    split_labels = attr(x, "split_labels")[i, , drop = FALSE]
  )
}
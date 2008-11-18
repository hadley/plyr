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
# @parameters data frame
# @parameters a \link{quoted} list of variables, a formula, or character vector
# @value a list of data.frames, with attributes that record split details
#X splitter_d(mtcars, .(cyl))
#X splitter_d(mtcars, .(vs, am))
#X splitter_d(mtcars, .(am, vs))
splitter_d <- function(data, .variables = NULL) {
  splits <- eval.quoted(.variables, data, parent.frame())
  factors <- llply(splits, factor, exclude = NULL)
  splitv <- interaction(factors, drop=TRUE)
  
  representative <- which(!duplicated(splitv))[order(unique(splitv))]
  split_labels <- data.frame(lapply(splits, function(x) x[representative]))
  
  structure(
    split(data, splitv),
    class = c("split", "list"),
    split_type = "data.frame",
    split_labels = split_labels
  )
}

# Split an array by .margins
# Split a 2d or higher data structure into lower-d pieces based
# 
# This is the workhorse of the \code{a*ply} functions.  Given a >1 d 
# data structure (matrix, array, data.frame), it splits it into pieces
# based on the subscripts that you supply.  Each piece is a lower dimensional
# slice.
# 
# The margins are specified in the same way as \code{\link{apply}}, but
# \code{splitter_a} just splits up the data, while \code{apply} also
# applies a function and combines the pieces back together.  This function
# also includes enough information to recreate the split from attributes on
# the list of pieces.
# 
# @params >1d data structure (matrix, data.frame or array)
# @params a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns
# @value a list of lower-d slices, with attributes that record split details
#X splitter_a(mtcars, 1)
#X splitter_a(mtcars, 2)
splitter_a <- function(data, .margins = 1) {
  if (!all(.margins %in% seq_len(dims(data)))) stop("Invalid margin")
  
  dimensions <- lapply(dim(data), seq, from=1)
  dimensions[-.margins] <- list(TRUE) 
  indices <- expand.grid(dimensions, KEEP.OUT.ATTRS = FALSE)
  names(indices) <- paste("X", 1:ncol(indices), sep="")
  
  subs <- if (is.list(data) && !is.array(data) && !is.data.frame(data)) "[[" else "["
  
  pieces <- lapply(1:nrow(indices), 
    function(i) do.call(subs,
      c(list(data), unname(indices[i, ,drop=TRUE]), drop=TRUE)
    )
  )
  dim(pieces) <- dim(data)[.margins]
  
  if (is.data.frame(data) & identical(.margins, 1)) {
    split_labels <- data
  } else {
    dnames <- amv_dimnames(data)
    split_labels <- expand.grid(dnames[.margins], KEEP.OUT.ATTRS = FALSE)
    colnames <- names(dnames)[.margins]
    if (!is.null(colnames)) names(split_labels) <- colnames
  }

  structure(
    pieces,
    class = c("split", "list"),
    split_type = "array",
    split_labels = split_labels
  )
}


# Subset splits
# Subset splits, ensuring that labels keep matching
# 
# @keywords internal
"[.split" <- function(x, i, ...) {
  structure(
    NextMethod(),
    class = c("split", "list"),
    split_type = attr(x, "split_type"),
    split_labels = attr(x, "split_labels")[i, , drop = FALSE]
  )
}

# Convert split list to regular list
# Strip off label related attributed to make a strip list as regular list
# 
# @keyword internal
as.list.split <- function(x, ...) {
  attr(x, "split_type") <- NULL
  attr(x, "split_labels") <- NULL
  class(x) <- setdiff(class(x), "split")
  x
}

# Print split
# Don't print labels, so it appears like a regular list
# 
# @keywords internal
print.split <- function(x, ...) {
  print(as.list(x))
}
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
#X
#X splitter_a(ozone, 2)
#X splitter_a(ozone, 3)
#X splitter_a(ozone, 1:2)
splitter_a <- function(data, .margins = 1) {
  if (!all(.margins %in% seq_len(dims(data)))) stop("Invalid margin")
  
  dimensions <- lapply(amv_dim(data), seq, from=1)
  dimensions[-.margins] <- list(TRUE) 
  indices <- expand.grid(dimensions, KEEP.OUT.ATTRS = FALSE)
  names(indices) <- paste("X", 1:ncol(indices), sep="")
  
  il <- indexed_array(environment(), indices)
  
  if (is.data.frame(data) & identical(.margins, 1)) {
    split_labels <- data
  } else {
    dnames <- amv_dimnames(data)
    split_labels <- expand.grid(dnames[.margins], KEEP.OUT.ATTRS = FALSE)
    colnames <- names(dnames)[.margins]
    if (!is.null(colnames)) names(split_labels) <- colnames
  }

  structure(
    il,
    class = c(class(il), "split", "list"),
    split_type = "array",
    split_labels = split_labels
  )
}

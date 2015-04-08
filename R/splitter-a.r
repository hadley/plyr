#' Split an array by .margins.
#'
#' Split a 2d or higher data structure into lower-d pieces based
#'
#' This is the workhorse of the \code{a*ply} functions.  Given a >1 d
#' data structure (matrix, array, data.frame), it splits it into pieces
#' based on the subscripts that you supply.  Each piece is a lower dimensional
#' slice.
#'
#' The margins are specified in the same way as \code{\link{apply}}, but
#' \code{splitter_a} just splits up the data, while \code{apply} also
#' applies a function and combines the pieces back together.  This function
#' also includes enough information to recreate the split from attributes on
#' the list of pieces.
#'
#' @param data >1d data structure (matrix, data.frame or array)
#' @param .margins a vector giving the subscripts to split up \code{data} by.
#    1 splits up by rows, 2 by columns and c(1,2) by rows and columns
#' @param .expand if splitting a dataframe by row, should output be 1d
#'   (expand = FALSE), with an element for each row; or nd (expand = TRUE),
#'   with a dimension for each variable.
#' @return a list of lower-d slices, with attributes that record split details
#' @family splitter functions
#' @keywords internal
#' @examples
#' plyr:::splitter_a(mtcars, 1)
#' plyr:::splitter_a(mtcars, 2)
#'
#' plyr:::splitter_a(ozone, 2)
#' plyr:::splitter_a(ozone, 3)
#' plyr:::splitter_a(ozone, 1:2)
splitter_a <- function(data, .margins = 1L, .expand = TRUE) {
  .margins <- as.integer(.margins)

  if (length(.margins) == 0) {
    return(list(data))
  }

  if (!all(.margins %in% seq_len(dims(data)))) stop("Invalid margin")

  dimensions <- lapply(amv_dim(data), seq_len)
  dimensions[-.margins] <- list("")
  indices <- expand.grid(dimensions, KEEP.OUT.ATTRS = FALSE,
    stringsAsFactors = FALSE)
  names(indices) <- paste("X", 1:ncol(indices), sep="")

  # Ensure indices are ordered in the way in which they should appear in the
  # output - last margin varies fastest
  ord <- do.call(order, indices[rev(.margins)])
  indices <- unrowname(indices[ord, , drop = FALSE])

  il <- indexed_array(environment(), indices)

  if (is.data.frame(data) && .expand && identical(.margins, 1L)) {
    split_labels <- data
  } else {
    if (is.data.frame(data)) {
      dnames <- list(seq_len(nrow(data)), names(data))
    } else {
      dnames <- amv_dimnames(data)
      dnames <- lapply(
        dnames,
        function(x) {
          if (any(duplicated(x)))
            x <- make.unique(as.character(x))
          factor(x, levels = x)
        }
      )
    }

    raw <- mapply("[", dnames[.margins], indices[.margins], SIMPLIFY = FALSE)
    split_labels <- data.frame(raw, stringsAsFactors = FALSE)

    if (!is.null(names(dnames))) {
      names(split_labels) <- names(dnames)[.margins]
    } else {
      names(split_labels) <- paste("X", seq_along(.margins), sep = "")
    }
  }

  structure(
    il,
    class = c(class(il), "split", "list"),
    split_type = "array",
    split_labels = split_labels
  )
}

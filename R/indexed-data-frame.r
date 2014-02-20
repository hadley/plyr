#' An indexed data frame.
#'
#' Create a indexed list, a space efficient way of indexing into a large data frame
#'
#' @param env environment containing data frame
#' @param index list of indices
#' @param vars a character vector giving the variables used for subsetting
#' @keywords internal
indexed_df <- function(data, index, vars) {

  structure(
    list(data = data, index = index, vars = vars),
    class = c("indexed", "indexed_df")
  )
}

#' @export
"[[.indexed_df" <- function(x, i) {
  out <- extract_rows(x$data, x$index[[i]])
  attr(out, "vars") <- x$vars
  out
}

extract_rows <- function(x, i) {
  if (!is.data.frame(x)) return(x[i, , drop = FALSE])

  n <- ncol(x)

  out <- lapply(seq_len(n), extract_col_rows, df = x, i = i)

  names(out) <- names(x)
  class(out) <- "data.frame"
  attr(out, "row.names") <- c(NA_integer_, -length(out[[1]]))

  out
}
extract_col_rows <- function(df, i, j) {
  col <- .subset2(df, j)
  if (isS4(col)) return(col[i])

  if (is.null(attr(col, "class"))) {
    .subset(col, i)
  } else if (inherits(col, "factor") || inherits(col, "POSIXt")) {
    out <- .subset(col, i)
    attributes(out) <- attributes(col)
    out
  } else {
    col[i]
  }
}

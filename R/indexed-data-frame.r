#' An indexed data frame.
#' Create a indexed list, a space efficient way of indexing into a large data frame
#' 
#' @param env environment containing data frame
#' @param index list of indices
#' @keywords internal
#' @aliases indexed_df length.indexed names.indexed as.list.indexed
#'   [[.indexed_df [.indexed print.indexed
indexed_df <- function(data, index) {
  
  structure(
    list(data = data, index = index),
    class = c("indexed", "indexed_df")
  )
}

"[[.indexed_df" <- function(x, i) {
  x$data[x$index[[i]], , drop = FALSE]
  # x$env$data[x$index[[i]], , drop = FALSE]
  # slice(x, attr(x, "index")[[i]]) 
  # subset_rows(x$env$data, x$index[[i]])
}

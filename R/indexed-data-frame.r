#' An indexed list
#' Create a indexed list, a space efficient way of indexing into a large data frame
#' 
#' @param env environment containing data frame
#' @param index list of indices
#' @keywords internal
#' @aliases indexed_df length.indexed names.indexed as.list.indexed
#'   [[.indexed_df [.indexed print.indexed
indexed_df <- function(env, index) {
  structure(
    list(env = env, index = index),
    class = c("indexed", "indexed_df")
  )
}

"[[.indexed_df" <- function(x, i) {
  x$env$data[x$index[[i]], , drop = FALSE]
}

# An indexed list
# Create a indexed list, a space efficient way of indexing into a large data frame
# 
# @arguments environment containing data frame
# @argument list of indices
# @keyword internal
# @alias length.indexed
# @alias names.indexed
# @alias as.list.indexed
# @alias [[.indexed_df
# @alias [.indexed 
# @alias print.indexed
indexed_df <- function(env, index) {
  structure(
    list(env = env, index = index),
    class = c("indexed", "indexed_df")
  )
}

"[[.indexed_df" <- function(x, i) {
  x$env$data[x$index[[i]], , drop = FALSE]
}

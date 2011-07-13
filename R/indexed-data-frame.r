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

#' @S3method [[ indexed_df
"[[.indexed_df" <- function(x, i) {
  structure(x$data[x$index[[i]], , drop = FALSE], vars = x$vars)
  # x$env$data[x$index[[i]], , drop = FALSE]
  # slice(x, attr(x, "index")[[i]]) 
  # subset_rows(x$env$data, x$index[[i]])
}

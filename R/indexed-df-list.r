#' An list of indexed data frames of common type
#'
#' Create a indexed list, a space efficient way of indexing into a large data frame
#'
#' @param data a list of data frames
#' @param index list of indices, of same length as list of data frames; ith index corresponds to ith data frame
#' @param vars a character vector giving the variables used for subsetting
#' @keywords internal
indexed_df_list <- function(data, index_list, vars, n) {
  ## don't do integrity checks, as internal function
  ## make a list of indexed data frames
  res <- lapply(seq_len(length(data)), function(i, data, index_list, vars) {
    indexed_df(data[[i]], index_list[[i]], vars)},
                data=data, index_list=index_list, vars=vars)
  mostattributes(res) <- attributes(data)

  structure(
    res,
    class = c("indexed_df_list", "indexed"),
    vars = vars,
    n=n
  )
}

#' @S3method [[ indexed_df_list
"[[.indexed_df_list" <- function(x, i) {
  out <- lapply(unclass(x), get("[[.indexed_df"), i=i)
  attr(out, "vars") <- attr(x, "vars")
  out
}

#' @S3method length indexed_df_list
length.indexed_df_list <- function(x) return(attr(x, "n"))


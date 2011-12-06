#' Remove splitting variables from a data frame.
#'
#' This is useful when you want to perform some operation to every column
#' in the data frame, except the variables that you have used to split it.
#' These variables will be automatically added back on to the result when
#' combining all results together.
#'
#' @param df data frame produced by \code{d*ply}.
#' @export
#' @examples
#' dlply(mtcars, c("vs", "am"))
#' dlply(mtcars, c("vs", "am"), strip_splits)
strip_splits <- function(df) {
  df[setdiff(names(df), attr(df, "vars"))]
}

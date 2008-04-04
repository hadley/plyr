uniquecols <- function(df) {
  col_is_unique <- function(x) is.discrete(x) && length(unique(x)) == 1
  df[1, sapply(df, col_is_unique), drop=FALSE]
}

unrowname <- function(x) {
  rownames(x) <- NULL
  x
}

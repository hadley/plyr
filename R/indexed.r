#' @S3method length indexed
length.indexed <- function(x) length(x$index)

#' @S3method names indexed
names.indexed <- function(x) {
  labels <- attr(x, "split_labels")
  labels[] <- lapply(labels, as.character)
  
  do.call(paste, c(labels, list(sep = ".")))
}

#' @S3method as.list indexed
as.list.indexed <- function(x, ...) {
  n <- length(x)
  out <- vector("list", n)
  for(i in seq_len(n)) {
    out[[i]] <- x[[i]]
  }
  names(out) <- names(x)
  class(out) <- c("split", "list")
  out
}

#' @S3method print indexed
print.indexed <- function(x, ...) {
  print(as.list(x))
}

#' @S3method [ indexed
"[.indexed" <- function(x, ...) {
  as.list(x)[...]
}

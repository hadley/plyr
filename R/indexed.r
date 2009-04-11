length.indexed <- function(x) length(x$index)

names.indexed <- function(x) names(x$index)

as.list.indexed <- function(x, ...) {
  n <- length(x)
  out <- vector("list", n)
  for(i in seq_len(n)) {
    out[[i]] <- x[[i]]
  }
  
  class(out) <- c("split", "list")
  out
}

print.indexed <- function(x, ...) {
  print(as.list(x))
}

"[.indexed" <- function(x, ...) {
  as.list(x)[...]
}
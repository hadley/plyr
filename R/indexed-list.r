# An indexed list
# Create a indexed list, a space efficient way of indexing into a large data frame
# 
# @arguments environment containing data frame
# @argument list of indices
# @keywords internal
# @alias length.indexed_list
# @alias names.indexed_list
# @alias as.list.indexed_list
# @alias [[.indexed_list
indexed_list <- function(env, index) {
  structure(
    list(env = env, index = index),
    class = "indexed_list"
  )
}

length.indexed_list <- function(x) length(x$index)

"[[.indexed_list" <- function(x, i) {
  x$env$data[x$index[[i]], ]
}

names.indexed_list <- function(x) names(x$index)

as.list.indexed_list <- function(x, ...) {
  n <- length(x)
  out <- vector("list", n)
  for(i in seq_len(n)) {
    out[[i]] <- x[[i]]
  }
  
  mostattributes(out) <- attributes(x)
  class(out) <- c("split", "list")
  out
}


# index <- tapply(1:nrow(mtcars), mtcars$cyl, c, simplify = FALSE)
# il <- indexed_list(mtcars, index)
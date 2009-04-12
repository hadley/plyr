# An indexed array
# Create a indexed array, a space efficient way of indexing into a large array
# 
# @arguments environment containing data frame
# @argument list of indices
# @keyword internal
# @alias [[.indexed_array
# @alias names.indexed_array
# @alias length.indexed_array
indexed_array <- function(env, index) {
  exact <- all(laply(index, is.numeric))

  # Situations that should use [
  #   * data.frame
  #   * normal array
  #   * normal vector
  #   * list-array with inexact indexing
  # 
  # Situations that should use [[
  #   * list
  #   * list-array with exact indexing
  
  if (is.list(env$data)) {
    if (is.data.frame(env$data) || (is.array(env$data) && !exact)) {
      subs <- c("[", "]")
    } else {
      subs <- c("[[", "]]")    
    }
  } else {
    subs <- c("[", "]")    
  }
  
  structure(
    list(env = env, index = index, subs = subs),
    class = c("indexed_array", "indexed")
  )
}

length.indexed_array <- function(x) nrow(x$index)

"[[.indexed_array" <- function(x, i) {
  indices <- paste(x$index[i, ,drop=TRUE], collapse = ", ")

  ## This is very slow because we have to create a copy to use do.call
  # do.call(x$subs, c(list(x$env$data), indices, drop=TRUE))

  call <- paste("x$env$data", x$subs[1], indices, ", drop = TRUE", x$subs[2], 
    sep = "")
  eval(parse(text = call))
}

names.indexed_array <- function(x) rownames(x$index)

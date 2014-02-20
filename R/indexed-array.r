#' An indexed array.
#'
#' Create a indexed array, a space efficient way of indexing into a large
#' array.
#'
#' @param env environment containing data frame
#' @param index list of indices
#' @keywords internal
#' @aliases indexed_array [[.indexed_array names.indexed_array
#'   length.indexed_array
indexed_array <- function(env, index) {
  exact <- all(unlist(llply(index, is.numeric)))

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
      subs <- "["
    } else {
      subs <- "[["
    }
  } else {
    subs <- "["
  }

  # Don't drop if data is a data frame
  drop <- !is.data.frame(env$data)

  structure(
    list(env = env, index = index, drop = drop, subs = as.name(subs)),
    class = c("indexed_array", "indexed")
  )
}

#' @export
length.indexed_array <- function(x) nrow(x$index)

#' @export
"[[.indexed_array" <- function(x, i) {
  indices <- unname(x$index[i, , drop = TRUE])
  indices <- lapply(indices, function(x) if (x == "") bquote() else x)

  call <- as.call(c(
    list(x$subs, quote(x$env$data)),
    indices,
    list(drop = x$drop)))
  eval(call)
}

#' @export
names.indexed_array <- function(x) rownames(x$index)

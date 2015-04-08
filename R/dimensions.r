#' Number of dimensions.
#'
#' Number of dimensions of an array or vector
#'
#' @param x array
#' @keywords internal
dims <- function(x) length(amv_dim(x))

#' Dimensions.
#'
#' Consistent dimensions for vectors, matrices and arrays.
#'
#' @param x array, matrix or vector
#' @keywords internal
amv_dim <- function(x) if (is.vector(x)) length(x) else dim(x)


#' Dimension names.
#'
#' Consistent dimnames for vectors, matrices and arrays.
#'
#' Unlike \code{\link{dimnames}} no part of the output will ever be
#' null.  If a component of dimnames is omitted, \code{amv_dimnames}
#' will return an integer sequence of the appropriate length.
#'
#' @param x array, matrix or vector
#' @keywords internal
#' @export
amv_dimnames <- function(x) {
  d <- if (is.vector(x)) list(names(x)) else dimnames(x)

  if (is.null(d)) d <- rep(list(NULL), dims(x))
  null_names <- which(unlist(llply(d, is.null)))
  d[null_names] <- llply(null_names, function(i) seq_len(amv_dim(x)[i]))

  # if (is.null(names(d))) names(d) <- paste("X", 1:length(d), sep="")
  d
}

#' Reduce dimensions.
#'
#' Remove extraneous dimensions
#'
#' @param x array
#' @keywords internal
reduce_dim <- function(x) {
  subs <- lapply(dim(x), function(x) if (x == 1) 1 else bquote())
  call <- as.call(c(list(as.name("["), quote(x)), subs, list(drop = TRUE)))
  eval(call)
}

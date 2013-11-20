#' Replace specified values with new values, in a factor or character vector.
#'
#' If \code{x} is a factor, the named levels of the factor will be
#' replaced with the new values.
#'
#' This function works only on character vectors and factors, but the
#' related \code{mapvalues} function works on vectors of any type and factors,
#' and instead of a named vector specifying the original and replacement values,
#' it takes two separate vectors
#'
#' @param x factor or character vector to modify
#' @param replace named character vector, with new values as values, and
#'   old values as names.
#' @param warn_missing print a message if any of the old values are
#'   not actually present in \code{x}
#'
#' @seealso \code{\link{mapvalues}} to replace values with vectors of any type
#' @export
#' @examples
#' x <- c("a", "b", "c")
#' revalue(x, c(a = "A", c = "C"))
#' revalue(x, c("a" = "A", "c" = "C"))
#'
#' y <- factor(c("a", "b", "c", "a"))
#' revalue(y, c(a = "A", c = "C"))
revalue <- function(x, replace = NULL, warn_missing = TRUE) {
  if (!is.null(x) && !is.factor(x) && !is.character(x)) {
    stop("x is not a factor or a character vector.")
  }

  mapvalues(x, from = names(replace), to = replace, warn_missing = warn_missing)
}


#' Replace specified values with new values, in a vector or factor.
#'
#' Item in \code{x} that match items \code{from} will be replaced by
#' items in \code{to}, matched by position. For example, items in \code{x} that
#' match the first element in \code{from} will be replaced by the first
#' element of \code{to}.
#'
#' If \code{x} is a factor, the matching levels of the factor will be
#' replaced with the new values.
#'
#' The related \code{revalue} function works only on character vectors
#' and factors, but this function works on vectors of any type and factors.
#'
#' @param x the factor or vector to modify
#' @param from a vector of the items to replace
#' @param to a vector of replacement values
#' @param warn_missing print a message if any of the old values are
#'   not actually present in \code{x}
#'
#' @seealso \code{\link{revalue}} to do the same thing but with a single
#'   named vector instead of two separate vectors.
#' @export
#' @examples
#' x <- c("a", "b", "c")
#' mapvalues(x, c("a", "c"), c("A", "C"))
#'
#' # Works on factors
#' y <- factor(c("a", "b", "c", "a"))
#' mapvalues(y, c("a", "c"), c("A", "C"))
#'
#' # Works on numeric vectors
#' z <- c(1, 4, 5, 9)
#' mapvalues(z, from = c(1, 5, 9), to = c(10, 50, 90))
mapvalues <- function(x, from, to, warn_missing = TRUE) {
  if (length(from) != length(to)) {
    stop("`from` and `to` vectors are not the same length.")
  }
  if (!is.atomic(x)) {
    stop("`x` must be an atomic vector.")
  }

  if (is.factor(x)) {
    # If x is a factor, call self but operate on the levels
    levels(x) <- mapvalues(levels(x), from, to, warn_missing)
    return(x)
  }

  mapidx <- match(x, from)
  mapidxNA  <- is.na(mapidx)

  # index of items in `from` that were found in `x`
  from_found <- sort(unique(mapidx))
  if (warn_missing && length(from_found) != length(from)) {
    message("The following `from` values were not present in `x`: ",
      paste(from[!(1:length(from) %in% from_found) ], collapse = ", "))
  }

  x[!mapidxNA] <- to[mapidx[!mapidxNA]]
  x
}

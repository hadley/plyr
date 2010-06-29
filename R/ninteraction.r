#' A unique numeric id for each unique row in a data frame.
#'
#' Properties:
#' \itemize{
#'   \item \code{order(id)} is equivalent to \code{do.call(order, df)}
#'   \item rows containing the same data have the same value
#'   \item if \code{drop = FALSE} then room for all possibilites
#' }
#'
#' @param .variables list of variables
#' @param drop drop unusued factor levels?
#' @return a numeric vector with attribute n, giving total number of
#'   possibilities
#' @keywords internal
#' @seealso \code{\link{id_var}}
#' @aliases id ninteraction
#' @export
id <- function(.variables, drop = FALSE) {
  if (length(.variables) == 0) {
    res <- structure(rep.int(1L, nrow(.variables)), n = 1L)
    return(res)
  }

  # Special case for single variable
  if (length(.variables) == 1) {
    return(id_var(.variables[[1]], drop = drop))
  }

  # Calculate individual ids
  ids <- rev(lapply(.variables, id_var, drop = drop))

  # Calculate dimensions
  ndistinct <- unlist(lapply(ids, attr, "n"))
  n <- prod(ndistinct)

  p <- length(ids)
  combs <- c(1, cumprod(ndistinct[-p]))

  mat <- do.call("cbind", ids)
  res <- c((mat - 1L) %*% combs + 1L)
  attr(res, "n") <- n

  # vdf <- data.frame(.variables)
  # names(vdf) <- paste("X", 1:ncol(vdf), sep="")
  # vdf$i <- res
  # browser()

  if (drop) {
    res <- id_var(res, drop = TRUE)
  }

  res
}
ninteraction <- id

#' Numeric id for a vector.
#' @keywords internal
id_var <- function(x, drop = FALSE) {
  if (length(x) == 0) return(x)
  
  if (is.factor(x) && !drop) {
    id <- as.numeric(addNA(x, ifany = TRUE))
    n <- length(levels(x))
  } else {
    levels <- sort(unique(x), na.last = TRUE)
    id <- match(x, levels)
    n <- max(id)
  }
  structure(id, n = n)
}
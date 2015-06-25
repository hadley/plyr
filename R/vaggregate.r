#' Vector aggregate.
#'
#' This function is somewhat similar to \code{tapply}, but is designed for
#' use in conjunction with \code{id}. It is simpler in that it only
#' accepts a single grouping vector (use \code{\link{id}} if you have more)
#' and uses \code{\link{vapply}} internally, using the \code{.default} value
#' as the template.
#'
#' \code{vaggregate} should be faster than \code{tapply} in most situations
#' because it avoids making a copy of the data.
#'
#' @param .value vector of values to aggregate
#' @param .group grouping vector
#' @param .fun aggregation function
#' @param ... other arguments passed on to \code{.fun}
#' @param .default default value used for missing groups.  This argument is
#'   also used as the template for function output.
#' @param .n total number of groups
#' @export
#' @examples
#' # Some examples of use borrowed from ?tapply
#' n <- 17; fac <- factor(rep(1:3, length.out = n), levels = 1:5)
#' table(fac)
#' vaggregate(1:n, fac, sum)
#' vaggregate(1:n, fac, sum, .default = NA_integer_)
#' vaggregate(1:n, fac, range)
#' vaggregate(1:n, fac, range, .default = c(NA, NA) + 0)
#' vaggregate(1:n, fac, quantile)
#' # Unlike tapply, vaggregate does not support multi-d output:
#' tapply(warpbreaks$breaks, warpbreaks[,-1], sum)
#' vaggregate(warpbreaks$breaks, id(warpbreaks[,-1]), sum)
#'
#' # But it is about 10x faster
#' x <- rnorm(1e6)
#' y1 <- sample.int(10, 1e6, replace = TRUE)
#' system.time(tapply(x, y1, mean))
#' system.time(vaggregate(x, y1, mean))
vaggregate <- function(.value, .group, .fun, ..., .default = NULL, .n = nlevels(.group)) {
  if (!is.integer(.group)) {
    if (is.list(.group)) {
      .group <- id(.group)
    } else {
      .group <- id(list(.group))
    }
  }

  if (is.null(.default)) {
    .default <- .fun(.value[0], ...)
  }

  fun <- function(i) {
    if (length(i) == 0) return(.default)
    .fun(.value[i], ...)
  }

  indices <- split_indices(.group, .n)
  vapply(indices, fun, .default)
}

nlevels <- function(x) {
  n <- attr(x, "n")
  if (!is.null(n)) n else max(x)
}

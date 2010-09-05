#' Vector aggregate.
#'
#' This function is somewhat similar to \code{tapply}, but is designed for
#' use in conjunction with \code{id}.
#' 
#' @param .value vector of values to aggregate
#' @param .group grouping vector
#' @param .fun aggregation function
#' @param ... other arguments passed on to \code{.fun}
#' @param .default default value used for missing groups.  This argument is 
#'   also used as the template for function output.
#' @param .n total number of groups
#' @export
vaggregate <- function(.value, .group, .fun, ..., .default = NULL, .n = max(group)) {
  if (is.null(.default)) {
    .default <- .fun(.value[0])
  }
  
  fun <- function(i) {
    if (length(i) == 0) return(.default)
    .fun(.value[i], ...)
  }

  indices <- split_indices(seq_along(.value), .group, .n)
  vapply(indices, fun, .default)
}

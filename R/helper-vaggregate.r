#' Vector aggregate.
#'
#' @param .value vector of values to aggregate
#' @param .group grouping vector
#' @param .fun aggregation function
#' @param ... other arguments passed on to \code{.fun}
#' @param .default default value used for missing groups
#' @param .n total number of groups
#' @export
vaggregate <- function(.value, .group, .fun, ..., .default = NULL, .n = max(group)) {
  if (is.null(.default)) {
    .default <- fun.aggregate(.value[0])
  }
  
  fun <- function(i) {
    if (length(i) == 0) return(.default)
    fun.aggregate(.value[i], ...)
  }

  indices <- split_indices(seq_along(value), overall, .n)
  vapply(indicies, fun , fill)
}

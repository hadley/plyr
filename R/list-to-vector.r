#' List to vector.
#'
#' Reduce/simplify a list of homogenous objects to a vector
#'
#' @param res list of input data
#' @keywords internal
#' @family list simplification functions
list_to_vector <- function(res) {
  n <- length(res)
  if (n == 0) return(vector())
  if (n == 1) return(res[[1]])

  atomic <- sapply(res, is.atomic)
  if (all(atomic)) {
    numeric <- all(unlist(lapply(res, is.numeric)))
    classes <- unique(lapply(res, class))
    if (numeric || length(classes) == 1) {
      res <- unlist(res)
    }
  }

  res
}

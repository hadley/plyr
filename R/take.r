#' Take a subset along an arbitrary dimension
#'
#' @param x matrix or array to subset
#' @param along dimension to subset along
#' @param indices the indices to select
#' @param drop should the dimensions of the array be simplified? Defaults
#'   to \code{FALSE} which is the opposite of the useful R default.
#' @export
#' @keywords manip
#' @examples
#' x <- array(seq_len(3 * 4 * 5), c(3, 4, 5))
#' take(x, 3, 1)
#' take(x, 2, 1)
#' take(x, 1, 1)
#' take(x, 3, 1, drop = TRUE)
#' take(x, 2, 1, drop = TRUE)
#' take(x, 1, 1, drop = TRUE)
take <- function(x, along, indices, drop = FALSE) {
  nd <- length(dim(x))

  index <- as.list(rep(TRUE, nd))
  index[along] <- indices

  eval(as.call(c(as.name("["), as.name("x"), index, drop = drop)))
}

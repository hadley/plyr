#' @section Output: 
#'   The most unambiguous behaviour is achieved when \code{.fun} returns a 
#'   data frame - in that case pieces will be combined with
#'   \code{\link{rbind.fill}}.  If \code{.fun} returns an atomic vector of
#'   fixed length, it will be \code{rbind}ed together and converted to a data
#'   frame. Any other values will result in an error.
#'
#'  If there are no results, then this function will return a data
#'  frame with zero rows and columns (\code{data.frame()}).
#'
#' @return A data frame, as described in the output section.
#' @family data frame output

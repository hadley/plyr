#' @details
#' The \code{m*ply} functions are the \code{plyr} version of \code{mapply},
#' specialised according to the type of output they produce.  These functions
#' are just a convenient wrapper around \code{a*ply} with \code{margins = 1}
#' and \code{.fun} wrapped in \code{\link{splat}}.
#'
#' @family multiple arguments input
#' @section Input: Call a multi-argument function with values taken from
#'   columns of an data frame or array
#'
#' @param .data matrix or data frame to use as source of arguments
#' @param .expand should output be 1d (expand = FALSE), with an element for
#'   each row; or nd (expand = TRUE), with a dimension for each variable.

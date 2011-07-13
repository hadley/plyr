#' @section Input: This function splits matrices, arrays and data frames by
#'   dimensions
#'
#' @param .data matrix, array or data frame to be processed
#' @param .margins a vector giving the subscripts to split up \code{data} by. 
#'   1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so
#'   on for higher dimensions
#' @family array input
#' @param .expand if \code{.data} is a data frame, should output be 1d (expand
#'   = FALSE), with an element for each row; or nd (expand = TRUE), with a
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel 
#'   backend provided by foreach
#'  dimension for each variable.


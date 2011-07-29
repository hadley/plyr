#' @section Input: This function splits data frames by variables.
#'
#' @param .data data frame to be processed
#' @param .variables variables to split data frame by, as quoted
#'   variables, a formula or character vector
#' @param .drop should combinations of variables that do not appear in the 
#'   input data be preserved (FALSE) or dropped (TRUE, default)
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel 
#'   backend provided by foreach
#' @family data frame input

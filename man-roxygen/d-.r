#' @family data frame input
#' @section Input: This function splits data frames by variables.
#'
#' @param .data data frame to be processed
#' @param .variables variables to split data frame by, as \code{\link{as.quoted}}
#'   variables, a formula or character vector
#' @param .drop should combinations of variables that do not appear in the
#'   input data be preserved (FALSE) or dropped (TRUE, default)

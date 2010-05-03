#' Summarise a data frame.
#' Create a new data frame that summarises an existing data frame.
#' 
#' Summarise works in an analagous way to transform, except instead of adding
#' columns to an existing data frame, it creates a new one.  This is
#' particularly useful in conjunction with \code{\link{ddply}} as it makes it
#' easy to perform group-wise summaries.
#' 
#' @param .data the data frame to be summarised
#' @param ... further arguments of the form var = value
#' @keywords manip
#' @aliases summarise summarize
#' @export summarise summarize
#' @examples
#' summarise(baseball, 
#'  duration = max(year) - min(year), 
#'  nteams = length(unique(team)))
#' ddply(baseball, "id", summarise, 
#'  duration = max(year) - min(year), 
#'  nteams = length(unique(team)))
summarise <- function(.data, ...) {
  quickdf(eval(substitute(list(...)), .data, parent.frame()))
}
summarize <- summarise

#' Order a data frame by its colums.
#'
#' This function completes triad subsetting, transforming and ordering triad
#' with a function that works in a similar way to \code{\link{subset}} and 
#' \code{\link{transform}} but for reordering a data frame by its columns.
#' This saves a lot of typing!
#'
#' @param df data frame to reorder
#' @param ... expressions evaluated in the context of \code{df} and then fed
#'   to \code{\link{order}}
#' @keywords manip
#' @examples
#' mtcars[with(mtcars, order(cyl, disp)), ]
#' arrange(mtcars, cyl, disp)
arrange <- function(df, ...) {
  ord <- eval(substitute(order(...)), df, parent.frame())
  df[ord, ]
}
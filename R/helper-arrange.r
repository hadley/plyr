#' Order a data frame by its colums.
#'
#' This function completes the subsetting, transforming and ordering triad
#' with a function that works in a similar way to \code{\link{subset}} and 
#' \code{\link{transform}} but for reordering a data frame by its columns.
#' This saves a lot of typing!
#'
#' @param df data frame to reorder
#' @param ... expressions evaluated in the context of \code{df} and then fed
#'   to \code{\link{order}}
#' @keywords manip
#' @export
#' @examples
#' mtcars[with(mtcars, order(cyl, disp)), ]
#' arrange(mtcars, cyl, disp)
#' arrange(mtcars, cyl, desc(disp))
arrange <- function(df, ...) {
  ord <- eval(substitute(order(...)), df, parent.frame())
  unrowname(df[ord, ])
}

#' Descending order.
#'
#' Transform a vector into a format that will be sorted in descending order.
#'
#' @param x vector to transform
#' @keywords manip
#' @export
#' @examples
#' desc(1:10)
#' desc(factor(letters))
#' first_day <- seq(as.Date("1910/1/1"), as.Date("1920/1/1"), "years")
#' desc(first_day)
desc <- function(x) -xtfrm(x)
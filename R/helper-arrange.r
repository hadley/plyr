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
#' @seealso \code{\link{order}} for sorting function in the base package
#' @export
#' @examples
#' # sort mtcars data by cylinder and displacement
#' mtcars[with(mtcars, order(cyl, disp)), ]
#' # Same result using arrange: no need to use with(), as the context is implicit
#' # NOTE: plyr functions do NOT preserve row.names
#' arrange(mtcars, cyl, disp)
#' # Let's keep the row.names in this example
#' myCars = cbind(vehicle=row.names(mtcars), mtcars)
#' arrange(myCars, cyl, disp)
#' # Sort with displacement in descending order
#' arrange(myCars, cyl, desc(disp))
arrange <- function(df, ...) {
  stopifnot(is.data.frame(df))

  ord <- eval(substitute(order(...)), df, parent.frame())
  if(length(ord) != nrow(df)) {
    stop("Length of ordering vectors don't match data frame size",
      call. = FALSE)
  }
  unrowname(df[ord, , drop = FALSE])
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

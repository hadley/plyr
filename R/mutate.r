#' Mutate a data frame by adding new or replacing existing columns.
#'
#' This function is very similar to \code{\link{transform}} but it executes
#' the transformations iteratively so that later transformations can use the
#' columns created by earlier transformations.  Like transform, unnamed
#' components are silently dropped.
#'
#' Mutate seems to be considerably faster than transform for large data
#' frames.
#'
#' @param .data the data frame to transform
#' @param ... named parameters giving definitions of new columns.
#' @seealso \code{\link{subset}}, \code{\link{summarise}},
#'   \code{\link{arrange}}.  For another somewhat different approach to
#'   solving the same problem, see \code{\link{within}}.
#' @export
#' @examples
#' # Examples from transform
#' mutate(airquality, Ozone = -Ozone)
#' mutate(airquality, new = -Ozone, Temp = (Temp - 32) / 1.8)
#'
#' # Things transform can't do
#' mutate(airquality, Temp = (Temp - 32) / 1.8, OzT = Ozone / Temp)
#'
#' # mutate is rather faster than transform
#' system.time(transform(baseball, avg_ab = ab / g))
#' system.time(mutate(baseball, avg_ab = ab / g))
mutate <- function(.data, ...) {
  stopifnot(is.data.frame(.data) || is.list(.data) || is.environment(.data))

  cols <- as.list(substitute(list(...))[-1])
  cols <- cols[names(cols) != ""] # Silently drop unnamed columns

  for (col in names(cols)) {
    .data[[col]] <- eval(cols[[col]], .data, parent.frame())
  }
  .data
}

#' Round to multiple of any number.
#'
#' @param x numeric vector, date-time (POSIXct) vector or table to round
#' @param accuracy number to round to; for POSIXct objects, a number of seconds
#' @param f rounding function: \code{\link{floor}}, \code{\link{ceiling}} or
#'  \code{\link{round}}
#' @keywords manip
#' @export
#' @examples
#' round_any(135, 10)
#' round_any(135, 100)
#' round_any(135, 25)
#' round_any(135, 10, floor)
#' round_any(135, 100, floor)
#' round_any(135, 25, floor)
#' round_any(135, 10, ceiling)
#' round_any(135, 100, ceiling)
#' round_any(135, 25, ceiling)
#'
#' round_any(Sys.time() + 1:10, 5)
#' round_any(Sys.time() + 1:10, 5, floor)
#' round_any(Sys.time(), 3600)
round_any <- function(x, accuracy, f = round) {
  UseMethod("round_any")
}

#' @export
round_any.numeric <- function(x, accuracy, f = round) {
  f(x / accuracy) * accuracy
}

#' @export
round_any.POSIXct <- function(x, accuracy, f = round) {
  tz <- format(x[1], "%Z")
  xr <- round_any(as.numeric(x), accuracy, f)
  as.POSIXct(xr, origin="1970-01-01 00:00.00 UTC", tz=tz)
}

#' @export
round_any.table <- function(x, accuracy, f = round) {
  original_names <- dimnames(x)

  rounded_values <- round_any.numeric(
    as.numeric(x), accuracy, round)

  if(length(dim(x)) == 1) {
    y <- as.table(rounded_values)
    dimnames(y) <- original_names
  } else {
    y <- as.table(matrix(rounded_values,
                         nrow = nrow(x), ncol = ncol(x),
                         dimnames = original_names))
  }
  y <- as.table(apply(y, 1:length(dim(x)), function (values) {
    (as.integer(values))
  }))

  return(y)
}

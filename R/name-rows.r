#' Toggle row names between explicit and implicit.
#'
#' Plyr functions ignore row names, so this function provides a way to preserve
#' them by converting them to an explicit column in the data frame.  After the
#' plyr operation, you can then apply \code{name_rows} again to convert back
#' from the explicit column to the implicit \code{rownames}.
#'
#' @param df a data.frame, with either \code{rownames}, or a column called
#'  \code{.rownames}.
#' @export
#' @keywords manip
#' @examples
#' name_rows(mtcars)
#' name_rows(name_rows(mtcars))
#'
#' df <- data.frame(a = sample(10))
#' arrange(df, a)
#' arrange(name_rows(df), a)
#' name_rows(arrange(name_rows(df), a))
name_rows <- function(df) {
  stopifnot(is.data.frame(df))

  rn_col <- !is.null(df$.rownames)

  if (rn_col) {
    rownames(df) <- df$.rownames
    df$.rownames <- NULL
  } else {
    df$.rownames <- rownames(df)
    rownames(df) <- NULL
  }

  df
}

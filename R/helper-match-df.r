#' Extract matching rows of a data frame.
#'
#' Match works in the same way as join, but instead of return the combined
#' dataset, it only returns the matching rows from the first dataset. This is
#' particularly useful when you've summarised the data in some way
#' and want to subset the original data by a characteristic of the subset.
#'
#' \code{match_df} shares the same semantics as \code{\link{join}}, not
#' \code{\link{match}}:
#'
#' \itemize{
#'   \item the match criterion is \code{==}, not \code{\link{identical}}).
#'   \item it doesn't work for columns that are not atomic vectors
#'   \item if there are no matches, the row will be omitted'
#' }
#'
#' @param x data frame to subset.
#' @param y data frame defining matching rows.
#' @param on variables to match on - by default will use all variables common
#'   to both data frames.
#' @return a data frame
#' @seealso \code{\link{join}} to combine the columns from both x and y
#'  and \code{\link{match}} for the base function selecting matching items
#' @export
#' @examples
#' # count the occurrences of each id in the baseball dataframe, then get the subset with a freq >25
#' longterm <- subset(count(baseball, "id"), freq > 25)
#' # longterm
#' #             id freq
#' # 30   ansonca01   27
#' # 48   baineha01   27
#' # ...
#' # Select only rows from these longterm players from the baseball dataframe
#' # (match would default to match on shared column names, but here was explicitly set "id")
#' bb_longterm <- match_df(baseball, longterm, on="id")
#' bb_longterm[1:5,]
match_df <- function(x, y, on = NULL) {
  if (is.null(on)) {
    on <- intersect(names(x), names(y))
    message("Matching on: ", paste(on, collapse = ", "))
  }

  keys <- join.keys(x, y, on)
  x[keys$x %in% keys$y, , drop = FALSE]
}

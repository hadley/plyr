#' plyr: the split-apply-combine paradigm for R.
#'
#' The plyr package is a set of clean and consistent tools that implement the
#' split-apply-combine pattern in R. This is an extremely common pattern in
#' data analysis: you solve a complex problem by breaking it down into small
#' pieces, doing something to each piece and then combining the results back
#' together again.
#'
#' The plyr functions are named according to what sort of data structure they
#' split up and what sort of data structure they return:
#'
#' \describe{
#'   \item{a}{array}
#'   \item{l}{list}
#'   \item{d}{data.frame}
#'   \item{m}{multiple inputs}
#'   \item{r}{repeat multiple times}
#'   \item{_}{nothing}
#' }
#'
#' So \code{\link{ddply}} takes a data frame as input and returns a data frame
#' as output, and \code{\link{l_ply}} takes a list as input and returns nothing
#' as output.
#'
#' @section Row names:
#'
#' By design, no plyr function will preserve row names - in general it is too
#' hard to know what should be done with them for many of the operations
#' supported by plyr. If you want to preserve row names, use
#' \code{\link{name_rows}} to convert them into an explicit column in your
#' data frame, perform the plyr operations, and then use \code{\link{name_rows}}
#' again to convert the column back into row names.
#'
#' @section Helpers:
#'
#' Plyr also provides a set of helper functions for common data analysis
#' problems:
#'
#' \itemize{
#'   \item \code{\link{arrange}}: re-order the rows of a data frame by
#'     specifying the columns to order by
#'   \item \code{\link{mutate}}: add new columns or modifying existing columns,
#'     like \code{\link{transform}}, but new columns can refer to other columns
#'     that you just created.
#'   \item \code{\link{summarise}}: like \code{\link{mutate}} but create a
#'     new data frame, not preserving any columns in the old data frame.
#'
#'   \item \code{\link{join}}: an adapation of \code{\link{merge}} which is
#'     more similar to SQL, and has a much faster implementation if you only
#'     want to find the first match.
#'   \item \code{\link{match_df}}: a version of \code{\link{join}} that instead
#'     of returning the two tables combined together, only returns the rows
#'     in the first table that match the second.
#'
#'   \item \code{\link{colwise}}: make any function work colwise on a dataframe
#'   \item \code{\link{rename}}: easily rename columns in a data frame
#'   \item \code{\link{round_any}}: round a number to any degree of precision
#'   \item \code{\link{count}}: quickly count unique combinations and return
#'     return as a data frame.
#' }
#'
#' @docType package
#' @importFrom Rcpp sourceCpp
#' @useDynLib plyr, .registration = TRUE
#' @name plyr
# EXCLUDE COVERAGE START
NULL


.onUnload <- function (libpath) {
  library.dynam.unload("plyr", libpath)
}
# EXCLUDE COVERAGE END

#' Split list, apply function, and return results in a data frame.
#' For each element of a list, apply function then combine results into a data  frame
#' 
#' All plyr functions use the same split-apply-combine strategy: they split the
#' input into simpler pieces, apply \code{.fun} to each piece, and then combine
#' the pieces into a single data structure.  This function splits lists by
#' elements and combines the result into a data frame.  If there are no
#' results, then this function will return a data frame with zero rows and
#' columns (\code{data.frame()}).
#' 
#' The most unambiguous behaviour is achieved when \code{.fun} returns a 
#' data frame - in that case pieces will be combined with
#' \code{\link{rbind.fill}}.  If \code{.fun} returns an atomic vector of fixed
#' length, it will be \code{rbind}ed together and converted to a data frame.
#' Any other values will result in an error.
#' 
#' 
#' @keywords manip
#' @param .data list to be processed
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel 
#'   backend provided by foreach
#' @return a data frame
#' @export
ldply <- function(.data, .fun = NULL, ..., .progress = "none", .parallel = FALSE) {
  if (!inherits(.data, "split")) .data <- as.list(.data)
  res <- llply(.data = .data, .fun = .fun, ..., 
    .progress = .progress, .parallel = .parallel)
  
  list_to_dataframe(res, attr(.data, "split_labels"))
}

#' Split data frame, apply function, and return results in a data frame.
#' For each subset of a data frame, apply function then combine results into a  data frame
#' 
#' All plyr functions use the same split-apply-combine strategy: they split the
#' input into simpler pieces, apply \code{.fun} to each piece, and then combine
#' the pieces into a single data structure.  This function splits data frames
#' by variables and combines the result into a data frame.  If there are no 
#' results, then this function will return a data frame with zero rows and
#' columns (\code{data.frame()}).
#' 
#' The most unambiguous behaviour is achieved when \code{.fun} returns a 
#' data frame - in that case pieces will be combined with
#' \code{\link{rbind.fill}}.  If \code{.fun} returns an atomic vector of fixed
#' length, it will be \code{rbind}ed together and converted to a data frame.
#' Any other values will result in an error.
#' 
#' 
#' @keywords manip
#' @param .data data frame to be processed
#' @param .variables variables to split data frame by, as quoted variables, a formula or character vector
#' @param .fun function to apply to each piece
#' @param .drop should combinations of variables that do not appear in the 
#'   data be preserved (FALSE) or dropped (TRUE, default)
#' @param ... other arguments passed on to \code{.fun}
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel 
#'   backend provided by foreach
#' @return a data frame
#' @export
#' @examples
#' ddply(baseball, .(year), "nrow") 
#' ddply(baseball, .(lg), c("nrow", "ncol")) 
#' 
#' rbi <- ddply(baseball, .(year), summarise, 
#'   mean_rbi = mean(rbi, na.rm = TRUE))
#' with(rbi, plot(year, mean_rbi, type="l"))
#'
#' base2 <- ddply(baseball, .(id), transform, 
#'  career_year = year - min(year) + 1
#' )
ddply <- function(.data, .variables, .fun = NULL, ..., .progress = "none", .drop = TRUE, .parallel = FALSE) {
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables, drop = .drop)
  
  ldply(.data = pieces, .fun = .fun, ..., 
    .progress = .progress, .parallel = .parallel)
}

#' Split array, apply function, and return results in a data frame.
#' For each slice of an array, apply function then combine results into a data frame
#' 
#' All plyr functions use the same split-apply-combine strategy: they split the
#' input into simpler pieces, apply \code{.fun} to each piece, and then combine
#' the pieces into a single data structure. This function splits matrices,
#' arrays and data frames by dimensions and combines the result into a data
#' frame. If there are no results, then this function will return a data frame
#' with zero rows and columns (\code{data.frame()}).
#' 
#' @keywords manip
#' @param .data matrix, array or data frame to be processed
#' @param .margins a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .expand if \code{.data} is a data frame, should output be 1d 
#'   (expand = FALSE), with an element for each row; or nd (expand = TRUE),
#'    with a dimension for each variable.
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .parallel if \code{TRUE}, apply function in parallel, using parallel 
#'   backend provided by foreach
#' @return a data frame
#' @export
adply <- function(.data, .margins, .fun = NULL, ..., .expand = TRUE, .progress = "none", .parallel = FALSE) {
  pieces <- splitter_a(.data, .margins, .expand)
  
  ldply(.data = pieces, .fun = .fun, ..., 
    .progress = .progress, .parallel = .parallel)
}
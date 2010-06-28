#' Split list, apply function, and discard results.
#' For each element of a list, apply function and discard results
#' 
#' All plyr functions use the same split-apply-combine strategy: they split the
#' input into simpler pieces, apply \code{.fun} to each piece, and then combine
#' the pieces into a single data structure.  This function splits lists by
#' elements and discards the output.  This is useful for functions that you are 
#' calling purely for their side effects like display plots and saving output.
#' 
#' 
#' @keywords manip
#' @param .data list to be processed
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .print automatically print each result? (default: \code{FALSE})
#' @export
l_ply <- function(.data, .fun = NULL, ..., .progress = "none", .print = FALSE) {
  if (is.character(.fun)) .fun <- do.call("each", as.list(.fun))
  if (!is.function(.fun)) stop(".fun is not a function.")
  
  progress <- create_progress_bar(.progress)
  progress$init(length(.data))
  on.exit(progress$term())
  
  .data <- as.list(.data)
  for(i in seq_along(.data)) {
    x <- .fun(.data[[i]], ...)
    if (.print) print(x)
    progress$step()
  }
  
  invisible()
}

#' Split data frame, apply function, and discard results.
#' For each subset of a data frame, apply function and discard results
#' 
#' All plyr functions use the same split-apply-combine strategy: they split the
#' input into simpler pieces, apply \code{.fun} to each piece, and then combine
#' the pieces into a single data structure.  This function splits data frames
#' by variable and discards the output.  This is useful for functions that you
#' are calling purely for their side effects like display plots and saving
#' output.
#' 
#' 
#' @keywords manip
#' @param .data data frame to be processed
#' @param .variables variables to split data frame by, as quoted variables, a formula or character vector
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .print automatically print each result? (default: \code{FALSE})
#' @export
d_ply <- function(.data, .variables, .fun = NULL, ..., .progress = "none", .print = FALSE) {
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables)
  
  l_ply(.data = pieces, .fun = .fun, ..., .progress = .progress, .print = .print)
}

#' Split array, apply function, and discard results.
#' For each slice of an array, apply function and discard results
#' 
#' All plyr functions use the same split-apply-combine strategy: they split the
#' input into simpler pieces, apply \code{.fun} to each piece, and then combine
#' the pieces into a single data structure.  This function splits matrices,
#' arrays and data frames by dimensions and discards the output.  This is
#' useful for functions that you are calling purely for their side effects like
#' display plots and saving output.
#' 
#' 
#' @keywords manip
#' @param .data matrix, array or data frame to be processed
#' @param .margins a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions
#' @param .fun function to apply to each piece
#' @param ... other arguments passed on to \code{.fun}
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .print automatically print each result? (default: \code{FALSE})
#' @export
a_ply <- function(.data, .margins, .fun = NULL, ..., .progress = "none", .print = FALSE) {
  pieces <- splitter_a(.data, .margins)
  
  l_ply(.data = pieces, .fun = .fun, ..., .progress = .progress, .print = .print)
}
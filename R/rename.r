#' Modify names by name, not position.
#'
#' @param x named object to modify
#' @param replace named character vector, with new names as values, and
#'   old names as names.
#' @param warn_missing print a message if any of the old names are
#'   not actually present in \code{x}.
#' @param duplicate_behavior specifies the behavior if duplicates names would result in \code{x}.  
#' Options are \code{error}, \code{warning}, \code{message}, and \code{silent}.  
#' The default is \code{warning}.
#' Note: x is not altered: To save the result, you need to copy the returned
#'   data into a variable.
#' @export
#' @importFrom stats setNames
#' @examples
#' x <- c("a" = 1, "b" = 2, d = 3, 4)
#' # Rename column d to "c", updating the variable "x" with the result
#' x <- rename(x, replace=c("d" = "c"))
#' x
#' # Rename column "disp" to "displacement"
#' rename(mtcars, c("disp" = "displacement"))
rename <- function(x, replace, warn_missing = TRUE, duplicate_behavior = "warning" ) {
  
  # This line does the real work of `rename()`.
  names(x) <- revalue(names(x), replace, warn_missing = warn_missing)
  
  # Check if any names are duplicated
  tabled_values <- table(names(x))
  duplicated_names <- names(tabled_values[tabled_values>1])
  if( length(duplicated_names) > 0L ) {
    #     response_message <- paste0("The plyr::rename operation has created duplicates for the following names: `", paste(duplicated_names, collapse="`, `"), "`")
    response_message <- paste0("The plyr::rename operation has created duplicates for the following name(s): (`", paste(duplicated_names, collapse="`, `"), "`)")
    if( duplicate_behavior == "error") stop(response_message)
    else if( duplicate_behavior == "warning" ) warning(response_message)
    else if( duplicate_behavior == "message" ) message(response_message)
    else if( duplicate_behavior != "silent" ) stop("The plyr::rename value passed to the `duplicate_behavior` parameter was not recognized.")
  }  
  return( x )
}

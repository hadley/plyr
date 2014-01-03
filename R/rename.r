#' Modify names by name, not position.
#'
#' @param x named object to modify
#' @param replace named character vector, with new names as values, and
#'   old names as names.
#' @param warn_missing print a message if any of the old names are
#'   not actually present in \code{x}.
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
  base::names(x) <- plyr::revalue(base::names(x), replace, warn_missing = warn_missing)
  
  # Check if any names are duplicated
  tabled_values <- base::table(base::names(x))
  duplicated_names <- base::names(tabled_values[tabled_values>1])
  if( base::length(duplicated_names) > 0L ) {
    response_message <- base::paste0("The plyr::rename operation has created duplicates in the following name(s): (`", base::paste(duplicated_names, collapse="`, `"), "`)")
    if( duplicate_behavior == "error") base::stop(response_message)
    if( duplicate_behavior == "warning" ) base::warning(response_message)
    if( duplicate_behavior == "message" ) base::message(response_message)
    if( duplicate_behavior != "silent" ) base::stop("The plyr::rename value passed to the `duplicate_behavior` parameter was not recognized.")
  }
  
  return( x )
}

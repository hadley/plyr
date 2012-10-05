#' Modify names by name, not position.
#'
#' @param x named object to modify
#' @param replace named character vector, with new names as values, and
#'   old names as names.
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
rename <- function (x, replace) {
  old_names <- names(x)
  new_names <- unname(replace)[match(old_names, names(replace))]
  
  setNames(x, ifelse(is.na(new_names), old_names, new_names))
}

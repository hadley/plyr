#' Modify names by name, not position.
#'
#' @param x named object to modify
#' @param replace named character vector, with new names as values, and
#'   old names as names.
#' @export
#' @examples
#' x <- c("a" = 1, "b" = 2, d = 3, 4)
#' rename(x, c("d" = "c"))
#' rename(mtcars, c("disp" = "displ"))
rename <- function (x, replace) {
  old_names <- names(x)
  new_names <- unname(replace)
  name_match <- match(old_names, names(replace))
  
  setNames(x, ifelse(is.na(name_match), old_names, new_names))
}

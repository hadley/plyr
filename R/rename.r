#' Modify names by name, not position.
#'
#' @param x named object to modify
#' @param replace named character vector, with new names as values, and
#'   old names as names.
#' @param warn_missing print a message if any of the old names are
#'   not actually present in \code{x}.
#' @param warn_duplicated print a message if any name appears more
#'   than once in \code{x} after the operation.
#' Note: x is not altered: To save the result, you need to copy the returned
#'   data into a variable.
#' @export
#' @importFrom stats setNames
#' @examples
#' x <- c("a" = 1, "b" = 2, d = 3, 4)
#' # Rename column d to "c", updating the variable "x" with the result
#' x <- rename(x, replace = c("d" = "c"))
#' x
#' # Rename column "disp" to "displacement"
#' rename(mtcars, c("disp" = "displacement"))
rename <- function(x, replace, warn_missing = TRUE, warn_duplicated = TRUE ) {

  # This line does the real work of `rename()`.
  names(x) <- revalue(names(x), replace, warn_missing = warn_missing)

  # Check if any names are duplicated.
  duplicated_names <- names(x)[duplicated(names(x))]
  if (warn_duplicated && (length(duplicated_names) > 0L)) {
    duplicated_names_message <- paste0("`", duplicated_names, "`", collapse=", ")
    warning("The plyr::rename operation has created duplicates for the ",
            "following name(s): (", duplicated_names_message, ")",
            call. = FALSE)
  }
  x
}

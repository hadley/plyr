#' Determine if a vector is discrete.
#'
#' A discrete vector is a factor or a character vector
#'
#' @param x vector to test
#' @keywords internal
#' @export
#' @examples
#' is.discrete(1:10)
#' is.discrete(c("a", "b", "c"))
#' is.discrete(factor(c("a", "b", "c")))
is.discrete <- function(x) is.factor(x) || is.character(x) || is.logical(x)

#' Un-rowname.
#'
#' Strip rownames from an object
#'
#' @keywords internal
#' @param x data frame
#' @export
unrowname <- function(x) {
  rownames(x) <- NULL
  x
}

#' Function that always returns true.
#'
#' @param ... all input ignored
#' @return \code{TRUE}
#' @keywords internal
#' @seealso \code{\link{colwise}} which uses it
#' @export
true <- function(...) TRUE

#' Compact list.
#'
#' Remove all NULL entries from a list
#'
#' @param l list
#' @keywords manip internal
#' @export
compact <- function(l) Filter(Negate(is.null), l)

#' Number of unique values.
#'
#' Calculate number of unique values of a variable as efficiently as possible.
#'
#' @param x vector
#' @keywords internal
nunique <- function(x) {
  if (is.factor(x)) {
    length(levels(x))
  } else {
    length(unique(x))
  }
}

#' Check if a data frame is empty.
#'
#' Empty if it's null or it has 0 rows or columns
#'
#' @param df data frame to check
#' @keywords internal
#' @export
empty <- function(df) {
  (is.null(df) || nrow(df) == 0 || ncol(df) == 0)
}

#' Is a formula?
#' Checks if argument is a formula
#'
#' @keywords internal
#' @export
is.formula <- function(x) inherits(x, "formula")

"%||%" <- function(a, b) if (is.null(a)) b else a

.matrix_to_df <- function(.data) {
  cnames <- colnames(.data)
  if (is.null(cnames)) cnames <- rep("", ncol(.data))
  .data <- as.data.frame(.data, stringsAsFactors = FALSE)
  colnames(.data) <- cnames
  .data
}

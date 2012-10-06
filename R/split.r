#' Subset splits.
#'
#' Subset splits, ensuring that labels keep matching
#'
#' @keywords internal
#' @param x split object
#' @param i index
#' @param ... unused
#' @method [ split
#' @rdname get-split
#' @export
"[.split" <- function(x, i, ...) {
  structure(
    NextMethod(),
    class = c("split", "list"),
    split_type = attr(x, "split_type"),
    split_labels = attr(x, "split_labels")[i, , drop = FALSE]
  )
}

#' Convert split list to regular list.
#'
#' Strip off label related attributed to make a strip list as regular list
#'
#' @keywords internal
#' @param x object to convert to a list
#' @param ... unused
#' @method as.list split
#' @export
as.list.split <- function(x, ...) {
  attr(x, "split_type") <- NULL
  attr(x, "split_labels") <- NULL
  class(x) <- setdiff(class(x), "split")
  x
}

#' Print split.
#'
#' Don't print labels, so it appears like a regular list
#'
#' @keywords internal
#' @param x object to print
#' @param ... unused
#' @method print split
#' @export
print.split <- function(x, ...) {
  print(as.list(x))
}

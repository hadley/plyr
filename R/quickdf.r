#' Quick data frame.
#'
#' Experimental version of \code{\link{as.data.frame}} that converts a
#' list to a data frame, but doesn't do any checks to make sure it's a
#' valid format.  Much faster.
#'
#' @param list list to convert to data frame
#' @keywords internal
#' @export
quickdf <- function(list) {
  rows <- unique(unlist(lapply(list, NROW)))
  stopifnot(length(rows) == 1)

  names(list) <- make_names(list, "X")
  class(list) <- "data.frame"
  attr(list, "row.names") <- c(NA_integer_, -rows)

  list
}

make_names <- function(x, prefix = "X") {
  nm <- names(x)
  if (is.null(nm)) {
    nm <- rep.int("", length(x))
  }

  n <- sum(nm == "", na.rm = TRUE)
  nm[nm == ""] <- paste(prefix, seq_len(n), sep = "")
  nm
}

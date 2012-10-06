library(microbenchmark)

quickdf1 <- function(list) {
  rows <- unique(unlist(lapply(list, NROW)))
  stopifnot(length(rows) == 1)

  names(list) <- make_names(list, "X")

  structure(list,
    class = "data.frame",
    row.names = seq_len(rows))
}

quickdf2 <- function(list) {
  rows <- unique(unlist(lapply(list, NROW)))
  stopifnot(length(rows) == 1)

  names(list) <- make_names(list, "X")
  class(list) <- "data.frame"
  attr(list, "row.names") <- c(NA_integer_, -rows)

  list
}

a <- list(a = 1:1e4, b = 1:1e4, c = 1:1e4)

microbenchmark(
  quickdf1(a),
  quickdf2(a))

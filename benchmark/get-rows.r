library(microbenchmark)

row1 <- function(x, i) {
  x[i, , ]
}
row2 <- function(x, i) {
  x[i, , drop = FALSE]
}

row3 <- function(x, i) {
  n <- ncol(x)
  out <- vector("list", n)

  for(j in seq_len(n)) {
    out[[j]] <- .subset(.subset2(x, j), i)
  }

  names(out) <- names(x)
  class(out) <- "data.frame"
  attr(out, "row.names") <- c(NA_integer_, -length(out[[1]]))

  out
}

row4 <- function(x, i) {
  n <- ncol(x)
  out <- lapply(seq_len(n), function(j) .subset(.subset2(x, j), i))

  names(out) <- names(x)
  class(out) <- "data.frame"
  attr(out, "row.names") <- c(NA_integer_, -length(out[[1]]))

  out
}

# Preserve attributes
row5 <- function(x, i) {
  n <- ncol(x)
  out <- lapply(seq_len(n), function(j) {
    col <- .subset2(x, j)

    x <- .subset(col, i)
    attributes(x) <- attributes(col)
    x
  })

  names(out) <- names(x)
  class(out) <- "data.frame"
  attr(out, "row.names") <- c(NA_integer_, -length(out[[1]]))

  out
}

# Dispatch on [
row6 <- function(x, i) {
  n <- ncol(x)
  out <- lapply(seq_len(n), function(j) .subset2(x, j)[i])

  names(out) <- names(x)
  class(out) <- "data.frame"
  attr(out, "row.names") <- c(NA_integer_, -length(out[[1]]))

  out
}

# Special case so that usual are fast and everything else is safe
row7 <- function(x, i) {
  n <- ncol(x)

  sub_col <- function(df, i, j) {
    col <- .subset2(df, j)
    if (isS4(col)) return(col[i])

    if (is.null(attr(col, "class"))) {
      .subset(col, i)
    } else if (inherits(col, "factor") || inherits(x, "POSIXt")) {
      out <- .subset(col, i)
      attributes(out) <- attributes(col)
      out
    } else {
      col[i]
    }
  }

  out <- lapply(seq_len(n), sub_col, df = x, i = i)

  names(out) <- names(x)
  class(out) <- "data.frame"
  attr(out, "row.names") <- c(NA_integer_, -length(out[[1]]))

  out
}

# Row7 but with quickdf - loses all gains by duplicating (once?)
row8 <- function(x, i) {
  n <- ncol(x)

  sub_col <- function(df, i, j) {
    col <- .subset2(df, j)
    if (isS4(col)) return(col[i])

    if (is.null(attr(col, "class"))) {
      .subset(col, i)
    } else if (inherits(col, "factor") || inherits(x, "POSIXt")) {
      out <- .subset(col, i)
      attributes(out) <- attributes(col)
      out
    } else {
      col[i]
    }
  }

  out <- lapply(seq_len(n), sub_col, df = x, i = i)
  quickdf(out)
}

if (FALSE) {
  n <- 1000; p <- 10
  df <- as.data.frame(replicate(p, runif(n)))
  names(df) <- letters[1:ncol(df)]


  microbenchmark(
    row1(df, 5000:6000),
    row2(df, 5000:6000),
    row3(df, 5000:6000),
    row4(df, 5000:6000),
    row5(df, 5000:6000),
    row6(df, 5000:6000),
    row7(df, 5000:6000),
    row8(df, 5000:6000)
  )

}

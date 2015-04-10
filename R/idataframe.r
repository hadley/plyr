#' Construct an immutable data frame.
#'
#' An immutable data frame works like an ordinary data frame, except that when
#' you subset it, it returns a reference to the original data frame, not a
#' a copy. This makes subsetting substantially faster and has a big impact
#' when you are working with large datasets with many groups.
#'
#' This method is still a little experimental, so please let me know if you
#' run into any problems.
#'
#' @param df a data frame
#' @return an immutable data frame
#' @keywords manip
#' @export
#' @examples
#' system.time(dlply(baseball, "id", nrow))
#' system.time(dlply(idata.frame(baseball), "id", nrow))
idata.frame <- function(df) {
  self <- new.env()
  self$`_data` <- df
  self$`_rows` <- seq_len(nrow(df))
  self$`_cols` <- names(df)
  self$`_getters` <- lapply(names(df), function(name) {
    eval(substitute(function(v) {
      if (missing(v)) {
        `_data`[[name]][`_rows`]
      } else {
        stop("Immutable")
      }
    },
    list(name = name)), envir=self)
  })
  names(self$`_getters`) <- names(df)
  for (name in names(df)) {
    f <- self$`_getters`[[name]]
    environment(f) <- self
    makeActiveBinding(name, f, self)
  }
  structure(self,
    class = c("idf", "environment"))
}

#' @export
"[.idf" <- function(x, i, j, drop = TRUE) {
  # Single column special cases
  if (nargs() == 2) {
    j <- i
    i <- TRUE
    drop <- FALSE
  }
  if (!missing(j) && length(j) == 1 && drop) {
    if (missing(i)) i <- TRUE
    return(x[[j]][i])
  }

  # New rows
  rows <- x$`_rows`
  if (!missing(i)) {
    if (is.character(i)) stop("Row names not supported")
    rows <- rows[i]
  }

  # New cols
  cols <- x$`_cols`
  if (!missing(j)) {
    if (is.character(j)) {
      cols <- intersect(cols, j)
    } else {
      cols <- cols[j]
    }
  }

  # Make active bindings for functions like lm and eval that will treat this
  # object as an environment or list
  self <- new.env(parent = parent.env(x))
  self$`_rows` <- rows
  self$`_cols` <- cols
  self$`_data` <- x$`_data`
  self$`_getters` <- x$`_getters`

  for (col in cols) {
    f <- self$`_getters`[[col]]
    environment(f) <- self
    makeActiveBinding(col, f, self)
  }

  structure(self,
    class = c("idf", "environment"))
}

#' @export
names.idf <- function(x) x$`_cols`

#' @export
dim.idf <- function(x) c(length(x$`_rows`), length(x$`_cols`))

#' @export
as.data.frame.idf <- function(x, ...) {
  x$`_data`[x$`_rows`, x$`_cols`]
}

#' @export
"[[.idf" <- function(x, i) {
  if (is.numeric(i)) {
    i <- names(x)[i]
  }
  x$`_data`[[i]][x$`_rows`]
}

# "[[<-.idf" <- "[<-.idf" <- function(...) stop("Immutable")

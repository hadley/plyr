#' Split a data frame by variables.
#'
#' Split a data frame into pieces based on variable contained in that data frame
#'
#' This is the workhorse of the \code{d*ply} functions.  Based on the variables
#' you supply, it breaks up a single data frame into a list of data frames,
#' each containing a single combination from the levels of the specified
#' variables.
#'
#' This is basically a thin wrapper around \code{\link{split}} which
#' evaluates the variables in the context of the data, and includes enough
#' information to reconstruct the labelling of the data frame after
#' other operations.
#'
#' @seealso \code{\link{.}} for quoting variables, \code{\link{split}}
#' @family splitter functions
#' @param data data frame
#' @param .variables a \link{quoted} list of variables
#' @param drop drop unnused factor levels?
#' @return a list of data.frames, with attributes that record split details
#' @keywords internal
#' @examples
#' plyr:::splitter_d(mtcars, .(cyl))
#' plyr:::splitter_d(mtcars, .(vs, am))
#' plyr:::splitter_d(mtcars, .(am, vs))
#'
#' mtcars$cyl2 <- factor(mtcars$cyl, levels = c(2, 4, 6, 8, 10))
#' plyr:::splitter_d(mtcars, .(cyl2), drop = TRUE)
#' plyr:::splitter_d(mtcars, .(cyl2), drop = FALSE)
#'
#' mtcars$cyl3 <- ifelse(mtcars$vs == 1, NA, mtcars$cyl)
#' plyr:::splitter_d(mtcars, .(cyl3))
#' plyr:::splitter_d(mtcars, .(cyl3, vs))
#' plyr:::splitter_d(mtcars, .(cyl3, vs), drop = FALSE)
splitter_d <- function(data, .variables = NULL, drop = TRUE) {
  stopifnot(is.quoted(.variables))


  if (length(.variables) == 0) {
    splitv <- rep(1, nrow(data))
    split_labels <- NULL
    attr(splitv, "n") <- max(splitv)
    vars <- character(0)
  } else {
    splits <- eval.quoted(.variables, data)

    splitv <- id(splits, drop = drop)
    split_labels <- split_labels(splits, drop = drop, id = splitv)
    vars <- unlist(lapply(.variables, all.vars))
  }

  index <- split_indices(as.integer(splitv), attr(splitv, "n"))

  il <- indexed_df(data, index, vars)

  structure(
    il,
    class = c(class(il), "split", "list"),
    split_type = "data.frame",
    split_labels = split_labels
  )
}

#' Generate labels for split data frame.
#'
#' Create data frame giving labels for split data frame.
#'
#' @param list of variables to split up by
#' @param whether all possible combinations should be considered, or only those present in the data
#' @keywords internal
#' @export
split_labels <- function(splits, drop, id = plyr::id(splits, drop = TRUE)) {
  if (length(splits) == 0) return(data.frame())

  if (drop) {
    # Need levels which occur in data
    representative <- which(!duplicated(id))[order(unique(id))]
    quickdf(lapply(splits, function(x) x[representative]))
  } else {
    unique_values <- llply(splits, ulevels)
    names(unique_values) <- names(splits)
    rev(expand.grid(rev(unique_values), stringsAsFactors = FALSE))
  }
}

ulevels <- function(x) {
  if (is.factor(x)) {
    x <- addNA(x, ifany = TRUE)
    levs <- levels(x)
    factor(levs, levels = levs)
  } else {
    sort(unique(x))
  }

}

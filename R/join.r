#' Join two data frames together.
#'
#' Join, like merge, is designed for the types of problems
#' where you would use a sql join.
#'
#' The four join types return:
#'
#' \itemize{
#'  \item \code{inner}:  only rows with matching keys in both x and y
#'  \item \code{left}:   all rows in x, adding matching columns from y
#'  \item \code{right}:  all rows in y, adding matching columns from x
#'  \item \code{full}:   all rows in x with matching columns in y, then the
#'    rows of y that don't match x.
#' }
#'
#' Note that from plyr 1.5, \code{join} will (by default) return all matches,
#' not just the first match, as it did previously.
#'
#' Unlike merge, preserves the order of x no matter what join type is used.
#' If needed, rows from y will be added to the bottom.  Join is often faster
#' than merge, although it is somewhat less featureful - it currently offers
#' no way to rename output or merge on different variables in the x and y
#' data frames.
#'
#' @param x data frame
#' @param y data frame
#' @param by character vector of variable names to join by. If omitted, will
#'   match on all common variables.
#' @param type type of join: left (default), right, inner or full.  See
#'   details for more information.
#' @param match how should duplicate ids be matched? Either match just the
#'   \code{"first"} matching row, or match \code{"all"} matching rows. Defaults
#'   to \code{"all"} for compatibility with merge, but \code{"first"} is
#'   significantly faster.
#' @keywords manip
#' @export
#' @examples
#' first <- ddply(baseball, "id", summarise, first = min(year))
#' system.time(b2 <- merge(baseball, first, by = "id", all.x = TRUE))
#' system.time(b3 <- join(baseball, first, by = "id"))
#'
#' b2 <- arrange(b2, id, year, stint)
#' b3 <- arrange(b3, id, year, stint)
#' stopifnot(all.equal(b2, b3))
join <- function(x, y, by = NULL, type = "left", match = "all") {
  type <- match.arg(type, c("left", "right", "inner", "full"))
  match <- match.arg(match, c("first", "all"))

  if (is.null(by)) {
    by <- intersect(names(x), names(y))
    message("Joining by: ", paste(by, collapse = ", "))
  }

  switch(match,
    "first" = .join_first(x, y, by, type),
    "all" = .join_all(x, y, by, type))
}

.join_first <- function(x, y, by, type) {
  keys <- join.keys(x, y, by = by)

  x.cols <- setdiff(names(x), by)
  y.cols <- setdiff(names(y), by)

  if (type == "inner") {
    x.match <- match(keys$y, keys$x, 0)
    y.match <- match(keys$x, keys$y, 0)

    cbind(
      x[x.match, by, drop = FALSE],
      x[x.match, x.cols, drop = FALSE],
      y[y.match, y.cols, drop = FALSE]
    )
  } else if (type == "left") {
    y.match <- match(keys$x, keys$y)
    y.matched <- unrowname(y[y.match, y.cols, drop = FALSE])

    cbind(x[by], x[x.cols], y.matched)
  } else if (type == "right") {
    if (any(duplicated(keys$y))) {
      stop("Duplicated key in y", call. = FALSE)
    }

    x.match <- match(keys$y, keys$x)
    x.matched <- unrowname(x[x.match, x.cols, drop = FALSE])

    cbind(y[by], x.matched, y[y.cols])
  } else if (type == "full") {
    # x with matching y's then any unmatched ys

    y.match <- match(keys$x, keys$y)
    y.matched <- unrowname(y[y.match, y.cols, drop = FALSE])

    y.unmatch <- is.na(match(keys$y, keys$x))

    rbind.fill(cbind(x[c(by, x.cols)], y.matched), y[y.unmatch, , drop = FALSE])
  }
}

# Basic idea to perform a full cartesian product of the two data frames
# and then evaluate which rows meet the merging criteria. But that is
# horrendously inefficient, so we do various types of hashing, implemented
# in R as split_indices
.join_all <- function(x, y, by, type) {
  x.cols <- setdiff(names(x), by)
  y.cols <- setdiff(names(y), by)

  if (type == "inner") {
    ids <- join_ids(x, y, by)
    out <- cbind(x[ids$x, , drop = FALSE], y[ids$y, y.cols, drop = FALSE])
  } else if (type == "left") {
    ids <- join_ids(x, y, by, all = TRUE)
    out <- cbind(x[ids$x, , drop = FALSE], y[ids$y, y.cols, drop = FALSE])
  } else if (type == "right") {
    # Flip x and y, but make sure to put new columns in the right place
    ids <- join_ids(y, x, by, all = TRUE)
    out <- cbind(
      y[ids$x, by, drop = FALSE],
      x[ids$y, x.cols, drop = FALSE],
      y[ids$x, y.cols, drop = FALSE]
    )
  } else if (type == "full") {
    # x's with all matching y's, then non-matching y's - just the same as
    # join.first
    ids <- join_ids(x, y, by, all = TRUE)

    matched <- cbind(x[ids$x, , drop = FALSE],
                     y[ids$y, y.cols, drop = FALSE])
    unmatched <- y[setdiff(seq_len(nrow(y)), ids$y), , drop = FALSE]
    out <- rbind.fill(matched, unmatched)
  }

  unrowname(out)
}

join_ids <- function(x, y, by, all = FALSE) {
  keys <- join.keys(x, y, by = by)

  ys <- split_indices(keys$y, keys$n)
  length(ys) <- keys$n

  if (all) {
    # replace NULL with NA to preserve those x's without matching y's
    nulls <- vapply(ys, function(x) length(x) == 0, logical(1))
    ys[nulls] <- list(NA_real_)
  }

  ys <- ys[keys$x]
  xs <- rep(seq_along(keys$x), vapply(ys, length, numeric(1)))

  list(x = xs, y = unlist(ys))
}

#' Join keys.
#' Given two data frames, create a unique key for each row.
#'
#' @param x data frame
#' @param y data frame
#' @param by character vector of variable names to join by
#' @keywords internal
#' @export
join.keys <- function(x, y, by) {
  joint <- rbind.fill(x[by], y[by])
  keys <- id(joint, drop = TRUE)

  n_x <- nrow(x)
  n_y <- nrow(y)

  list(
    x = keys[seq_len(n_x)],
    y = keys[n_x + seq_len(n_y)],
    n = attr(keys, "n")
  )
}

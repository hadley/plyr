#' Join two data frames together.
#'
#' Unlike merge, preserves the order of x no matter what join type is used.
#' If needed, rows from y will be added to the bottom.  
#' 
#' Join is about four times faster than merge, but it achieves this speed
#' by assuming unique keys:  if several rows share the same matching key, only
#' the first one will be matched.  Join will silently drop duplicate keys.
#'
#' Join like merge is designed for the types of problems
#' where you would use a sql join.  The four join types return:
#' \itemize{
#'  \item \code{inner}:  only rows with matching keys in both x and y
#'  \item \code{left}:   all rows in x, adding matching columns from y
#'  \item \code{right}:  all rows in y, adding matching columns from x
#'  \item \code{full}:   all rows in x with matching columns in y, then the
#'    rows of y that don't match x.
#' }
#' 
#' @param x data frame
#' @param y data frame
#' @param by character vector of variable names to join by
#' @param type type of join: left (default), right, inner or full.  See 
#'  details for more information.
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
join <- function(x, y, by = intersect(names(x), names(y)), type = "left") {
  type <- match.arg(type, c("left", "right", "inner", "full"))
  
  if (missing(by)) {
    message("Joining by: ", paste(by, collapse = ", "))
  }
  
  keys <- join.keys(x, y, by = by)
  new.cols <- setdiff(names(y), by)
  
  if (type == "inner") {
    x.match <- match(keys$y, keys$x, 0)
    y.match <- match(keys$x, keys$y, 0)
    cbind(x[x.match, , drop = FALSE], y[y.match, new.cols, drop = FALSE])

  } else if (type == "left") {    
    y.match <- match(keys$x, keys$y)
    y.matched <- unrowname(y[y.match, new.cols, drop = FALSE])
    cbind(x, y.matched)

  } else if (type == "right") {
    if (any(duplicated(keys$y))) {
      stop("Duplicated key in y", call. = FALSE)
    }
    
    x.match <- match(keys$y, keys$x)
    x.matched <- unrowname(x[x.match, , drop = FALSE])
    cbind(x.matched, y[, new.cols, drop = FALSE])
    
  } else if (type == "full") {
    # x with matching y's then any unmatched ys

    y.match <- match(keys$x, keys$y)
    y.matched <- unrowname(y[y.match, new.cols, drop = FALSE])

    y.unmatch <- is.na(match(keys$y, keys$x))
    
    rbind.fill(cbind(x, y.matched), y[y.unmatch, , drop = FALSE])
  }
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
  keys <- id(joint)
  
  list(
    x = keys[1:nrow(x)],
    y = keys[-(1:nrow(x))]
  )
}

#' Join two data frames together.
#'
#' Unlike merge, preserves the order of x no matter what join type is used.
#' If needed, rows from y will be added to the bottom.  
#' 
#' Join is about four times faster than merge, but it achieves this speed
#' by being less flexible, and is design for the types of problems where you 
#' would use a sql join.
#' 
#' @param x data frame
#' @param y data frame
#' @param by character vector of variable names to join by
#' @param join type of join: left (default), right, inner or full.
#' @keywords manip
#' @examples
#' first <- ddply(baseball, "id", summarise, first = min(year))
#' system.time(b2 <- merge(baseball, first, by = "id", all.x = TRUE))
#' system.time(b3 <- join(baseball, first, by = "id"))
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
    y.matched <- y[y.match, new.cols, drop = FALSE]
    rownames(y.matched) <- NULL
    cbind(x, y.matched)

  } else if (type == "right") {
    if (any(duplicated(keys$y))) {
      stop("Duplicated key in y", call. = FALSE)
    }
    
    x.match <- match(keys$y, keys$x)
    x.matched <- x[x.match, , drop = FALSE]
    rownames(x.matched) <- NULL
    cbind(x.matched, y[, new.cols, drop = FALSE])
    
  } else if (type == "full") {
    stop("Not implemented yet")
  }
}

#' Join keys
#' Given two data frames, create a unique key for each row.  
#'
#' @param x data frame
#' @param y data frame
#' @param by character vector of variable names to join by
#' @keywords internal
join.keys <- function(x, y, by) {
  joint <- rbind.fill(x[by], y[by])
  
  factors <- sapply(joint, is.factor)
  joint[!factors] <- lapply(joint[!factors], function(x) {
    factor(x, levels = unique(x))
  })
  
  keys <- ninteraction(joint)
  
  list(
    x = keys[1:nrow(x)],
    y = keys[-(1:nrow(x))]
  )
}

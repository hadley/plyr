# bsmall <- subset(baseball, id %in% sample(unique(baseball$id), 10))[, 1:5]
# bsmall$id <- factor(bsmall$id)
# bsmall <- bsmall[with(bsmall, order(id, year, stint)), ]
# bsmall <- bsmall[sample(rownames(bsmall)),  ]
# rownames(bsmall) <- NULL

# first <- ddply(baseball, "id", summarise, first = min(year))
# system.time(b2 <- merge(baseball, first, by = "id", all.x = T))
# system.time(b3 <- join(baseball, first, by = "id"))
# 
# b2 <- arrange(b2, id, year, stint)
# b3 <- arrange(b3, id, year, stint)
# rownames(b2) <- NULL
# rownames(b3) <- NULL
# all.equal(b2, b3)

# 
# geo1 <- merge(sales, ad, by = c("street", "city", "zip"), all.x = TRUE)
# geo1 <- arrange(geo1, zip, city, street, date)
# rownames(geo1) <- NULL
# 
# geo2 <- join(sales, ad, by = c("street", "city", "zip"))
# geo2 <- arrange(geo2, zip, city, street, date)
# rownames(geo2) <- NULL
# 
# system.time(join(sales, ad, by = c("street", "city", "zip")))
# 
# all.equal(geo1, geo2)


# Join
#
# Unlike merge, preserves the order of x no matter what join type is used.
# If needed, rows from y will be added to the bottom.
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

copy_rownames <- function(to, from) {
  rownames(to) <- rownames(from)
  to
}

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

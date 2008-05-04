# To a data frame -----------------------------------------------------------

ldply <- function(data, fun = NULL, ..., .progress = "none") {
  data <- as.list(data)
  res <- llply(data, fun, ..., .progress = .progress)
  if (length(res) == 0) return(data.frame())
  
  atomic <- unlist(llply(res, is.atomic))
  if (all(atomic)) {
    ulength <- unique(unlist(llply(res, length)))
    if (length(ulength) != 1) stop("Results are not equal lengths")
    
    if (length(res) > 1) {
      resdf <- as.data.frame(do.call("rbind", res))      
    } else {
      resdf <- data.frame(res[[1]])
    }
    rows <- rep(1, length(res))
  } else {
    l_ply(res, function(x) if(!is.null(x) & !is.data.frame(x)) stop("Not a data.frame!"))

    resdf <- do.call("rbind.fill", res)
    rows <- unname(laply(res, function(x) if(is.null(x)) 0 else nrow(x)))
  }

  labels <- attr(data, "split_labels")
  if (!is.null(labels) && nrow(labels) == length(data)) {
    cols <- setdiff(names(labels), names(resdf))
    resdf <- cbind(labels[rep(1:nrow(labels), rows), cols, drop=FALSE], resdf)
  }
  
  unrowname(resdf)
}

#X mean_rbi <- function(df) mean(df$rbi, na.rm=T)
#X rbi <- ddply(baseball, .(year), mean_rbi)
#X with(rbi, plot(year, V1, type="l"))
#X
#X ddply(baseball, .(year), numcolwise(mean), na.rm=TRUE)
#X base2 <- ddply(baseball, .(id), function(df) {
#X  transform(df, career_year = year - min(year) + 1)
#X })
ddply <- function(data, vars, fun = NULL, ..., .progress = "none") {
  data <- as.data.frame(data)
  pieces <- splitter_d(data, vars)
  
  ldply(pieces, fun, .progress = .progress)
}

#X adply(ozone, 1, mean)
#X adply(ozone, 3, mean)
#X adply(ozone, c(1,2), mean)
#X adply(ozone, c(1,2), each(mean, max, min))
adply <- function(data, margins, fun = NULL, ..., .progress = "none") {
  pieces <- splitter_a(data, margins)
  
  ldply(pieces, fun, .progress = .progress)
}
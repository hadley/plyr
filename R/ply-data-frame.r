# To a data frame -----------------------------------------------------------

ldply <- function(data, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  f <- robustify(fun, .try = .try, .quiet = .quiet, .explode = .explode)
    
  data <- as.list(data)
  res <- llply(data, f, ..., .progress = .progress)
  
  atomic <- laply(res, is.atomic)
  if (all(atomic)) {
    ulength <- unique(laply(res, length))
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
    resdf <- cbind(labels[rep(1:nrow(labels), rows), , drop=FALSE], resdf)
  }
  
  unrowname(resdf)
}

ddply <- function(data, vars, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  data <- as.data.frame(data)
  pieces <- splitter_d(data, vars)
  
  ldply(pieces, fun, .try = .try, .quiet = .quiet, .explode = .explode, .progress = .progress)
}

adply <- function(data, margins, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  pieces <- splitter_a(data, margins)
  
  ldply(pieces, fun, .try = .try, .quiet = .quiet, .explode = .explode, .progress = .progress)
}
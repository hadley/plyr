# To arrays  ----------------------------------------------------------------
# aa = iapply
# al -> ll -> la = iapply
# ad -> dl -> la = iapply
# la, da = ?  (but should hopefully match with aggregate)
#
# da(df, .(a), single.value) = 1 d
# da(df, .(a, b), , single.value) = 2 d
# da(df, .(a, b), vector)  = 3d

laply <-  function(data, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  f <- robustify(fun, .try = .try, .quiet = .quiet, .explode = .explode)
    
  data <- as.list(data)
  res <- llply(data, f, ..., .progress = .progress)
  
  atomic <- sapply(res, is.atomic)
  if (all(atomic)) {
    dlength <- unique(llply(res, dims))
    if (length(dlength) != 1) stop("Results must have same number of dimensions.")

    dims <- unique(do.call("rbind", llply(res, vdim)))
    if (nrow(dims) != 1) stop("Results must have the same dimensions.")    

    res_dim <- vdim(res[[1]])
    res_index <- expand.grid(lapply(res_dim, seq_len))
  } else {
    res_index <- as.data.frame(matrix(0, 1, 0))
    res_dim <- numeric()
  }
  
  labels <- attr(data, "split_labels")
  
  index <- cbind(
    labels[rep(seq_len(nrow(labels)), each = nrow(res_index)), , drop = FALSE],
    res_index[rep(seq_len(nrow(res_index)), nrow(labels)), , drop = FALSE]
  )
  
  outdim <- c(
    unlist(lapply(labels, function(x) length(unique(x)))),
    res_dim
  )
  
  resa <- res[order(ninteraction(index))]        
  attr(resa, "split_type") <- NULL
  attr(resa, "split_labels") <- NULL
  class(resa) <- class(resa)[2]
  
  dim(resa) <- outdim
  dimnames(resa) <- c(lapply(labels, unique), rep(list(NULL), length(outdim) - ncol(labels)))
  resa <- reduce(resa)
  resa
}

#X daply(baseball, .(year), nrow)
#X
#X # Several different ways of summarising by variables that should not be 
#X # included in the summary
#X 
#X daply(baseball[, c(2, 6:9)], .(year), mean)
#X daply(baseball[, 6:9], .(baseball$year), mean)
#X daply(baseball, .(year), function(df) mean(df[, 6:9]))
daply <- function(data, vars, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  data <- as.data.frame(data)
  pieces <- splitter_d(data, vars)
  
  laply(pieces, fun, .try = .try, .quiet = .quiet, .explode = .explode, .progress = .progress)
}

aaply <- function(data, margins, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  pieces <- splitter_a(data, margins)
  
  laply(pieces, fun, .try = .try, .quiet = .quiet, .explode = .explode, .progress = .progress)
}
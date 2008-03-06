uniquecols <- function(df) {
  col_is_unique <- function(x) is.discrete(x) && length(unique(x)) == 1
  df[1, sapply(df, col_is_unique), drop=FALSE]
}

piece_labels <- function(df, split.vars, include = c("split", "unique", "none")) {
  include <- match.arg(include)
  
  switch(include,
    unique = uniquecols(df),
    split = lapply(df[1, split.vars, drop=FALSE]),
    none = data.frame()
  )  
}

combine_labels <- function(res, labels) {
  if (is.null(res)) return(labels)
  if (is.vector(res)) res <- data.frame(res)
  
  labels <- labels[, setdiff(names(labels), names(res))]
  cbind(labels[rep(1, nrow(res)), ], res)
  
}

unrowname <- function(x) {
  rownames(x) <- NULL
  x
}

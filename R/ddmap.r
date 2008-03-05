# aggregate - per column, returns df
# ave - split on all factors, single column, returns numeric
# by - per subset, returns list
# summary - no split, compute summaries per column
# bystats
# mApply
# summarize
# smean.sd 

# When try used, should spit out informative warnings about where error occured (unless .quiet = TRUE)


failwith <- function(default = NULL, f, ...) {
  function(...) try_default(f(...), default)
}

colwise <- function(fun, ..., .try = FALSE, .if = function(x) TRUE) {
  f <- if (.try) failwith(NA, fun) else fun
  function(df) t(sapply(df[sapply(df, .if)], f, ...))
  # function(df) laply(df, f, ..., .filter = .if, .try = TRUE)
  
}
catcolwise <- function(fun, ..., .try = FALSE) {
  colwise(fun, ..., .try = .try, .if = is.factor)
}
numcolwise <- function(fun, ..., .try = FALSE) {
  colwise(fun, ..., .try = .try, .if = is.numeric)
}

is.discrete <- function(x) is.character(x) || is.factor(x)

uniquecols <- function(df) {
  col_is_unique <- function(x) is.discrete(x) && length(unique(x)) == 1
  df[1, sapply(df, col_is_unique), drop=FALSE]
}

piece_labels <- function(df, split.vars, include = c("split", "unique", "none")) {
  include <- match.arg(include)
  
  switch(include,
    unique = uniquecols(df),
    split = df[1, split.vars, drop=FALSE],
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

# fun has type too: dd, ld, xa, aa, etc

ddmap <- function(data, split.vars = NULL, fun, ..., .include = "
split", .try = FALSE) {
  f <- if (.try) failwith(NULL, fun) else fun
  g <- function(df, ...) {
    result <- f(df, ...)
    labels <- piece_labels(df, split.vars, .include)
    combine_labels(result, labels)
  }
  
  split <- interaction(data[split.vars], drop=TRUE)
  
  ldmap(split(data, split), g, ...)
}


dlmap <- function(data, split.vars = FALSE, fun, ..., .include = "split", .try= FALSE) {
  split <- interaction(data[split.vars], drop = TRUE)
  
  pieces <- split(data, split)
  labels <- ldmap(pieces, piece_labels, split.vars=split.vars)
  
  structure(
    llmap(pieces, fun, ..., .try = .try),
    labels = labels
  )
}

ldmap <- function(data, fun, ..., .try = FALSE) {
  f <- if (.try) failwith(NULL, fun) else fun

  res <- llmap(data, f, ..., .try = .try)
  resdf <- do.call(rbind.fill, res)
  
  # Use labels from dlmap, if avaiable
  labels <- attr(data, "labels")
  if (!is.null(labels) && nrow(labels) == length(data)) {
    rows <- unname(sapply(res, function(x) if(is.null(x)) 0 else nrow(x)))
    resdf <- cbind(labels[rep(1:nrow(labels), rows), , drop=FALSE], resdf)
  }

  unrowname(resdf)
}

llmap <- function(data, fun, ..., .try = FALSE) {
  f <- if (.try) failwith(NULL, fun) else fun
  
  # FIXME: needs to maintain labels
  lapply(data, f, ...)
}

# Also want to be able to easy do things like:
# subset bulls which have at least five from a given country
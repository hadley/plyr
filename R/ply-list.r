# To lists -------------------------------------------------------------------

llply <- function(data, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  data <- as.list(data)
  if (is.null(fun)) return(data)
  
  f <- robustify(fun, .try = .try, .quiet = .quiet, .explode = .explode)
  
  if (is.null(.progress))  .progress <- progress_null()

  .progress$init(length(data))
  f2 <- function(...) {
    res <- f(...)
    .progress$step()
    res
  }
  
  result <- lapply(data, f2, ...)
  mostattributes(result) <- attributes(data)
  .progress$term()
  
  result
}

dlply <- function(data, vars, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  data <- as.data.frame(data)
  pieces <- splitter_d(data, vars)
  
  llply(pieces, fun, .try = .try, .quiet = .quiet, .explode = .explode, .progress = .progress)
}

alply <- function(data, margins, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .explode = FALSE, .progress = NULL) {
  pieces <- splitter_a(data, margins)
  
  llply(pieces, fun, .try = .try, .quiet = .quiet, .explode = .explode, .progress = .progress)
}

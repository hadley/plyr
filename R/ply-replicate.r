rlply <- function(n., expr., progress. = "none") {
  f <- eval.parent(substitute(function(...) expr.))
  llply(seq_len(n.), f, progress. = progress.)
}
rdply <- function(n., expr., progress. = "none") {
  f <- eval.parent(substitute(function(...) expr.))
  ldply(seq_len(n.), f, progress. = progress.)
}
raply <- function(n., expr., progress. = "none") {
  f <- eval.parent(substitute(function(...) expr.))
  laply(seq_len(n.), f, progress. = progress.)
}
r_ply <- function(n., expr., progress. = "none") {
  f <- eval.parent(substitute(function(...) expr.))
  l_ply(seq_len(n.), f, progress. = progress.)
}
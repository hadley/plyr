source.with.err <- function(path) {
  tryCatch(source(path), error = function(x) {print(path); print(x)})
}
lapply(dir("~/documents/plyr/plyr/R", full.name=T), source.with.err)

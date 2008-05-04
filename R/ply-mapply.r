# Mapply equivalent ---------------------------------------------------------

mdply <- function(data, fun = NULL, ..., .progress = NULL) {
  f <- splat(fun)
  adply(data, margins = 1, f, ..., .progress = .progress)
}

maply <- function(data, fun = NULL, ..., .progress = NULL) {
  f <- splat(fun)
  aaply(data, margins = 1, f, ..., .progress = .progress)
}

mlply <- function(data, fun = NULL, ..., .progress = NULL) {
  f <- splat(fun)
  alply(data, margins = 1, f, ..., .progress = .progress)
}

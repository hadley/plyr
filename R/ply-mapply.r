# Mapply equivalent ---------------------------------------------------------

mdply <- function(data., fun. = NULL, ..., .progress = "none") {
  f <- splat(fun.)
  adply(data., margins. = 1, f, ..., .progress = .progress)
}

maply <- function(data., fun. = NULL, ..., .progress = "none") {
  f <- splat(fun.)
  aaply(data., margins. = 1, f, ..., .progress = .progress)
}

mlply <- function(data., fun. = NULL, ..., .progress = "none") {
  f <- splat(fun.)
  alply(data., margins. = 1, f, ..., .progress = .progress)
}

m_ply <- function(data., fun. = NULL, ..., .progress = "none") {
  f <- splat(fun.)
  a_ply(data., margins. = 1, f, ..., .progress = .progress)
}

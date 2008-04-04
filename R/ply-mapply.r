# Mapply equivalent ---------------------------------------------------------

# mapply(function(...) {}, a, b, c) -> mdply(cbind(a, b, c), 2, .explode=TRUE)
# mdply, mdlply, maply, m_ply -> axply(margins = 2, .explode = TRUE)

mdply <- function(data, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .progress = NULL) {
  adply(data, margins = 2, fun, ..., .try = .try, .quiet = .quiet, .explode = TRUE, .progress = .progress)
}

maply <- function(data, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .progress = NULL) {
  aaply(data, margins = 2, fun, ..., .try = .try, .quiet = .quiet, .explode = TRUE, .progress = .progress)
}

mlply <- function(data, fun = NULL, ..., .try = FALSE, .quiet = FALSE, .progress = NULL) {
  alply(data, margins = 2, fun, ..., .try = .try, .quiet = .quiet, .explode = TRUE, .progress = .progress)
}

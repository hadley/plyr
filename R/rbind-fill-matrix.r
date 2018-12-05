#' Bind matrices by row, and fill missing columns with NA.
#'
#' The matrices are bound together using their column names or the column
#' indices (in that order of precedence.) Numeric columns may be converted to
#' character beforehand, e.g. using format.  If a matrix doesn't have
#' colnames, the column number is used. Note that this means that a
#' column with name \code{"1"} is merged with the first column of a matrix
#' without name and so on. The returned matrix will always have column names.
#'
#' Vectors are converted to 1-column matrices.
#'
#' Matrices of factors are not supported. (They are anyways quite
#' inconvenient.) You may convert them first to either numeric or character
#' matrices. If a matrices of different types are merged, then normal
#' covnersion precendence will apply.
#'
#' Row names are ignored.
#'
#' @param ... the matrices to rbind. The first argument can be a list of
#'   matrices, in which case all other arguments are ignored.
#' @return a matrix with column names
#' @author C. Beleites
#' @seealso \code{\link[base]{rbind}}, \code{\link[base]{cbind}},
#'    \code{\link[plyr]{rbind.fill}}
#' @family binding functions
#' @export rbind.fill.matrix
#' @keywords manip
#' @examples
#' A <- matrix (1:4, 2)
#' B <- matrix (6:11, 2)
#' A
#' B
#' rbind.fill.matrix (A, B)
#'
#' colnames (A) <- c (3, 1)
#' A
#' rbind.fill.matrix (A, B)
#'
#' rbind.fill.matrix (A, 99)
rbind.fill.matrix <- function(...) {
  matrices <- list(...)
  if (length(matrices) == 0) return()
  if (is.list(matrices[[1]]) && !is.matrix(matrices[[1]])) {
    matrices <- matrices[[1]]
  }

  ## check the arguments
  tmp <- unlist(lapply(matrices, is.factor))
  if (any(tmp)) {
    stop("Input ", paste(which(tmp), collapse = ", "), " is a factor and ",
      "needs to be converted first to either numeric or character.")
  }

  matrices[] <- lapply(matrices, as.matrix)

  # Work out common column names
  lcols <- lapply(matrices, function(x) amv_dimnames(x)[[2]])
  cols  <- unique(unlist(lcols))

  # Calculate rows in output
  rows <- unlist(lapply(matrices, nrow))
  nrows <- sum(rows)

  # Generate output template
  output <- matrix(NA, nrow = nrows, ncol = length(cols))
  colnames(output) <- cols

  # Compute start and length for each matrix
  pos <- matrix(c(cumsum(rows) - rows + 1, rows), ncol = 2)

  ## fill in the new matrix
  for (i in seq_along(rows)) {
    rng <- seq(pos[i, 1], length.out = pos[i, 2])
    output[rng, lcols[[i]]] <- matrices[[i]]
  }

  output
}

#' Split a list of data frames, apply function, and return results in a data frame.
#'
#' For each subset of a data frame, apply function then combine results into a
#' data frame.
#'
#' @template ply
#' @template b-
#' @template -d
#' @seealso \code{\link{tapply}} for similar functionality in the base package
#' @export
bdply <- function(.data, .variables, .fun = NULL, ..., .progress = "none",
                  .inform = FALSE, .drop = TRUE, .parallel = FALSE,
                  .paropts = NULL) {
  if (empty(.data)) return(.data)
  .variables <- as.quoted(.variables)
  pieces <- splitter_b(.data, .variables, drop = .drop)

  ldply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)
}

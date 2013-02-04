#' Split data frame, apply function, and return results in a data frame.
#'
#' For each subset of a data frame, apply function then combine results into a
#' list of data frames.
#'
#' @template ply
#' @template d-
#' @template -b
#' @seealso \code{\link{tapply}} for similar functionality in the base package
#' @export
dbply <- function(.data, .variables, .fun = NULL, ..., .progress = "none",
                  .inform = FALSE, .drop = TRUE, .parallel = FALSE,
                  .paropts = NULL) {
  if (empty(.data)) return(.data)
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables, drop = .drop)

  lbply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)
}

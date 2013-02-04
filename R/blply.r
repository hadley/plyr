#' Split list of data frames (a data*b*ase), apply function, and return results in a list.
#'
#' Subsets each data frame in the list by the given variables, yielding a list of a list of sub-data frames
#' to which the function is applied and the results are returned in a list.
#' i.e. if a list of data frames all indexed by a common id is given, the, function is in turn applied
#' to a list of data frames where each of the data frames only contains data for a particular value of the id.
#' \code{blply} is a generalization of \code{\link{dlply}} except that the results
#' are returned in a different format.
#'
#' @template ply
#' @template b-
#' @template -l
#' @export
blply <- function(.data, .variables, .fun = NULL, ..., .progress = "none",
                  .inform = FALSE, .drop = TRUE, .parallel = FALSE,
                  .paropts = NULL) {
  .variables <- as.quoted(.variables)
  pieces <- splitter_b(.data, .variables, drop = .drop)

  llply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)
}

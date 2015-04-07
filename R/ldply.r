#' Split list, apply function, and return results in a data frame.
#'
#' For each element of a list, apply function then combine results into a data
#' frame.
#'
#' @template ply
#' @template l-
#' @template -d
#' @param .id name of the index column (used if \code{.data} is a named list).
#'   Pass \code{NULL} to avoid creation of the index column. For compatibility,
#'   omit this argument or pass \code{NA} to avoid converting the index column
#'   to a factor; in this case, \code{".id"} is used as colum name.
#' @export
ldply <- function(.data, .fun = NULL, ..., .progress = "none", .inform = FALSE,
                  .parallel = FALSE, .paropts = NULL, .id = NA) {
  if (!inherits(.data, "split")) .data <- as.list(.data)
  res <- llply(.data = .data, .fun = .fun, ...,
    .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)

  if (identical(.id, NA)) {
    .id <- ".id"
    id_as_factor <- FALSE
  } else {
    id_as_factor <- TRUE
  }
  list_to_dataframe(res, attr(.data, "split_labels"), .id, id_as_factor)
}

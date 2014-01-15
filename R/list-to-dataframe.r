#' List to data frame.
#'
#' Reduce/simplify a list of homogenous objects to a data frame. All
#' \code{NULL} entries are removed. Remaining entries must be all atomic
#' or all data frames.
#'
#' @family list simplification functions
#' @param res list of input data
#' @param labels a data frame of labels, one row for each element of res
#' @param idname the name of the index column, \code{NULL} for no index
#'   column
#' @keywords internal
list_to_dataframe <- function(res, labels = NULL, id_name = NULL, id_as_factor = FALSE) {
  null <- vapply(res, is.null, logical(1))
  res <- res[!null]
  if (length(res) == 0) return(data.frame())

  if (!is.null(labels)) {
    stopifnot(nrow(labels) == length(null))
    labels <- labels[!null, , drop = FALSE]
  }
  names_res <- names(res)
  if (!is.null(id_name) && is.null(labels) && !is.null(names_res)) {
    stopifnot(length(id_name) == 1)
    if (id_as_factor)
      names_res <- factor(names_res, levels = unique(names_res))
    labels <- data.frame(.id = names_res, stringsAsFactors = FALSE)
    names(labels) <- id_name
  }

  # Figure out how to turn elements into a data frame
  atomic <- unlist(lapply(res, is.atomic))
  df <- unlist(lapply(res, is.data.frame))
  mat <- unlist(lapply(res, is.matrix))

  if (all(mat)) {
    resdf <- as.data.frame(rbind.fill.matrix(res))
    rows <- unlist(lapply(res, NROW))
  } else if (all(atomic)) {
    nrow <- length(res)
    ncol <- unique(unlist(lapply(res, length)))
    if (length(ncol) != 1) stop("Results do not have equal lengths")

    vec <- unname(do.call("c", res))

    resdf <- quickdf(unname(split(vec, rep(seq_len(ncol), nrow))))
    names(resdf) <- make_names(res[[1]], "V")

    rows <- rep(1, length(nrow))
  } else if (all(df)) {
    resdf <- rbind.fill(res)
    rows <- unlist(lapply(res, NROW))
  } else {
    stop("Results must be all atomic, or all data frames")
  }

  if(is.null(labels)) return(unrowname(resdf))

  # Add labels to results
  names(labels) <- make_names(labels, "X")

  cols <- setdiff(names(labels), names(resdf))
  labels <- labels[rep(1:nrow(labels), rows), cols, drop = FALSE]

  unrowname(cbind(labels, resdf))
}

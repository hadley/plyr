#' List to data frame.
#' Reduce/simplify a list of homogenous objects to a data frame.
#' All \code{NULL} entries are removed. Remaining entries must be all atomic
#' or all data frames.
#' 
#' 
#' @param res list of input data
#' @param labels a data frame of labels, one row for each element of res
#' @keywords internal
list_to_dataframe <- function(res, labels = NULL) {
  null <- vapply(res, is.null, logical(1))
  res <- res[!null]
  if (length(res) == 0) return(data.frame())

  atomic <- unlist(lapply(res, is.atomic))
  df <- unlist(lapply(res, is.data.frame))

  if (all(atomic)) {
    ulength <- unique(unlist(lapply(res, length)))
    if (length(ulength) != 1) stop("Results do not have equal lengths")
    
    if (length(res) > 1) {
      resdf <- as.data.frame(do.call("rbind", res), stringsAsFactors = FALSE)
    } else {
      resdf <- as.data.frame(res[[1]], stringsAsFactors = FALSE)
      resdf <- t(resdf) # since the dimnames are switched
    }
    rows <- rep(1, length(res))
  } else if (all(df)) {
    resdf <- rbind.fill(res)
    rows <- unlist(lapply(res, NROW))
  } else {
    stop("Results must be all atomic, or all data frames")
  }

  # If no labels supplied, use list names
  if (is.null(labels) && !is.null(names(res))) {
    labels <- data.frame(.id = names(res), stringsAsFactors = FALSE)
  }

  if (!is.null(labels) && nrow(labels) == length(null)) {
    missing_names <- names(labels) == ""
    names(labels)[missing_names] <- paste("X", seq_len(sum(missing_names)),
       sep = "")
    
    cols <- setdiff(names(labels), names(resdf))
    labels <- labels[!null, cols, drop = FALSE]
    resdf <- cbind(labels[rep(1:nrow(labels), rows), , drop = FALSE], resdf)
  }
  
  unrowname(resdf)
}


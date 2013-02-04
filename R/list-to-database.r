#' List to database (list of data frames).
#'
#' Reduce/simplify a list of list of homogenous objects to a list of data frame.
#' All \code{NULL} entries are removed. Remaining entries must be all atomic
#' or all data frames.
#'
#' @family list simplification functions
#' @param res list of input data
#' @param labels a data frame of labels, one row for each element of res
#' @keywords internal
list_to_database <- function(res, labels = NULL) {
  ## first, get rid of null return elements and adjust accordingly
  null <- vapply(res, is.null, logical(1))
  res <- res[!null]

  if(length(res) == 0) return(list())
  
  if (!is.null(labels)) {
    stopifnot(nrow(labels) == length(null))
    labels <- labels[!null, , drop = FALSE]
  }
  if (is.null(labels) && !is.null(names(res))) {
    labels <- data.frame(.id = names(res), stringsAsFactors = FALSE)
  }

  ## we have to figure out if the results are homogenous
  ## for that, first figure out the type and length of each item
  is_list <- vapply(res, is.list, logical(1))
  is_data_frame <- vapply(res, is.data.frame, logical(1))
  numItems <- vapply(res, length, numeric(1))

  if(all(is_list) & all(!is_data_frame) & length(unique(numItems))==1) { ## all ok
    ## check that the names in all items of the list are identical
    ## either the same have to be given in all of them or none in any of them
    tableNames <- names(res[[1]])
    names_equal <- vapply(res, function(x, ref) {setequal(names(x),ref)}, logical(1), ref=tableNames)
    if(!all(names_equal)) {
      stop("The names of the data frame returned by the function have to be the same")
    }
    if(is.null(tableNames)) {
      tableNames <- 1:(numItems[1]) # use numbers intead of names
    }

    out <- list()
    for(tableName in tableNames) {
      out[[tableName]] <- list_to_dataframe(lapply(res, function(x, tableName) {x[[tableName]]},
                                                   tableName=tableName), labels=labels)
    }
    return(out)
  }
  else if(all(is_data_frame)) {
    return(list(list_to_dataframe(res,labels))) # combine teh dataframe and return as a list with a data frame
  }
  else {
    stop("Return does not have a regular enough structure to be turned into a list of data frames")
  }
}

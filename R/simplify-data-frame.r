# List to data frame
# Reduce/simplify a list of homogenous objects to a data frame
# 
# @arguments list of input data
# @arguments a data frame of labels, one row for each element of res
# @keyword internal
list_to_dataframe <- function(res, labels = NULL) { 
  if (length(res) == 0) return(data.frame())
  
  atomic <- unlist(llply(res, is.atomic))
  if (all(atomic)) {
    ulength <- unique(unlist(llply(res, length)))
    if (length(ulength) != 1) stop("Results are not equal lengths")
    
    if (length(res) > 1) {
      resdf <- as.data.frame(do.call("rbind", res))
    } else {
      resdf <- data.frame(res[[1]])
    }
    rows <- rep(1, length(res))
  } else {
    l_ply(res, function(x) if(!is.null(x) & !is.data.frame(x)) stop("Not a data.frame!"))

    resdf <- rbind.fill(res)
    rows <- unlist(llply(res, function(x) if(is.null(x)) 0 else nrow(x)))
  }

  # If no labels supplied, use list names
  if (is.null(labels) && !is.null(names(res))) {
    labels <- data.frame(.id = names(res))
  }

  if (!is.null(labels) && nrow(labels) == length(res)) {
    cols <- setdiff(names(labels), names(resdf))
    resdf <- cbind(labels[rep(1:nrow(labels), rows), cols, drop=FALSE], resdf)
  }
  
  unrowname(resdf)
}


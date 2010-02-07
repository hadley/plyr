#' Combine vectors
#'
#' Works like \code{\link{c}} but does not drop attributes, thus making it
#' useful for factors and dates etc.  This function does not perform coercion
#' so all objects should be of the same type.
#' 
#' Zero length inputs are silently dropped.
#' 
#' @param ... set of vectors to combine
concat <- function(...) {
  vectors <- compact(list(...))
  
  if (is.list(vectors[[1]])) {
    vectors <- compact(vectors[[1]])
  }
  
  classes <- lapply(vectors, class)
  class <- unique(classes)
  if (length(class) > 1) {
    stop("All inputs not of the same class", call. = FALSE)
  }
  
  class(vectors) <- paste(class, "-list", sep = "")
  combine(vectors)
}

combine <- function(vectors) UseMethod("combine", vectors)

combine.default <- function(vectors) {
  do.call("c", vectors)
}
"combine.factor-list" <- function(vectors) { 
  levels <- unique(unlist(lapply(vectors, levels)))
  char <- unlist(lapply(vectors, as.character))
  
  factor(char, levels = levels)
}


# concat(factor("a"), factor("b"), factor(c("c", "b","a")), factor("d"))
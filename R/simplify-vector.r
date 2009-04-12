# List to vector
# Reduce/simplify a list of homogenous objects to a vector
# 
# @arguments list of input data
# @keyword internal
list_to_vector <- function(res) {
  if (length(res) == 0) return(vector())
  n <- length(res)
  
  atomic <- sapply(res, is.atomic)
  if (all(atomic)) {
    classes <- unique(lapply(res, class))
    if (length(classes) == 1) {
      res <- unlist(res)
    }
  } 

  res
}
# List to vector
# Reduce/simplify a list of homogenous objects to a vector
# 
# @arguments list of input data
# @keyword internal
list_to_vector <- function(res) {
  n <- length(res)
  if (n == 0) return(vector())
  if (n == 1) return(res[[1]])
  
  atomic <- sapply(res, is.atomic)
  if (all(atomic)) {
    classes <- unique(lapply(res, class))
    if (length(classes) == 1) {
      res <- unlist(res)
    }
  } 

  res
}
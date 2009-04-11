# Aggregate multiple functions into a single function
# Combine multiple functions to a single function returning a named vector of outputs
# 
# Each function should produce a single number as output
# 
# @arguments functions to combine
# @keyword manip
#X each(min, max)(1:10)
#X each(length, mean, var)(rnorm(100))
each <- function(...) {
  fnames <- laply(match.call()[-1], deparse)
  fs <- list(...)
  
  # Find function names and replace with function objects
  char <- laply(fs, is.character)
  fnames[char] <- fs[char]
  fs[char] <- llply(fs[char], match.fun)

  unames <- names(fs)
  if (is.null(unames)) unames <- fnames
  unames[unames == ""] <- fnames[unames == ""]
  
  n <- length(fs)
  proto <- NULL
  
  function(x, ...) {
    
    # Construct prtotype for output on first call
    if (is.null(proto)) {
      result <<- vector("list", length = n)
      names(result) <- unames
      
      for(i in 1:n) result[[i]] <- fs[[i]](x, ...)
      proto <<- list_to_vector(result)
    } else {
      for(i in 1:n) proto[[i]] <- fs[[i]](x, ...)      
    }
    proto
    
  }
}
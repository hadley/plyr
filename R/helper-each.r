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
  
  function(x, ...) {
    results <- vector("numeric", length=n)
    for(i in 1:n) results[[i]] <- fs[[i]](x, ...)
    names(results) <- unames
    results
  }
}
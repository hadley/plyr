# Replicate expression and return results in a list
# Evalulate expression n times then combine results into a list
# 
# This function runs an expression multiple times, and combines the 
# result into a list.  If there are no results, then this function will return
# a list of length 0  (\code{list()}). This function is equivalent to
# \code{\link{replicate}}, but will always return results as a list.
# 
# 
# @keyword manip
# @arguments number of times to evaluate the expression
# @arguments expression to evaluate
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value list of results
#
#X mods <- rlply(100, lm(y ~ x, data=data.frame(x=rnorm(100), y=rnorm(100))))
#X hist(laply(mods, function(x) summary(x)$r.squared))
rlply <- function(.n, .expr, .progress = "none") {
  if (is.function(.expr)) {
    f <- .expr
  } else {
    f <- eval.parent(substitute(function() .expr))    
  }

  progress <- create_progress_bar(.progress)  
  result <- vector("list", length = .n)

  progress$init(.n)
  for(i in seq_len(.n)) {
    result[[i]] <- f()
    progress$step()
  }
  progress$term()
  
  result
}

# Replicate expression and return results in a data frame
# Evalulate expression n times then combine results into a data frame
# 
# This function runs an expression multiple times, and combines the 
# result into a data frame.  If there are no results, then this function
# returns a data frame with zero rows and columns (\code{data.frame()}).
# This function is equivalent to \code{\link{replicate}}, but will always
# return results as a data frame.
# 
# 
# @keyword manip
# @arguments number of times to evaluate the expression
# @arguments expression to evaluate
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value a data frame
#X
#X rdply(20, mean(runif(100)))
#X rdply(20, each(mean, var)(runif(100)))
#X rdply(20, data.frame(x = runif(2)))
rdply <- function(.n, .expr, .progress = "none") {
  if (is.function(.expr)) {
    f <- .expr
  } else {
    f <- eval.parent(substitute(function() .expr))    
  }
  
  res <- rlply(.n = .n, .expr = f, .progress = .progress)
  labels <- data.frame(.n = seq_len(.n))
  list_to_dataframe(res, labels)
}


# Replicate expression and return results in a array
# Evalulate expression n times then combine results into an array
# 
# This function runs an expression multiple times, and combines the 
# result into a data frame.  If there are no results, then this function
# returns a vector of length 0 (\code{vector(0)}).
# This function is equivalent to \code{\link{replicate}}, but will always
# return results as a vector, matrix or array.
# 
# 
# @keyword manip
# @arguments number of times to evaluate the expression
# @arguments expression to evaluate
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#
#X raply(100, mean(runif(100)))
#X raply(100, each(mean, var)(runif(100)))
#X
#X raply(10, runif(4))
#X raply(10, matrix(runif(4), nrow=2))
#X 
#X # See the central limit theorem in action
#X hist(raply(1000, mean(rexp(10))))
#X hist(raply(1000, mean(rexp(100))))
#X hist(raply(1000, mean(rexp(1000))))
raply <- function(.n, .expr, .progress = "none", .drop = TRUE) {
  if (is.function(.expr)) {
    f <- .expr
  } else {
    f <- eval.parent(substitute(function() .expr))    
  }
  
  res <- rlply(.n = .n, .expr = f, .progress = .progress)
  list_to_array(res, NULL, .drop)
}

# Replicate expression and discard results
# Evalulate expression n times then discard results
# 
# This function runs an expression multiple times, discarding the results. 
# This function is equivalent to \code{\link{replicate}}, but never returns
# anything
# 
# 
# @keyword manip
# @arguments number of times to evaluate the expression
# @arguments expression to evaluate
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @argument automatically print each result? (default: \code{FALSE})
# 
#X r_ply(10, plot(runif(50)))
#X r_ply(25, hist(runif(1000)))
r_ply <- function(.n, .expr, .progress = "none", .print = FALSE) {
  if (is.function(.expr)) {
    f <- .expr
  } else {
    f <- eval.parent(substitute(function() .expr))    
  }

  progress <- create_progress_bar(.progress)  

  progress$init(.n)
  for(i in seq_len(.n)) {
    f()
    progress$step()
  }
  progress$term()

  invisible()
}
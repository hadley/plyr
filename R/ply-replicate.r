# Replicate expression and return results in a list
# Evalulate expression n times then combine results into a list
# 
# This function runs an expression multiple times, and combines the 
# result into a list.  If there are no results, then this function will return
# a list of length 0  (\code{list()}). This function is equivalent to
# \code{\link{replicate}}, but will always return results as a list.
# 
# See \code{vignette("intro", "plyr")} for more details, description and case
# studies.
# 
# @keyword manip
# @arguments number of times to evaluate the expression
# @arguments expression to evaluation
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value list of results
#
#X mods <- rlply(100, lm(y ~ x, data=data.frame(x=rnorm(100), y=rnorm(100))))
#X hist(laply(mods, function(x) summary(x)$r.squared))
rlply <- function(n., expr., progress. = "none") {
  f <- eval.parent(substitute(function(...) expr.))
  llply(seq_len(n.), f, progress. = progress.)
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
# See \code{vignette("intro", "plyr")} for more details, description and case
# studies.
# 
# @keyword manip
# @arguments number of times to evaluate the expression
# @arguments expression to evaluation
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @value a data frame
#X
#X rdply(20, mean(runif(100)))
#X rdply(20, each(mean, var)(runif(100)))
rdply <- function(n., expr., progress. = "none") {
  f <- eval.parent(substitute(function(...) expr.))
  ldply(seq_len(n.), f, progress. = progress.)
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
# See \code{vignette("intro", "plyr")} for more details, description and case
# studies.
# 
# @keyword manip
# @arguments number of times to evaluate the expression
# @arguments expression to evaluation
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
raply <- function(n., expr., progress. = "none") {
  f <- eval.parent(substitute(function(...) expr.))
  laply(seq_len(n.), f, progress. = progress.)
}

# Replicate expression and discard results
# Evalulate expression n times then discard results
# 
# This function runs an expression multiple times, discarding the results. 
# This function is equivalent to \code{\link{replicate}}, but never returns
# anything
# 
# See \code{vignette("intro", "plyr")} for more details, description and case
# studies.
# 
# @keyword manip
# @arguments number of times to evaluate the expression
# @arguments expression to evaluation
# @arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
# @argument automatically print each result? (default: \code{FALSE})
# 
#X r_ply(10, plot(runif(50)))
r_ply <- function(n., expr., progress. = "none", print. = FALSE) {
  f <- eval.parent(substitute(function(...) expr.))
  l_ply(seq_len(n.), f, progress. = progress., print. = print.)
}
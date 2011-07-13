#' Replicate expression and return results in a list.
#'
#' Evalulate expression n times then combine results into a list
#' 
#' This function runs an expression multiple times, and combines the 
#' result into a list.  If there are no results, then this function will return
#' a list of length 0  (\code{list()}). This function is equivalent to
#' \code{\link{replicate}}, but will always return results as a list.
#' 
#' 
#' @keywords manip
#' @param .n number of times to evaluate the expression
#' @param .expr expression to evaluate
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @return list of results
#' @export
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy for
#'   Data Analysis. Journal of Statistical Software, 40(1), 1-29. 
#'   \url{http://www.jstatsoft.org/v40/i01/}.
#' @examples
#' mods <- rlply(100, lm(y ~ x, data=data.frame(x=rnorm(100), y=rnorm(100))))
#' hist(laply(mods, function(x) summary(x)$r.squared))
rlply <- function(.n, .expr, .progress = "none") {
  if (is.function(.expr)) {
    f <- .expr
  } else {
    f <- eval.parent(substitute(function() .expr))    
  }

  progress <- create_progress_bar(.progress)  
  result <- vector("list", length = .n)

  progress$init(.n)
  on.exit(progress$term())

  for(i in seq_len(.n)) {
    result[i] <- list(f())
    progress$step()
  }
  
  result
}

#' Replicate expression and return results in a data frame.
#'
#' Evalulate expression n times then combine results into a data frame
#' 
#' This function runs an expression multiple times, and combines the 
#' result into a data frame.  If there are no results, then this function
#' returns a data frame with zero rows and columns (\code{data.frame()}).
#' This function is equivalent to \code{\link{replicate}}, but will always
#' return results as a data frame.
#' 
#' 
#' @keywords manip
#' @param .n number of times to evaluate the expression
#' @param .expr expression to evaluate
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @return a data frame
#' @export
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy for
#'   Data Analysis. Journal of Statistical Software, 40(1), 1-29. 
#'   \url{http://www.jstatsoft.org/v40/i01/}.
#' @examples
#' rdply(20, mean(runif(100)))
#' rdply(20, each(mean, var)(runif(100)))
#' rdply(20, data.frame(x = runif(2)))
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


#' Replicate expression and return results in a array.
#'
#' Evalulate expression n times then combine results into an array
#' 
#' This function runs an expression multiple times, and combines the 
#' result into a data frame.  If there are no results, then this function
#' returns a vector of length 0 (\code{vector(0)}).
#' This function is equivalent to \code{\link{replicate}}, but will always
#' return results as a vector, matrix or array.
#' 
#' @keywords manip
#' @param .n number of times to evaluate the expression
#' @param .expr expression to evaluate
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @return if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
#' @param .drop should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
#' @export
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy for
#'   Data Analysis. Journal of Statistical Software, 40(1), 1-29. 
#'   \url{http://www.jstatsoft.org/v40/i01/}.
#' @examples
#' raply(100, mean(runif(100)))
#' raply(100, each(mean, var)(runif(100)))
#'
#' raply(10, runif(4))
#' raply(10, matrix(runif(4), nrow=2))
#' 
#' # See the central limit theorem in action
#' hist(raply(1000, mean(rexp(10))))
#' hist(raply(1000, mean(rexp(100))))
#' hist(raply(1000, mean(rexp(1000))))
raply <- function(.n, .expr, .progress = "none", .drop = TRUE) {
  if (is.function(.expr)) {
    f <- .expr
  } else {
    f <- eval.parent(substitute(function() .expr))    
  }
  
  res <- rlply(.n = .n, .expr = f, .progress = .progress)
  list_to_array(res, NULL, .drop)
}

#' Replicate expression and discard results.
#'
#' Evalulate expression n times then discard results
#' 
#' This function runs an expression multiple times, discarding the results. 
#' This function is equivalent to \code{\link{replicate}}, but never returns
#' anything
#' 
#' @keywords manip
#' @param .n number of times to evaluate the expression
#' @param .expr expression to evaluate
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @param .print automatically print each result? (default: \code{FALSE})
#' @export
#' @references Hadley Wickham (2011). The Split-Apply-Combine Strategy for
#'   Data Analysis. Journal of Statistical Software, 40(1), 1-29. 
#'   \url{http://www.jstatsoft.org/v40/i01/}.
#' @examples
#' r_ply(10, plot(runif(50)))
#' r_ply(25, hist(runif(1000)))
r_ply <- function(.n, .expr, .progress = "none", .print = FALSE) {
  if (is.function(.expr)) {
    f <- .expr
  } else {
    f <- eval.parent(substitute(function() .expr))    
  }

  progress <- create_progress_bar(.progress)  

  progress$init(.n)
  on.exit(progress$term())

  for(i in seq_len(.n)) {
    f()
    progress$step()
  }
  progress$term()
}
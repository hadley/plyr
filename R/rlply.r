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
  res <- .rlply_worker(.n, .progress,
                       eval.parent(substitute(function() .expr)))
  res
}

.rlply_worker <- function(.n, .progress, .expr_wrap, .print = FALSE,
                          .discard = FALSE) {
  if (!is.vector(.n, "numeric") || length(.n) > 1L)
    stop(".n must be an integer vector of length 1")
  if (.n == 0L)
    return (list())

  progress <- create_progress_bar(.progress)

  progress$init(.n)
  on.exit(progress$term())

  if (.print) {
    wrap <- function(f) function() {
      print(f())
    }
  } else {
    wrap <- identity
  }

  # The logic below is responsible for ascertaining that .expr is evaluated
  # exactly .n times, whether it's a function or an expression.  (See GitHub
  # issue #158.)  When the function .rlply_worker is called, the .expr_wrap
  # argument is a function that returns the .expr argument passed to the calling
  # r*ply function.  The .wrapped_expr_to_fun function will convert the
  # .expr_wrap argument to a list that contains a function and the result of the
  # first evaluation, which is necessary because there seems to be no other way
  # to find out if .expr is a function or an expression without evaluating it at
  # least once.  After that, only .n - 1 further evaluations are necessary.
  #
  # In addition, results are printed and/or discareded depending on the `wrap`
  # function defined above.
  fun <- .wrapped_expr_to_fun(.expr_wrap)
  f <- wrap(fun$f)

  if (.discard) {
    wrap(function() fun$val)()
    progress$step()

    for (i in seq.int(from = 2L, length.out = .n - 1L)) {
      f()
      progress$step()
    }

    invisible(NULL)
  } else {
    result <- vector("list", length = .n)
    result[1L] <- list(wrap(function() fun$val)())
    progress$step()

    for (i in seq.int(from = 2L, length.out = .n - 1L)) {
      result[i] <- list(f())
      progress$step()
    }

    result
  }
}

#' r*ply helper function
#'
#' Call a function to check if the result is a function or an expression, to
#' support expressions as arguments to the r*ply family.
#'
#' @param .expr_wrap function to call
#' @return named list with two components. f -- function, val -- result of first
#'   evaluation
#' @noRd
.wrapped_expr_to_fun <- function(.expr_wrap) {
  # When .expr_wrap is evaluated, it will return either a function or an
  # expression.  In the first case, this function is assigned to the f
  # component, and also called once explicitly to assign the val component.  In
  # the second case, this has been already the first evaluation of .expr -- the
  # parameter wrapped by .expr_wrap; the results are reused for the val
  # component, and the wrapped function is assigned to f.
  res <- .expr_wrap()

  if (is.function(res)) {
    list(f = res, val = res())
  } else {
    list(f = .expr_wrap, val = res)
  }
}

#' Aggregate multiple functions into a single function.
#'
#' Combine multiple functions into a single function returning a named vector
#' of outputs.
#' Note: you cannot supply additional parameters for the summary functions
#'
#' @param ... functions to combine. each function should produce a single
#'    number as output
#' @keywords manip
#' @seealso \code{\link{summarise}} for applying summary functions to data
#' @export
#' @examples
#' # Call min() and max() on the vector 1:10
#' each(min, max)(1:10)
#' # This syntax looks a little different.  It is shorthand for the
#' # the following:
#' f<- each(min, max)
#' f(1:10)
#' # Three equivalent ways to call min() and max() on the vector 1:10
#' each("min", "max")(1:10)
#' each(c("min", "max"))(1:10)
#' each(c(min, max))(1:10)
#' # Call length(), min() and max() on a random normal vector
#' each(length, mean, var)(rnorm(100))
each <- function(...) {
  fnames <- laply(match.call()[-1], deparse)
  fs <- list(...)
  if (length(fs[[1]]) > 1) {
    fs <- fs[[1]]

    # Jump through hoops to work out names
    snames <- as.list(match.call()[2])[[1]]
    fnames <- unlist(lapply(as.list(snames)[-1], deparse))
  }

  # Find function names and replace with function objects
  char <- laply(fs, is.character)
  fnames[char] <- fs[char]
  fs[char] <- llply(fs[char], match.fun)

  unames <- names(fs)
  if (is.null(unames)) unames <- fnames
  unames[unames == ""] <- fnames[unames == ""]

  n <- length(fs)

  if (n == 1) {
    # If there is only one function, things are simple.  We just
    # need to name the output, if appropriate.
    function(x, ...) {
      res <- fs[[1]](x, ...) # nolint
      if (length(res) == 1) names(res) <- unames
      res
    }
  } else {
    # nolint start
    proto <- NULL
    result <- NULL
    # nolint end

    function(x, ...) {
      # For n > 1 things are a little tricky
      # Construct protoype for output on first call
      if (is.null(proto)) {
        result <<- vector("list", length = n)
        names(result) <- unames

        for (i in 1:n) result[[i]] <- fs[[i]](x, ...) # nolint
        proto <<- list_to_vector(result)
      } else {
        for (i in 1:n) proto[[i]] <- fs[[i]](x, ...) # nolint
      }
      proto
    }
  }
}

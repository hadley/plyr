#' Count the number of occurences.
#' Equivalent to \code{as.data.frame(table(x))}, but does not include
#' combinations with zero counts.
#'
#' Count is speed competitive with \code{\link{table}} for single variables,
#' but it really comes into its own when summarising multiple dimensions that
#' are not crossed. 
#'
#' @param df data frame to be processed
#' @param vars variables to count unique values of
#' @return a data frame with label and freq columns
#' @keywords manip
#' @export
#' @examples
#' count(baseball, "id")
#' count(baseball, "lg")
#' count(baseball, "stint")
#' count(count(baseball, c("id", "year")), "freq")
count <- function(df, vars = NULL) {
  if (is.vector(df)) {
    df <- data.frame(x = df)
  }
  
  if (!is.null(vars)) {
    vars <- as.quoted(vars)
    df <- quickdf(eval.quoted(vars, df))
  }

  id <- ninteraction(df, drop = TRUE)

  u_id <- !duplicated(id)
  labels <- df[u_id, , drop = FALSE]
  labels <- labels[order(id[u_id]), , drop = FALSE]
  freq <- tabulate(id, attr(id, "n"))
  
  unrowname(data.frame(labels, freq))
}
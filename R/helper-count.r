#' Count the number of occurences
#' 
#' Does not include levels with zero counts.
#' @param data data frame to be processed
#' @param variables variables to count unique values of
#' @value a data frame with label and freq columns
#' @examples
#' count(baseball, "id")
#' count(baseball, "lg")
#' count(baseball, "stint")
#' count(count(baseball, c("id", "year")), "freq")
count <- function(df, vars = NULL, drop = TRUE) {
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
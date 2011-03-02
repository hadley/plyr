#' Count the number of occurences.
#'
#' Equivalent to \code{as.data.frame(table(x))}, but does not include
#' combinations with zero counts.
#'
#' Speed-wise count is competitive with \code{\link{table}} for single
#' variables, but it really comes into its own when summarising multiple
#' dimensions because it only counts combinations that actually occur in the
#' data.
#'
#' Compared to \code{\link{table}} + \code{\link{as.data.frame}}, \code{count}
#' also preserves the type of the identifier variables, instead of converting
#' them to characters/factors.
#'
#' @param df data frame to be processed
#' @param vars variables to count unique values of
#' @param wt_var optional variable to weight by - if this is non-NULL, count
#'   will sum up the value of this variable for each combination of id
#'   variables.
#' @return a data frame with label and freq columns
#' @keywords manip
#' @export
#' @examples
#' count(baseball, "id")
#' count(baseball, "id", "g")
#' count(baseball, "id", "ab")
#' count(baseball, "lg")
#' count(baseball, "stint")
#' count(count(baseball, c("id", "year")), "id", "freq")
#' count(count(baseball, c("id", "year")), "freq")
count <- function(df, vars = NULL, wt_var = NULL) {
  if (is.vector(df)) {
    df <- data.frame(x = df)
  }
  
  if (!is.null(vars)) {
    vars <- as.quoted(vars)
    df2 <- quickdf(eval.quoted(vars, df))
  } else {
    df2 <- df
  }
  
  id <- ninteraction(df2, drop = TRUE)
  u_id <- !duplicated(id)
  labels <- df2[u_id, , drop = FALSE]
  labels <- labels[order(id[u_id]), , drop = FALSE]
  
  if (is.null(wt_var) && "freq" %in% names(df)) {
    message("Using freq as weighting variable")
    wt_var <- "freq"
  }
  
  if (!is.null(wt_var)) {
    wt_var <- as.quoted(wt_var)
    if (length(wt_var) > 1) {
      stop("wt_var must be a single variable", call. = FALSE)
    }
    
    wt <- eval.quoted(wt_var, df)[[1]]
    freq <- vaggregate(wt, id, sum, .default = 0)
  } else {
    freq <- tabulate(id, attr(id, "n"))    
  }
  
  unrowname(data.frame(labels, freq))
}
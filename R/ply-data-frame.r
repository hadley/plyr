#' Split list, apply function, and return results in a data frame.
#'
#' For each element of a list, apply function then combine results into a data
#' frame.
#'
#' @template ply
#' @template l-
#' @template -d
#' @export
ldply <- function(.data, .fun = NULL, ..., .progress = "none", .parallel = FALSE) {
  if (!inherits(.data, "split")) .data <- as.list(.data)
  res <- llply(.data = .data, .fun = .fun, ...,
    .progress = .progress, .parallel = .parallel)

  list_to_dataframe(res, attr(.data, "split_labels"))
}

#' Split data frame, apply function, and return results in a data frame.
#'
#' For each subset of a data frame, apply function then combine results into a
#' data frame.
#'
#' @template ply
#' @template d-
#' @template -d
#' @seealso \code{\link{tapply}} for similar functionality in the base package
#' @export
#' @examples
#' # Summarize a dataset by two variables
#' require(plyr)
#' group <- c(rep('A', 8), rep('B', 15), rep('C', 6))
#' sex   <- sample(c("M", "F"), size = 29, replace = TRUE)
#' age   <- runif(n = 29, min = 18, max = 54)
#' dfx   <- data.frame (group, time, age)
#'
#' # Note the use of the '.' function to allow
#' # group and sex to be used without quoting
#' ddply(dfx, .(group, sex), summarize,
#' 	mean <- round(mean(age), 2),
#' 	sd   <- round(sd(age), 2))
#'
#' #   group sex  mean    sd
#' # 1     A   F 35.89  8.53
#' # 2     A   M 38.01 15.09
#' # 3     B   F 39.08 10.79
#' # 4     B   M 37.38  9.55
#' # 5     C   F 30.01    NA
#' # 6     C   M 34.78 11.50
#'
#' # An example using a formula for .variables
#' ddply(baseball[1:100,], .variables = ~year, .fun=nrow)
#' # Applying two functions; nrow and ncol
#' ddply(baseball, .(lg), c("nrow", "mean"))
#'
#' # Calculate mean runs batted in for each year
#' rbi <- ddply(baseball, .(year), summarise,
#'   mean_rbi = mean(rbi, na.rm = TRUE))
#' # Plot a line chart of the result
#' plot(mean_rbi ~year, type = "l", data = rbi))
#'
#' # make new variable career_year based on the
#' # start year for each player (id)
#' base2 <- ddply(baseball, .(id), transform,
#'  career_year = year - min(year) + 1
#' )
ddply <- function(.data, .variables, .fun = NULL, ..., .progress = "none", .drop = TRUE, .parallel = FALSE) {
  if (empty(.data)) return(.data)
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables, drop = .drop)

  ldply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .parallel = .parallel)
}

#' Split array, apply function, and return results in a data frame.
#'
#' For each slice of an array, apply function then combine results into a data
#' frame.
#'
#' @template ply
#' @template a-
#' @template -d
#' @export
adply <- function(.data, .margins, .fun = NULL, ..., .expand = TRUE, .progress = "none", .parallel = FALSE) {
  pieces <- splitter_a(.data, .margins, .expand)

  ldply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .parallel = .parallel)
}

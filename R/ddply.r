#' Split data frame, apply function, and return results in a data frame.
#'
#' For each subset of a data frame, apply function then combine results into a
#' data frame.
#' To apply a function for each row, use \code{\link{adply}} with
#' \code{.margins} set to \code{1}.
#'
#' @template ply
#' @template d-
#' @template -d
#' @seealso \code{\link{tapply}} for similar functionality in the base package
#' @export
#' @examples
#' # Summarize a dataset by two variables
#' dfx <- data.frame(
#'   group = c(rep('A', 8), rep('B', 15), rep('C', 6)),
#'   sex = sample(c("M", "F"), size = 29, replace = TRUE),
#'   age = runif(n = 29, min = 18, max = 54)
#' )
#'
#' # Note the use of the '.' function to allow
#' # group and sex to be used without quoting
#' ddply(dfx, .(group, sex), summarize,
#'  mean = round(mean(age), 2),
#'  sd = round(sd(age), 2))
#'
#' # An example using a formula for .variables
#' ddply(baseball[1:100,], ~ year, nrow)
#' # Applying two functions; nrow and ncol
#' ddply(baseball, .(lg), c("nrow", "ncol"))
#'
#' # Calculate mean runs batted in for each year
#' rbi <- ddply(baseball, .(year), summarise,
#'   mean_rbi = mean(rbi, na.rm = TRUE))
#' # Plot a line chart of the result
#' plot(mean_rbi ~ year, type = "l", data = rbi)
#'
#' # make new variable career_year based on the
#' # start year for each player (id)
#' base2 <- ddply(baseball, .(id), mutate,
#'  career_year = year - min(year) + 1
#' )
ddply <- function(.data, .variables, .fun = NULL, ..., .progress = "none",
                  .inform = FALSE, .drop = TRUE, .parallel = FALSE,
                  .paropts = NULL) {
  if (empty(.data)) return(.data)
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables, drop = .drop)

  ldply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)
}

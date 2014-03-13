#' Split data frame, apply function, and return results in a list.
#'
#' For each subset of a data frame, apply function then combine results into a
#' list. \code{dlply} is similar to \code{\link{by}} except that the results
#' are returned in a different format.
#' To apply a function for each row, use \code{\link{alply}} with
#' \code{.margins} set to \code{1}.
#'
#' @template ply
#' @template d-
#' @template -l
#' @export
#' @examples
#' linmod <- function(df) {
#'   lm(rbi ~ year, data = mutate(df, year = year - min(year)))
#' }
#' models <- dlply(baseball, .(id), linmod)
#' models[[1]]
#'
#' coef <- ldply(models, coef)
#' with(coef, plot(`(Intercept)`, year))
#' qual <- laply(models, function(mod) summary(mod)$r.squared)
#' hist(qual)
dlply <- function(.data, .variables, .fun = NULL, ..., .progress = "none",
                  .inform = FALSE, .drop = TRUE, .parallel = FALSE,
                  .paropts = NULL) {
  .variables <- as.quoted(.variables)
  pieces <- splitter_d(.data, .variables, drop = .drop)

  llply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)
}

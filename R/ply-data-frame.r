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
#' @export
#' @examples
#' ddply(baseball, .(year), "nrow") 
#' ddply(baseball, .(lg), c("nrow", "ncol")) 
#' 
#' rbi <- ddply(baseball, .(year), summarise, 
#'   mean_rbi = mean(rbi, na.rm = TRUE))
#' with(rbi, plot(year, mean_rbi, type="l"))
#'
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

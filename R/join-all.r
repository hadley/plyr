#' Recursively join a list of data frames.
#'
#' @param dfs A list of data frames.
#' @inheritParams join
#' @export
#' @examples
#' dfs <- list(
#'   a = data.frame(x = 1:10, a = runif(10)),
#'   b = data.frame(x = 1:10, b = runif(10)),
#'   c = data.frame(x = 1:10, c = runif(10))
#' )
#' join_all(dfs)
#' join_all(dfs, "x")
join_all <- function(dfs, by = NULL, type = "left", match = "all") {
  if (length(dfs) == 1) return(dfs[[1]])

  joined <- dfs[[1]]
  for (i in 2:length(dfs)) {
    joined <- join(joined, dfs[[i]], by = by, type = type, match = match)
  }

  joined
}

as.list.split <- function(x) {
  attr(x, "split_type") <- NULL
  attr(x, "split_labels") <- NULL
  class(x) <- setdiff(class(x), "split")
  x
}
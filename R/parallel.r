setup_parallel <- function() {
  if (!requireNamespace("foreach", quietly = TRUE)) {
    stop("foreach package required for parallel plyr operation",
      call. = FALSE)
  }
  if (foreach::getDoParWorkers() == 1) {
    warning("No parallel backend registered", call. = TRUE)
  }
}

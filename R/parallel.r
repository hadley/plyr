setup_parallel <- function() {
  if (!require("foreach")) {
    stop("foreach package required for parallel plyr operation",
      call. = FALSE)
  }
  if (getDoParWorkers() == 1) {
    warning("No parallel backend registered", call. = TRUE)
  }
}

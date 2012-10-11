setup_parallel <- function() {
  if (!require("foreach")) {
    stop("foreach package required for parallel plyr operation",
      call. = FALSE)
  }
  if (getDoParWorkers() == 1) {
    warning("No parallel backend registered", call. = TRUE)
  }
}

parallel_fe <- function(n, options) {
  i <- seq_len(n)
  fe_call <- as.call(c(list(as.name("foreach"), i = i), options))

  eval(fe_call)
}

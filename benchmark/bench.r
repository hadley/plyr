# benchmarking <- FALSE
bench <- function(name, expr) {
  dur <- system.time(expr)
  if (!is_benchmarking()) {
    return(dur)
  }

  out <- data.frame(
    file = .bench_path,
    name = name,
    time = Sys.time(),
    sha = git_sha(),
    signif(t(as.matrix(dur)[1:3, 1]))
  )
  append <- file.exists("timings.csv")
  write.table(out, "timings.csv", sep = ",", row = FALSE, append = append,
    col = !append)
}

git_sha <- function() {
  strsplit(system("git log -1 --oneline", intern=T), " ")[[1]][1]
}

benchmark <- function(path) {
  .bench_path <<- path
  on.exit(.bench_path <<- NULL)

  source(path, chdir = TRUE)
}

.bench_path <- NULL
is_benchmarking <- function() {
  !is.null(.bench_path)
}

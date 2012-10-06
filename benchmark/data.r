# Generate sample data sets for benchmarking
options(stringsAsFactors = FALSE)

make_data <- function(n) {
  data.frame(
    unif = runif(n),
    norm = rnorm(n),
    char = sample(letters, n, rep = T),
    factor = factor(sample(letters, n, rep = T)),
    group_a = rep(1:100, length = n),
    group_b = rep(1:1000, length = n),
    group_c = rep(1:10000, length = n)
  )
}

bench4 <- make_data(10 ^ 4)
bench5 <- make_data(10 ^ 5)
bench6 <- make_data(10 ^ 6)

save(bench4, bench5, bench6, file = "benchmark.rdata")

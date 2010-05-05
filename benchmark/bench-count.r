if (!exists("bench6")) load("benchmark.rdata")


tabdf <- function(x) as.data.frame(table(x))

bench("tabdf-6-a", tabdf(bench6["group_a"]))
bench("count-6-a", count(bench6["group_a"]))

bench("tabdf-6-ab", tabdf(bench6[c("group_a", "group_b")]))
bench("count-6-ab", count(bench6[c("group_a", "group_b")]))

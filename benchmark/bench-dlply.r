if (!exists("bench6")) load("benchmark.rdata")

bench("6-a", dlply(bench6, .(group_a), nrow))
bench("6-b", dlply(bench6, .(group_b), nrow))

ibench6 <- idata.frame(bench6)
bench("6i-a", dlply(ibench6, .(group_a), nrow))
bench("6i-b", dlply(ibench6, .(group_b), nrow))
bench("6i-c", dlply(ibench6, .(group_c), nrow))

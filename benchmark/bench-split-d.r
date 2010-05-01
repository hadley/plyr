if (!exists("bench6")) load("benchmark.rdata")


bench("6-num", splitter_d(bench6, .(group_c)))
bench("6-chr", splitter_d(bench6, .(char)))
bench("6-fac", splitter_d(bench6, .(factor)))
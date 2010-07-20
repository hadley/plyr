# Benchmark llply, the key processing function


seq_5 <- seq_len(1e5)
seq_6 <- seq_len(1e6)

bench("1e5", llply(seq_5, function(x) x ^ 2))
bench("1e6", llply(seq_6, function(x) x ^ 2))
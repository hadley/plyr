library(microbenchmark)

df <- data.frame(x = sample(100), y = sample(100))
ar <- array(sample(200), c(100, 2))

# # Motivating problem:
# system.time(alply(ar, 1))
# #  user  system elapsed
# # 0.024   0.007   0.031
# system.time(alply(df, 1))
# #  user  system elapsed
# # 0.030   0.007   0.037
# system.time(split(df, 1:nrow(df)))
# #  user  system elapsed
# # 0.004   0.001   0.004

# Construct call by parsing string
extract1 <- function(x, i) {
  i <- paste(unlist(lapply(i, as.character)), collapse = ", ")
  call <- paste("x", "[", i, ", drop = ", FALSE, "]", sep = "")
  eval(parse(text = call))
}

# Construct call by hand
extract2 <- function(x, i) {
  call <- as.call(c(
    list(as.name("["), quote(x)), i, list(drop = FALSE)))
  eval(call)
}

# Use .subset directly
extract3 <- function(x, i) {

  # ???
}

if (FALSE) {
  # Which is faster? Parsing or constructing call?
  microbenchmark(
    extract1(df, list(20, T)),
    extract2(df, list(20, T)),
    extract1(ar, list(20, T)),
    extract2(ar, list(20, T))
  )

  # Compare to doing it directly?
  microbenchmark(
    extract2(df, list(20, T)),
    df[20, , drop = FALSE],
    extract2(ar, list(20, T)),
    ar[20, , drop = FALSE]
  )

  # Which is faster? TRUE or missing argument
  microbenchmark(
    extract2(df, list(20, T)),
    extract2(df, list(20, bquote())),
    extract2(ar, list(20, T)),
    extract2(ar, list(20, bquote()))
  )

}

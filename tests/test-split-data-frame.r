context("Split data frame")

df <- data.frame(x = factor(1:10), y = letters[1:10])

test_that("correct order is used", {
  expect_that(ddply(df, .(x), .drop = F), equals(df))
  expect_that(ddply(df, .(x), .drop = T), equals(df))
})
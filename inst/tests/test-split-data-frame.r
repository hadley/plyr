context("Split data frame")


test_that("correct order is used", {
  df <- data.frame(x = factor(1:10), y = letters[1:10])

  expect_that(ddply(df, .(x), .drop = FALSE), equals(df))
  expect_that(ddply(df, .(x), .drop = TRUE), equals(df))
})

test_that("factor levels are preserved", {
  df <- data.frame(a = factor(1:4, levels = 1:5), x = runif(4))

  out1 <- ddply(df, "a", strip_splits, .drop = TRUE)
  out2 <- ddply(df, "a", strip_splits, .drop = FALSE)

  expect_is(out1$a, "factor")
  expect_is(out2$a, "factor")

  expect_equal(levels(out1$a), levels(df$a))
  expect_equal(levels(out2$a), levels(df$a))
})

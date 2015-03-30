context("quickdf")

test_that("make_names handles NAs", {
  x <- 1:3
  names(x) <- c("", "a", NA)
  expect_equal(make_names(x), c("X1", "a", NA))

})

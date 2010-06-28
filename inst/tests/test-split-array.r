context("Split array")

test_that("Lack of names is preserved", {
  a <- .matrix_to_df(cbind(1:5, 1:5))
  
  expect_that(names(a), equals(c("", "")))
  
  split <- splitter_a(a, 1)
  expect_that(names(split[[1]]), equals(c("", "")))
})
library(testthat)
library_if_available(plyr)

context("Concatenation")

test_that("Atomic vectors are concatenated correctly", {
  expect_that(concat(1, 2, 3), equals(1:3))
  expect_that(concat(1, c(2, 3)), equals(1:3))
  expect_that(concat("a", "b", "c"), equals(letters[1:3]))
})

test_that("Factors are concatenated correctly", {
  a <- factor("a")
  b <- factor("b")
  c <- factor("c")
  abc <- factor(c("a", "b", "c"))
  
  expect_that(concat(a, b, c), equals(abc))
  expect_that(concat(a, concat(b, c)), equals(abc))
})
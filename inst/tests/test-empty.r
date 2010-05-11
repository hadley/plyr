context("Empty inputs")

test_that("empty arrays returns object of same shape", {
  x <- structure(integer(0), .Dim = c(0L, 0L, 0L))

  expect_that(aaply(x, 1, identity), equals(x))
  expect_that(aaply(x, 2, identity), equals(x))
  expect_that(aaply(x, 3, identity), equals(x))
})

test_that("empty lists return a list", {
  expect_that(llply(list(), identity), equals(list()))
})

test_that("empty data frames returns itself", {
  df <- data.frame(x = numeric(0), a = numeric(0))
  expect_that(dlply(df, "a", identity), equals(df))
})

context("Replicate")

test_that("length of results are correct", {
  a <- rlply(4, NULL)
  b <- rlply(4, 1)

  expect_equal(length(a), 4)
  expect_equal(length(b), 4)
})

test_that("name of id column is set", {
  df <- rdply(4, function() c(a=1), .id='index')

  expect_equal(names(df), c('index', 'a'))
})

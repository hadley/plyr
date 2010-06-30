context("Mapply")

test_that("Lack of names is preserved", {
  list <- mlply(cbind(1:5, 1:5), list)
  expect_that(names(list[[1]]), equals(NULL))

  vector <- mlply(cbind(1:5, 1:5), c)
  expect_that(names(vector[[1]]), equals(NULL))
})

test_that("Simple case works", {
  a <- maply(cbind(1:20, 1:20), "+")
  expect_that(a, is_equivalent_to(1:20 * 2))
  
  d <- mdply(cbind(1:20, 1:20), "+")
  expect_that(d$X1, equals(1:20))
  expect_that(d$V1, equals(1:20 * 2))
})
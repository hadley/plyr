context("Mapply")

test_that("Lack of names is preserved", {
  list <- mlply(cbind(1:5, 1:5), list)
  expect_that(names(list[[1]]), equals(NULL))

  vector <- mlply(cbind(1:5, 1:5), c)
  expect_that(names(vector[[1]]), equals(NULL))
})
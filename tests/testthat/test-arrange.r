context("Arrange")

test_that("bogus sort order", {
  expect_error(arrange(mtcars, diff(mpg)), "Length of ordering vectors")
})

test_that("descending sort", {
  expect_equal(arrange(mtcars, desc(mpg)), arrange(mtcars, -mpg))
})

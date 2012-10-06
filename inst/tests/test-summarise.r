context("Summarise")

test_that("summarise creates correct names", {
  df <- summarise(mtcars, cyl, vs)
  expect_that(names(df), equals(c("cyl", "vs")))

  df <- summarise(mtcars, x = cyl, vs)
  expect_that(names(df), equals(c("x", "vs")))

  df <- summarise(mtcars, x = cyl, y = vs)
  expect_that(names(df), equals(c("x", "y")))

  # df <- summarise(mtcars, mean(cyl), mean(vs))
  # expect_that(names(df), equals("x", "y"))

})

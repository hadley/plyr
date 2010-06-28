context("Data frames")


test_that("results ordered in order of split variables", {
  d <- data.frame(x = c("a","b"), y = c("d","c"), stringsAsFactors = FALSE)

  plyed <- ddply(d, c("x" ,"y"))
  expect_that(plyed$x, equals(c("a", "b")))
  expect_that(plyed$y, equals(c("d", "c")))
  
  plyed <- ddply(d, c("y" ,"x"))
  expect_that(plyed$y, equals(c("c", "d")))
  expect_that(plyed$x, equals(c("b", "a")))
  
})
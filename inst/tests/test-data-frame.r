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

test_that("character vectors not change to factors", {
  d <- data.frame(x = c("a","b"), y = c("d","c"), stringsAsFactors = FALSE)

  plyed <- ddply(d, c("x" ,"y"), nrow)
  expect_that(plyed$x, is_a("character"))
  expect_that(plyed$y, is_a("character"))

  plyed <- ddply(d, c("x"), identity)
  expect_that(plyed$x, is_a("character"))
  expect_that(plyed$y, is_a("character"))

  plyed <- ddply(d, c("x" ,"y"), nrow, .drop = FALSE)
  expect_that(plyed$x, is_a("character"))
  expect_that(plyed$y, is_a("character"))

  plyed <- ddply(d, c("x"), identity, .drop = FALSE)
  expect_that(plyed$x, is_a("character"))
  expect_that(plyed$y, is_a("character"))  
})


# Bug report contributed by Thomas P Harte <THarte@tiaa-cref.org>
test_that("column names not changed", {
  d1 <- data.frame(`--WEIRD`=1:5, a = letters[1:5], `-b` = 1:5, 
    check.names = FALSE)
  d2 <- ddply(d1, .(`--WEIRD`), force) 
  expect_that(names(d2), equals(names(d1)))
  
  
})
context("Rename")

test_that("No match leaves names unchanged", {
  x <- c(a = 1, b = 2, c = 3, 4)
  y <- rename(x, c(d = "e"), warn_missing = FALSE)

  expect_equal(names(x), names(y))
})

test_that("Missing old values result in message", {
  # This is the same rename operation as above, but should give a message
  x <- c(a = 1, b = 2, c = 3, 4)
  expect_message(rename(x, c(d = "e")))
})

test_that("Single name match makes change", {
  x <- c(a = 1, b = 2)
  y <- rename(x, c(b = "c"))

  expect_equal(names(y), c("a", "c"))
})

test_that("Multiple names correctly changed", {
  x <- c(a = 1, b = 2, c = 3)
  y <- rename(x, c("c" = "f", "b" = "e", "a" = "d"))

  expect_equal(names(y), c("d", "e", "f"))
})

test_that("Empty vectors and lists", {
  expect_identical(rename(character(), c("c" = "f"), warn_missing = FALSE), character())
  expect_identical(rename(list(), c("c" = "f"), warn_missing = FALSE), list())
})

test_that("Renaming lists", {
  x <- list(a = 1, b = 2, c = 3)
  y <- rename(x, c("c" = "f", "b" = "e", "a" = "d"))
  expect_identical(y, list(d = 1, e = 2, f = 3))
})

context("Debugging")

test_that("failwith() function", {

  expect_equal(failwith(1:10, stop, quiet = TRUE)("error"), 1:10)

})

test_that("tryNULL() function", {

  old_options <- options(show.error.messages = FALSE)
  on.exit(options(old_options), add = TRUE)
  expect_equal(tryNULL(stop("error")), NULL)

})

test_that("tryapply() function", {

  safe_divide <- function(y, x) {
    stopifnot(y != 0)
    x / y
  }

  expect_equal(tryapply(-3:3, safe_divide, x = 1), as.list(1 / (-3:3)[-4]))

})

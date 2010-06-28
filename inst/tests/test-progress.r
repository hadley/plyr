context("Progress bars")

test_that("unknown progress bar raised warning, not error", {
  old <- options(warn = 2)
  on.exit(options(old))
  expect_that(
    llply(1:10, identity, .progress = "blah"),
    throws_error("Cannot find progress bar")
  )
})
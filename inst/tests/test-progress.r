context("Progress bars")

test_that("unknown progress bar raised warning, not error", {
  expect_that(
    llply(1:10, .progress = "blah"),
    warns_that("unknown progress type")
  )
})
context("Progress bars")

test_that("unknown progress bar raised warning, not error", {
  expect_warning(
    llply(1:10, identity, .progress = "blah"),
    "Cannot find progress bar"
  )
})

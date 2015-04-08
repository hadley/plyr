context("Utilities")

test_that("check for formula", {
  expect_true(is.formula(~a))
  expect_false(is.formula("a"))
})

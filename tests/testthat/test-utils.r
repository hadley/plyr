context("Utilities")

test_that("is.discrete", {
  expect_true(is.discrete(factor(3)))
  expect_true(is.discrete("3"))
  expect_true(is.discrete(TRUE))
  expect_false(is.discrete(3L))
  expect_false(is.discrete(3.0))
  expect_false(is.discrete(identity))
})

test_that("nunique", {
  expect_equal(nunique(LETTERS), 26)
  expect_equal(nunique(factor(LETTERS)), 26)

  # Odd behavior, for compatibility reasons:
  expect_equal(nunique(factor(LETTERS)[1:3]), 26)
})

test_that("check for formula", {
  expect_true(is.formula(~a))
  expect_false(is.formula("a"))
})

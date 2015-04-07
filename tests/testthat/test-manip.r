context("Manipulation")

test_that("each() function", {

  expect_equal(each(min, max)(1:10), c(min=1, max=10))
  expect_equal(each(c(min, max))(1:10), c(min=1, max=10))
  expect_equal(each(top=max, bottom=min)(1:10), c(top=10, bottom=1))
  expect_equal(each(top=max, min)(1:10), c(top=10, min=1))
  expect_equal(each(top="max", "min")(1:10), c(top=10, min=1))
  expect_equal(each(c("min", max))(1:10), c(min=1, max=10))

  # Odd behavior, kept for compatibility:
  expect_equal(each(pmin)(1:10, 10:1), c(1:5, 5:1))
  expect_equal(each(max, pmin)(1:10, 10:1), c(max=10, pmin=c(1:5, 5:1)))
  expect_error(each()(1:10))

})

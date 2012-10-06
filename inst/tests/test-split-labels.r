context("Split labels")

test_that("Empty levels preserved", {
  df <- data.frame(fac1 = letters[1:4], fac2 = LETTERS[1:4])

  a <- split_labels(df, FALSE)
  b <- split_labels(df[1, ], FALSE)

  expect_that(a, equals(b))

})

context("Split indices")

test_that("Error if n too small", {
  expect_error(split_indices(1:10, -5), "n must be")
  expect_error(split_indices(1:10, 5), "n smaller than largest index")
})

test_that("succeeds for large number of groups", {
  i <- 2097142
  expect_equal(length(split_indices(seq_len(i), i)), i)
})

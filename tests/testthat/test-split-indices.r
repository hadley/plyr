context("Split indices")

test_that("Error if n too small", {
  expect_error(split_indices(1:10, -5), "n must be")
})

test_that("index expands if n too small", {
  expect_equal(split_indices(1:10, 5), as.list(1:10))
})

test_that("succeeds for large number of groups", {
  i <- 2097142
  expect_equal(length(split_indices(seq_len(i), i)), i)
})

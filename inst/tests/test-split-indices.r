context("Split indices")

test_that("Error if n too small", {
  expect_error(split_indices(1:10, 5),
    "n smaller than largest index")

})

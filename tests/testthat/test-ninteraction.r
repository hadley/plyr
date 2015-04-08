context("id")

simple_vectors <- list(
  letters,
  sample(letters),
  1:26
)

test_that("for vector, equivalent to rank", {
  for (case in simple_vectors) {
    rank <- rank(case, ties = "min")
    rank_df <- id(as.data.frame(case))

    expect_that(rank, is_equivalent_to(rank_df))
  }
})

test_that("duplicates numbered sequentially", {
  for (case in simple_vectors) {
    rank <- rep(rank(case, ties = "min"), each = 2)
    rank_df <- id(as.data.frame(rep(case, each = 2)))

    expect_that(rank, is_equivalent_to(rank_df))
  }
})

test_that("n calculated correctly", {
  n <- function(x) attr(id(x), "n")
  for (case in simple_vectors) {
    expect_that(n(as.data.frame(case)), equals(26))
  }

})

test_that("for vector + constant, equivalent to rank", {
  for (case in simple_vectors) {
    rank <- rank(case, ties = "min")

    after <- id(data.frame(case, x = 1))
    before <- id(data.frame(x = 1, case))

    expect_that(rank, is_equivalent_to(before))
    expect_that(rank, is_equivalent_to(after))
  }
})

test_that("grids are correctly ranked", {
  df <- rev(expand.grid(1:10, 1:2))

  expect_that(id(df), is_equivalent_to(1:20))
  expect_that(id(df, drop = T), is_equivalent_to(1:20))
})

test_that("NAs are placed last", {
  expect_that(id_var(c(NA, 1)), is_equivalent_to(c(2, 1)))
})

test_that("factor with missing levels has correct count", {
  id <- id_var(factor(1, NA))
  expect_equal(attr(id, "n"), 1)
})

test_that("zero length input gives single number", {
  expect_that(id(character()), is_equivalent_to(integer()))
})

test_that("zero column data frame gives seq_len(nrow)", {
  df <- as.data.frame(matrix(nrow = 10, ncol = 0))
  expect_equivalent(id(df), 1:10)
})

test_that("empty list doesn't affect n", {
  out <- id(list(integer(), 1:5))
  expect_equivalent(out, 1:5)
  expect_equal(attr(out, "n"), 5)
})

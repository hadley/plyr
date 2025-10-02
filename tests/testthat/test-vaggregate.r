test_that("vaggregate matches tapply output for factors", {
  n <- 17
  group <- rep(1:3, length.out = n)
  fac <- factor(group, levels = 1:5)
  value <- 1:n
  expected <- c(51L, 57L, 45L, 0L, 0L)
  expect_equal(vaggregate(value, fac, sum), expected)

  expected_na <- c(51L, 57L, 45L, NA_integer_, NA_integer_)
  expect_equal(
    vaggregate(value, fac, sum, .default = NA_integer_),
    expected_na
  )
})

test_that("vaggregate works with range and default values", {
  n <- 17
  group <- rep(1:3, length.out = n)
  fac <- factor(group, levels = 1:5)
  value <- 1:n

  # default=NULL -> .fun(value[0]) = range(numeric(0)) = c(Inf, -Inf)
  expect_equal(
    vaggregate(value, fac, range),
    matrix(
      c(1, 16, 2, 17, 3, 15, Inf, -Inf, Inf, -Inf),
      nrow = 2
    )
  )

  default <- c(NA_real_, NA_real_)
  expect_equal(
    vaggregate(value, fac, range, .default = default),
    matrix(
      c(1, 16, 2, 17, 3, 15, NA, NA, NA, NA),
      nrow = 2
    )
  )
})

test_that("vaggregate works with various group types", {
  value <- 1:6
  # integer group
  expect_equal(vaggregate(value, c(1L, 1L, 2L, 2L, 3L, 3L), sum), c(3L, 7L, 11L))
  # numeric group
  expect_equal(vaggregate(value, c(1, 1, 2, 2, 3, 3), sum), c(3, 7, 11))
  # character group
  expect_equal(vaggregate(value, c("a", "a", "b", "b", "c", "c"), sum), c(3L, 7L, 11L))
  # factor group
  expect_equal(vaggregate(value, factor(c("a", "a", "b", "b", "c", "c")), sum), c(3L, 7L, 11L))
})

test_that("vaggregate takes .n argument to extend output", {
  value <- 1:4
  group <- c(1, 1, 3, 3)
  expect_equal(vaggregate(value, group, sum, .n = 3), c(3, 7, 0))
  expect_equal(vaggregate(value, group, sum, .n = 4, .default = -1), c(3, 7, -1, -1))
})

test_that("vaggregate handles NA in group", {
  value <- 1:5
  group_char_na <- c("a", "b", NA, "a", "b") # character with NA
  res_char_na <- vaggregate(value, group_char_na, sum)
  expect_equal(res_char_na, c(5L, 7L, 3L))

  group_fac_na <- factor(c("a", "a", "b", NA, NA), levels = c("a", "b"), exclude = NULL)
  expect_equal(vaggregate(1:5, group_fac_na, sum), c(3L, 3L, 9L))
})

test_that("vaggregate handles NA in value", {
  value <- c(1, NA, 3, 4, 5, 6)
  group <- c(1, 1, 1, 2, 2, 2)
  expect_equal(vaggregate(value, group, sum), c(NA_integer_, 15L))
  expect_equal(vaggregate(value, group, sum, na.rm = TRUE), c(4L, 15L))
  expect_equal(vaggregate(value, group, length), c(3L, 3L))
})

test_that("vaggregate works with data.frame group", {
  value <- 1:4
  group <- data.frame(g1 = c("a", "a", "b", "b"), g2 = c(1, 1, 1, 2))
  res <- vaggregate(value, group, sum, .n = 4)
  expect_equal(res, c(3, 0, 3, 4))
})

test_that("vaggregate: empty inputs", {
  expect_equal(vaggregate(integer(), integer(), sum, .n = 0), numeric())
  expect_error(
    vaggregate(integer(), integer(), sum, .default = NA_integer_),
    "n must be a positive integer",
    fixed = TRUE
  )
  expect_equal(vaggregate(integer(), factor(), sum), numeric())
})

test_that("vaggregate: .fun returning length>1 vectors", {
  x <- 1:10
  g <- rep(1:2, 5)
  res <- vaggregate(x, g, range)
  expect_equal(res, matrix(c(1, 9, 2, 10), nrow = 2))
  res <- vaggregate(x, g, quantile, probs = c(0.25, 0.75))
  expect_equal(
    res,
    matrix(c(3, 7, 4, 8), nrow = 2, dimnames = list(c("25%", "75%"), NULL))
  )
})

test_that("vaggregate passes ... to .fun for default", {
  x <- 1:2
  g <- factor("a", levels = c("a", "b"))
  .f <- function(x, y = 1) if (length(x) == 0) y else sum(x) + y
  expect_equal(vaggregate(x, g, .f, y = 10, .default = NULL), c(11, 10))
  # if .default is provided, it is used
  expect_equal(vaggregate(x, g, .f, y = 10, .default = 100), c(11, 100))
})

test_that("vaggregate corner cases", {
  res <- vaggregate(1:99, rep(1:11, 9), sum)
  expect_equal(res, vaggregate(1:99, id(list(rep(1:11, 9))), sum))
  expect_equal(res, vaggregate(1:99, rep(0.5 + (1:11), 9), sum, .default = 1))
  expect_equal(res, vaggregate(1:99, expand.grid(1:11, 1:9)[, 1, drop = FALSE], sum))
})

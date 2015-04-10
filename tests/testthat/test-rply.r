context("r?ply")

test_that("Side effects for r_ply", {
  counts <- c(0, 1, 5)

  # Simple function with side effect of incrementing i in an outer environment
  # by one
  inc <- function() {
    i <<- i + 1; invisible(NULL)
  }

  # For each of the possible counts, check that exactly n side effects are seen
  # for various types of invocations of inc: As a statement, as a function call
  # or as a function calling the function.  Calling r_ply with a function that
  # returns the inc function should not produce any side effects, this is
  # intentional.
  for (n in counts) {
    i <- 0
    r_ply(n, inc)
    expect_equal(i, n, info="inc")

    i <- 0
    r_ply(n, inc())
    expect_equal(i, n, info="inc()")

    i <- 0
    r_ply(n, inc() + inc())
    expect_equal(i, 2 * n, info="inc() + inc()")

    i <- 0
    r_ply(n, function() inc())
    expect_equal(i, n, info="function() inc()")

    i <- 0
    r_ply(n, function() inc() + inc())
    expect_equal(i, 2 * n, info="function() inc() + inc()")

    i <- 0
    r_ply(n, function() inc)
    expect_equal(i, 0, info="function() inc")
  }
})

test_that("Side effects for rlply", {
  counts <- c(0, 1, 5)

  # Similar to the test for r_ply, now there is also a return value in incition
  # to the side effect
  inc <- function() {
    i <<- i + 1
  }

  # The test now checks, in incition to side effect count, that the returned
  # list is correct
  for (n in counts) {
    i <- 0
    res <- rlply(n, inc)
    expect_equal(res, as.list(seq_len(n)), info="inc")
    expect_equal(i, n, info="inc")

    i <- 0
    res <- rlply(n, inc())
    expect_equal(res, as.list(seq_len(n)), info="inc()")
    expect_equal(i, n, info="inc()")

    i <- 0
    res <- rlply(n, function() inc())
    expect_equal(res, as.list(seq_len(n)), info="function() inc()")
    expect_equal(i, n, info="function() inc()")

    # Funny case: A function that returns a function, this is not
    # handled at all
    i <- 0
    rlply(n, function() inc)
    expect_equal(i, 0, info="function() inc")
  }
})

test_that("Side effects for raply", {
  counts <- c(0, 1, 5)

  inc <- function() {
    i <<- i + 1
  }

  for (n in counts) {
    # This is funny. Why does raply(.n, inc) return a named vector only for
    # .n == 1?
    if (n == 0) {
      exp_res <- logical()
    } else if (n == 1) {
      exp_res <- setNames(nm = 1)
    } else
      exp_res <- seq_len(n)

    i <- 0
    res <- raply(n, inc)
    expect_equal(res, exp_res, info="inc")
    expect_equal(i, n, info="inc")

    i <- 0
    res <- raply(n, inc())
    expect_equal(res, exp_res, info="inc()")
    expect_equal(i, n, info="inc()")

    i <- 0
    res <- raply(n, function() inc())
    expect_equal(res, exp_res, info="function() inc()")
    expect_equal(i, n, info="function() inc()")
  }
})

test_that("Side effects for rdply", {
  counts <- c(0, 1, 5)

  inc <- function() {
    i <<- i + 1; data.frame(i = i)
  }

  for (n in counts) {
    if (n == 0) {
      exp_res <- data.frame()
    } else {
      exp_res <- data.frame(.n = 1L:n, i = 1L:n, stringsAsFactors = FALSE)
    }

    i <- 0
    res <- rdply(n, inc)
    expect_equal(res, exp_res, info="inc")
    expect_equal(i, n, info="inc")

    i <- 0
    res <- rdply(n, inc())
    expect_equal(res, exp_res, info="inc()")
    expect_equal(i, n, info="inc()")

    i <- 0
    res <- rdply(n, function() inc())
    expect_equal(res, exp_res, info="function() inc()")
    expect_equal(i, n, info="function() inc()")
  }
})

test_that("Invalid arguments for r_ply", {
  expect_error(r_ply(-3, identity))
  expect_error(r_ply("abc", identity))
  expect_error(r_ply(c(1,2), identity))
  expect_error(r_ply(list(5), identity))
})

test_that(".id column for rdply", {
  expect_equal(rdply(5, 10)$.n, 1:5)
  expect_equal(rdply(5, 10, .id=".x")$.x, 1:5)
})

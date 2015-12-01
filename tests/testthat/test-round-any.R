context("round_any()")

test_that("accurately applies rounding functons", {
  # numeric
  expect_identical(round_any(135, 10, round), 140)
  expect_identical(round_any(135, 10, floor), 130)
  expect_identical(round_any(135, 10, ceiling), 140)

  # POSIXct
  expect_identical(round_any(as.POSIXct('2015-12-01 00:00:03', tz = "GMT"), 5, round),
                   as.POSIXct("2015-12-01 00:00:05", tz = "GMT"))
  expect_identical(round_any(as.POSIXct('2015-12-01 00:00:01', tz = "GMT"), 5, floor),
                   as.POSIXct("2015-12-01 00:00:00", tz = "GMT"))
  expect_identical(round_any(as.POSIXct('2015-12-01 00:00:01', tz = "GMT"), 5, ceiling),
                   as.POSIXct("2015-12-01 00:00:05", tz = "GMT"))
})

test_that("does not distort or break a table object", {
  # 4 X 5
  tab <- with(airquality, table(cut(Temp, quantile(Temp)), Month))

  test_table <- matrix(round_any(tab, 10),
                       nrow = nrow(tab), ncol = ncol(tab),
                       dimnames = dimnames(tab))
  test_table <- apply(test_table, c (1, 2), function (x) {
    (as.integer(x))
  })
  test_table <- as.table(test_table)

  expect_identical(round_any(tab, 10), test_table)

  # 1 x 2
  one_row <- table(c(rep(1, 2), rep(3, 2)))
  expect_equivalent(one_row, round_any(one_row, 2))
})

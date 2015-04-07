context("ID column name")

test_that(".id parameter for ldply", {

  data <- setNames(nm = 1:10)

  expect_equal(names(ldply(data, identity)), c(".id", "V1"))
  expect_equal(names(ldply(data, identity, .id = NULL)), c("V1"))
  expect_equal(names(ldply(data, identity, .id = NA)), c(".id", "V1"))
  expect_equal(names(ldply(data, identity, .id = "ID")), c("ID", "V1"))

})

test_that("ID column is a factor if .id argument is set", {

  data <- setNames(nm = 1:10)

  expect_false(is.factor(ldply(data, identity)$.id))
  expect_true(is.factor(ldply(data, identity, .id = "ID")$ID))

})

test_that(".id parameter for rdply", {

  expect_equal(names(rdply(10, 0)), c(".n", "V1"))
  expect_false(is.factor(rdply(10, 0)$.n))
  expect_equal(names(rdply(10, 0, .id = NULL)), c("V1"))
  expect_equal(names(rdply(10, 0, .id = NA)), c(".n", "V1"))
  expect_equal(names(rdply(10, 0, .id = "ID")), c("ID", "V1"))
  expect_false(is.factor(rdply(10, 0, .id = "ID")$ID))

})

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

test_that(".id parameter for adply", {
  data <- array(1:27, dim = c(3, 3, 3))

  expect_equal(names(adply(data, 1, identity)), c("X1", "1", "2", "3"))
  expect_equal(names(adply(data, 2, identity)), c("X1", "1", "2", "3"))
  expect_equal(names(adply(data, 3, identity)), c("X1", "1", "2", "3"))
  expect_equal(names(adply(data, c(1, 2), identity)), c("X1", "X2", "V1", "V2", "V3"))
  expect_equal(names(adply(data, c(1, 3), identity)), c("X1", "X2", "V1", "V2", "V3"))
  expect_equal(names(adply(data, c(1, 2, 3), identity)), c("X1", "X2", "X3", "V1"))
  expect_equal(names(adply(data, c(), identity)), paste0("V", data))

  expect_equal(names(adply(data, 1, identity, .id = NA)), c("X1", "1", "2", "3"))
  expect_equal(names(adply(data, 2, identity, .id = NA)), c("X1", "1", "2", "3"))
  expect_equal(names(adply(data, 3, identity, .id = NA)), c("X1", "1", "2", "3"))
  expect_equal(names(adply(data, c(1, 2), identity, .id = NA)), c("X1", "X2", "V1", "V2", "V3"))
  expect_equal(names(adply(data, c(1, 3), identity, .id = NA)), c("X1", "X2", "V1", "V2", "V3"))
  expect_equal(names(adply(data, c(1, 2, 3), identity, .id = NA)), c("X1", "X2", "X3", "V1"))
  expect_equal(names(adply(data, c(), identity, .id = NA)), paste0("V", data))

  expect_equal(names(adply(data, 1, identity, .id = NULL)), c("1", "2", "3"))
  expect_equal(names(adply(data, 2, identity, .id = NULL)), c("1", "2", "3"))
  expect_equal(names(adply(data, 3, identity, .id = NULL)), c("1", "2", "3"))
  expect_equal(names(adply(data, c(1, 2), identity, .id = NULL)), c("V1", "V2", "V3"))
  expect_equal(names(adply(data, c(1, 3), identity, .id = NULL)), c("V1", "V2", "V3"))
  expect_equal(names(adply(data, c(1, 2, 3), identity, .id = NULL)), c("V1"))
  expect_equal(names(adply(data, c(), identity, .id = NULL)), paste0("V", data))

  expect_equal(names(adply(data, 1, identity, .id = LETTERS[1])), c("A", "1", "2", "3"))
  expect_equal(names(adply(data, 2, identity, .id = LETTERS[1])), c("A", "1", "2", "3"))
  expect_equal(names(adply(data, 3, identity, .id = LETTERS[1])), c("A", "1", "2", "3"))
  expect_equal(names(adply(data, c(1, 2), identity, .id = LETTERS[1:2])), c("A", "B", "V1", "V2", "V3"))
  expect_equal(names(adply(data, c(1, 3), identity, .id = LETTERS[1:2])), c("A", "B", "V1", "V2", "V3"))
  expect_equal(names(adply(data, c(1, 2, 3), identity, .id = LETTERS[1:3])), c("A", "B", "C", "V1"))

  error_rx <- "[.]id argument.*number of margins"
  expect_error(adply(data, 1, identity, .id = LETTERS[1:2]), error_rx)
  expect_error(adply(data, 2, identity, .id = LETTERS[1:2]), error_rx)
  expect_error(adply(data, 3, identity, .id = LETTERS[1:2]), error_rx)
  expect_error(adply(data, c(1, 2), identity, .id = LETTERS[1:3]), error_rx)
  expect_error(adply(data, c(1, 3), identity, .id = LETTERS[1:3]), error_rx)
  expect_error(adply(data, c(1, 2, 3), identity, .id = LETTERS[1:4]), error_rx)
  expect_error(adply(data, c(), identity, .id = LETTERS[1]), error_rx)
})

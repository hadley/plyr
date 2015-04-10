# Main-stream cases -----------------------------------
context("Rename - Expected Usage")

test_that("No match leaves names unchanged", {
  x <- c(a = 1, b = 2, c = 3, 4)
  y <- rename(x, c(d = "e"), warn_missing = FALSE)

  expect_equal(names(x), names(y))
})

test_that("Missing old values result in message", {
  # This is the same rename operation as above, but should give a message
  x <- c(a = 1, b = 2, c = 3, 4)
  expect_message(rename(x, c(d = "e")))
})

test_that("Single name match makes change", {
  x <- c(a = 1, b = 2)
  y <- rename(x, c(b = "c"))

  expect_equal(names(y), c("a", "c"))
})

test_that("Multiple names correctly changed", {
  x <- c(a = 1, b = 2, c = 3)
  y <- rename(x, c("c" = "f", "b" = "e", "a" = "d"))

  expect_equal(names(y), c("d", "e", "f"))
})

test_that("Empty vectors and lists", {
  expect_identical(rename(character(), c("c" = "f"), warn_missing = FALSE), character())
  expect_identical(rename(list(), c("c" = "f"), warn_missing = FALSE), list())
})

test_that("Renaming lists", {
  x <- list(a = 1, b = 2, c = 3)
  y <- rename(x, c("c" = "f", "b" = "e", "a" = "d"))
  expect_identical(y, list(d = 1, e = 2, f = 3))
})

# Duplicate Names -----------------------------------
context("Rename - Duplicates")

# This batch tests the typical renaming scenarios
test_that("Renaming list with one conflicting variable name - default", {
  x <- list(a = 1, b = 2, c = 3)
  replace_list <- c("c" = "f", "b" = "e", "a" = "f")
  expected_response <- "created duplicates"
  #The exact match would be: "The plyr::rename operation has created duplicates for the following name\\(s\\): \\(`f`\\)"
  expect_warning(rename(x = x, replace = replace_list), expected_response)
})
test_that("Renaming list with two conflicting variable names - default", {
  x <- list(a = 1, b = 2, c = 3, d = 4, e = 5)
  replace_list <- c("c" = "f", "b" = "e", "a" = "f", "d" = "g", "e" = "g")
  expected_response <- "created duplicates"
  #The exact match would be: "The plyr::rename operation has created duplicates for the following name\\(s\\): \\(`f`, `g`\\)"
  expect_warning(rename(x = x, replace = replace_list), expected_response)
})
test_that("Renaming list with two conflicting variable names - default", {
  x <- list(a = 1, b = 2, c = 3, d = 4, e = 5)
  replace_list <- c("c" = "f", "b" = "e", "a" = "f", "d" = "g", "e" = "g")
  expected_response <- "created duplicates"
  #The exact match would be: "The plyr::rename operation has created duplicates for the following name\\(s\\): \\(`f`, `g`\\)"
  expect_warning(rename(x = x, replace = replace_list), expected_response)
})
test_that("Renaming list with an conflicting variable name - without warning", {
  x <- list(a = 1, b = 2, c = 3)
  replace_list <- c("c" = "f", "b" = "e", "a" = "f")
  result <- rename(x = x, replace = replace_list, warn_duplicated = FALSE)
  expect_identical(result, list(f = 1, e = 2, f = 3))
})


# This batch tests the boundary cases
test_that("Renaming to the same value", {
  #One element is renamed to itself
  x <- list(a = 1, b = 2, c = 3)
  replace_list <- c("a" = "a")
  expected_value <- x
  expect_identical(rename(x = x, replace = replace_list), expected_value)
})
test_that("Renaming list with an empty renaming vector", {
  #No renames are requested (which could happen if the calling code was under a lot of automated code.)
  x <- list(a = 1, b = 2, c = 3)
  replace_list <- c()
  expected_value <- x
  expect_identical(rename(x = x, replace = replace_list), expected_value)
})
test_that("Single Swapping (shouldn't cause problems)", {
  #Notice how a becomes c, while c becomes f.
  x <- list(a = 1, b = 2, c = 3)
  replace_list <- c("c" = "f", "b" = "e", "a" = "c")
  expected_value <- list(c = 1, e = 2, f = 3)
  actual_value <- rename(x = x, replace = replace_list)
  expect_identical(actual_value, expected_value)
})
test_that("Double Swapping (shouldn't cause problems)", {
  #Notice how a becomes c, while c becomes a.
  x <- list(a = 1, b = 2, c = 3)
  replace_list <- c("c" = "a", "b" = "z", "a" = "c")
  expected_value <- list(c = 1, z = 2, a = 3)
  actual_value <- rename(x = x, replace = replace_list)
  expect_identical(actual_value, expected_value)
})
test_that("Multiple assignments for the same element", {
  #Notice how it requests to change a to d, e, and f.
  x <- list(a = 1, b = 2, c = 3)
  replace_list <- c("a" = "d", "a" = "e", "a" = "f")
  expected_response <- "The following `from` values were not present in `x`: a, a"
  expected_value <- list(a = 1, a = 2, a = 3)
  expect_message(rename(x = x, replace = replace_list), expected_response)
})

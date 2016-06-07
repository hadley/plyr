context("Replace values")


# Character vector
chr <- c("A2", "A1", "A3", "A1")
# Factor: To complicate things, set levels in a different order
fac  <- factor(c("A1", "A2", "A3"), levels=c("A2", "A1", "A3"))
# Numeric vector
num <- c(4, 1, 5, 8)


# test warn if any missing

test_that("Empty mapping results in no change", {
  expect_identical(mapvalues(chr, from = NULL, to = NULL), chr)
  expect_identical(revalue(chr, NULL), chr)

  expect_identical(mapvalues(fac, from = NULL, to = NULL), fac)
  expect_identical(revalue(fac, NULL), fac)
})

test_that("Basic mapping works", {
  newchr <- c("B2", "A1", "B3", "A1")
  expect_identical(mapvalues(chr, c("A3", "A2"), c("B3", "B2")), newchr)
  expect_identical(revalue(chr, c(A3="B3", A2="B2")), newchr)

  newfac <- factor(c("A1", "B2", "B3"), levels=c("B2", "A1", "B3"))
  expect_identical(mapvalues(fac, c("A3", "A2"), c("B3", "B2")), newfac)
  expect_identical(revalue(fac, c(A3="B3", A2="B2")), newfac)

  newnum <- c(40, 1, 5, 80)
  expect_identical(mapvalues(num, c(4, 8), c(40, 80)), newnum)
  # revalue doesn't work for numeric vectors
})

test_that("Mapping with repeated original values - uses first instance, and gives message", {
  newchr <- c("A2", "B1", "A3", "B1")
  expect_message(
    expect_identical(mapvalues(chr, c("A1", "A1"), c("B1", "C1")), newchr))
  expect_message(
    expect_identical(revalue(chr, c(A1="B1", A1="C1")), newchr))


  newfac <- factor(c("B1", "A2", "A3"), levels=c("A2", "B1", "A3"))
  expect_message(
    expect_identical(mapvalues(fac, c("A1", "A1"), c("B1", "C1")), newfac))
  expect_message(
    expect_identical(revalue(fac, c(A1="B1", A1="C1")), newfac))

  newnum <- c(4, 1, 5, 80)
  expect_message(
    expect_identical(mapvalues(num, c(8, 8), c(80, 800)), newnum))
})

test_that("Mapping with repeated new value (for factors, levels are in earliest position)", {
  newchr <- c("BX", "A1", "BX", "A1")
  expect_identical(mapvalues(chr, c("A3", "A2"), c("BX", "BX")), newchr)
  expect_identical(revalue(chr, c(A3="BX", A2="BX")), newchr)


  newfac <- factor(c("A1", "BX", "BX"), levels=c("BX", "A1"))
  expect_identical(revalue(fac, c(A3="BX", A2="BX")), newfac)

  # Factors can have levels in different orders
  newfac2 <- factor(c("BX", "A2", "BX"), levels=c("A2", "BX"))
  expect_identical(revalue(fac, c(A3="BX", A1="BX")), newfac2)
})

test_that("Mapping with multiple matches works", {
  newchr <- c("B2", "B1", "A3", "B1")
  expect_identical(mapvalues(chr, c("A1", "A2"), c("B1", "B2")), newchr)
  expect_identical(revalue(chr, c(A1="B1", A2="B2")), newchr)
  # Not relevant for factors because they can't have two levels be the same
})

test_that("Mapping with non-matching original levels results in no change, and message", {
  expect_message(
    expect_identical(revalue(chr, c(A4="B4")), chr))
  expect_message(
    expect_identical(revalue(chr, c(A3="B3", A4="B4")), c("A2", "A1", "B3", "A1")))

  expect_message(
    expect_identical(revalue(fac, c(A4="B4")), fac))
  expect_message(
    expect_identical(revalue(fac, c(A3="B3", A4="B4")),
                     factor(c("A1", "A2", "B3"), levels=c("A2", "A1", "B3"))))
})

test_that("Swapping values works", {
  newchr <- c("A3", "A1", "A2", "A1")
  expect_identical(mapvalues(chr, c("A2", "A3"), c("A3", "A2")), newchr)
  expect_identical(revalue(chr, c(A2="A3", A3="A2")), newchr)

  newfac <- factor(c("A1", "A3", "A2"), levels=c("A3", "A1", "A2"))
  expect_identical(mapvalues(fac, c("A2", "A3"), c("A3", "A2")), newfac)
  expect_identical(revalue(fac, c(A2="A3", A3="A2")), newfac)
})

test_that("Mapping with ' ' and '$' in original and replacement works", {
  chr2 <- c("A2", "A $1", "A3", "A $1")
  expect_identical(revalue(chr2, c("A $1"="B $1")),
                  c("A2", "B $1", "A3", "B $1"))

  fac2 <- factor(c("A $1", "A2", "A3"), levels=c("A2", "A $1", "A3"))
  expect_identical(revalue(fac2, c("A $1"="B $1")),
                   factor(c("B $1", "A2", "A3"), levels=c("A2", "B $1", "A3")))
})

test_that("revalue and mapvalues only accept atomic vectors", {
  expect_error(revalue(list(A=3), c("3"=30)))
  expect_error(mapvalues(list(A=3), 3, 30))
})

test_that("revalue and mapvalues accept empty vectors and NULL", {
  expect_identical(revalue(character(0), c("3"=30), warn_missing=FALSE), character(0))
  expect_identical(mapvalues(character(0), 3, 30, warn_missing=FALSE), character(0))

  expect_identical(revalue(NULL, c("3"=30), warn_missing=FALSE), NULL)
  expect_identical(mapvalues(NULL, 3, 30, warn_missing=FALSE), NULL)
})

test_that("revalue and mapvalues respect warn_missing", {
  # revalue
  expect_message(revalue("a", c("a"="A")), NA)
  expect_message(revalue("a", c("b"="B"), warn_missing=TRUE))
  expect_message(revalue("a", c("b"="B"), warn_missing=FALSE), NA)

  # mapvalues
  expect_message(mapvalues("a", "a", "A"), NA)
  expect_message(mapvalues("a", "b", "B", warn_missing=TRUE))
  expect_message(mapvalues("a", "b", "B", warn_missing=FALSE), NA)

  # mapvalues with factors
  expect_message(mapvalues(factor("a"), "a", "A"), NA)
  expect_message(mapvalues(factor("a"), "b", "B", warn_missing=TRUE))
  expect_message(mapvalues(factor("a"), "b", "B", warn_missing=FALSE), NA)
})

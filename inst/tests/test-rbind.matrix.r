context("rbind.fill.matrix")

test_that ("merge 3 matrices: should behave like rbind.fill for data.frame",{
  a <- matrix (1:9, 3)
  b <- matrix (1:12, 3)
  c <- matrix (1:12, 2)

  new <- rbind.fill.matrix(a, b, c)

  ref <- as.matrix (rbind.fill (as.data.frame (a),
                                as.data.frame (b),
                                as.data.frame (c)))
  colnames (ref) <- seq_len(ncol(ref))
  # rbind.fill.matrix always sets
  # colnames. I don't think it's worth
  # wile trying to suppress that if no
  # matrix had column names before

  rownames (ref) <- NULL
  expect_that(new, equals(ref))
})


test_that ("additional columns are NA: should behave like rbind.fill for data.frame",{
  a <- matrix (1:9, 3)
  b <- matrix (1:12, 3)

  new <- rbind.fill.matrix (a, b)

  ref <- as.matrix (rbind.fill (as.data.frame (a), as.data.frame (b)))
  colnames (ref) <- seq_len(ncol(ref))
  rownames (ref) <- NULL

  expect_that(new, equals(ref))
})

test_that ("merge with column names: should behave like rbind.fill for data.frame",{
  a <- matrix (1:9, 3)
  colnames (a) <- letters [1 : 3]
  b <- matrix (1:9, 3)
  colnames (b) <- letters [3 : 1]

  new <- rbind.fill.matrix (a, b)

  ref <- as.matrix (rbind.fill (as.data.frame (a), as.data.frame (b)))
  rownames (ref) <- NULL

  expect_that(new, equals(ref))
})


test_that ("merge with column names: should behave like rbind.fill for data.frame",{
  a <- matrix (1:9, 3)
  colnames (a) <- letters [1 : 3]
  b <- matrix (1:9, 3)
  colnames (b) <- letters [c (1, 2, 4)]

  new <- rbind.fill.matrix (a, b)

  ref <- as.matrix (rbind.fill (as.data.frame (a), as.data.frame (b)))
  rownames (ref) <- NULL

  expect_that(new, equals(ref))
})

test_that ("only 1 element: should behave like rbind.fill for data.frame",{
  a <- matrix (1, 1)
  colnames (a) <- letters [2]

  b <- matrix (1:9, 3)
  colnames (b) <- letters [c (1, 2, 4)]

  new <- rbind.fill.matrix (a, b)

  ref <- as.matrix (rbind.fill (as.data.frame (a), as.data.frame (b)))
  rownames (ref) <- NULL

  expect_that(new, equals(ref))
})


test_that ("character + numeric: should behave like rbind.fill for data.frame",{
  a <- matrix (letters [1:9], 3)
  colnames (a) <- letters [1:3]
  b <- matrix (1:9, 3)
  colnames (b) <- letters [c (1, 2, 4)]

  new <- rbind.fill.matrix (a, b)
  ref <- rbind.fill (as.data.frame (a, stringsAsFactors = FALSE),
                     as.data.frame (b, stringsAsFactors = FALSE))
  ref <- as.matrix (sapply (ref, as.character)) # the last column is integer and would gain a second
                                                # character with direct as.matrix

  expect_that(new, equals(ref))
})


test_that ("factor: stops with error",{
  a <- factor (rep (LETTERS [1 : 3], 3))
  dim (a) <- c (3, 3)
  expect_that(rbind.fill.matrix (a), throws_error ("factor"))
})

test_that ("vector: uses as.matrix",{
  a <- 1

  new <- rbind.fill.matrix (a)

  ref <- data.frame (a = I (as.matrix (a)))
  colnames (ref) <- paste ("X", seq_len (ncol (ref)), sep = "")

  expect_that(new, equals (new))
})

test_that("zero-row matrices", {
  m1 <- matrix(nrow=0, ncol=2, dimnames=list(NULL, c("x", "y")))
  m2 <- matrix(nrow=0, ncol=2, dimnames=list(NULL, c("y", "z")))
  m3 <- matrix(c(1,2), nrow=2, ncol=1, dimnames=list(NULL, "y"))
  
  ba <- rbind.fill.matrix(m1)
  bb <- rbind.fill.matrix(m2, m3)
  bc <- rbind.fill.matrix(m1, m2)
  
  expect_equal(class(ba), "matrix")
  expect_equal(nrow(ba), 0)
  expect_true(all(colnames(ba) %in% c("x", "y")))
  
  expect_equal(class(bb), "matrix")
  expect_equal(nrow(bb), 2)
  expect_true(all(names(bb) %in% c("x", "y", "z")))
  expect_equal(bb[,"y"], m3[,"y"])
  expect_equal(bb[,"z"], rep(as.numeric(NA), nrow(m3)))
  
  expect_equal(class(bc), "matrix")
  expect_equal(nrow(bc), 0)
  expect_true(all(colnames(bc) %in% c("x", "y", "z")))
})



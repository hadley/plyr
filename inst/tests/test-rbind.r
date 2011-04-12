context("rbind.fill")

test_that("variable classes are preserved", {
  a <- data.frame(a = factor(letters[1:3]), b = 1:3, c = date())
  b <- data.frame(
    a = factor(letters[3:5]), 
    d = as.Date(c("2008-01-01", "2009-01-01", "2010-01-01")),
    e = I (matrix (1:6, nrow = 3)))
  ab1 <- rbind.fill(a, b)[, letters[1:5]]
  ab2 <- rbind.fill(b, a)[c(4:6, 1:3), letters[1:5]]
  ab2$a <- factor(ab2$a, levels(ab1$a))
  rownames(ab2) <- NULL
  
  expect_that(ab1, equals(ab2))
})

test_that("same as rbind for simple cases", {
  bsmall <- baseball[1:1000, ]
  bplayer <- split(bsmall, bsmall$id)
  b1 <- do.call("rbind", bplayer)
  rownames(b1) <- NULL
  b2 <- rbind.fill(bplayer)
  
  expect_that(b1, equals(b2))
})

test_that("columns are in expected order", {
  a <- data.frame(a = 1, b = 2, c = 3)
  b <- data.frame(b = 2, d = 4, e = 4)
  c <- data.frame(c = 1, b = 2, a = 1)
  
  expect_that(names(rbind.fill(a, b)), equals(c("a", "b", "c", "d", "e")))
  expect_that(names(rbind.fill(a, c)), equals(c("a", "b", "c")))
  expect_that(names(rbind.fill(c, a)), equals(c("c", "b", "a")))
})

test_that("matrices are preserved", {
  a <- data.frame(a = factor(letters[3:5]))
  a$b <- matrix(1:6, nrow = 3)
  
  expect_that(rbind.fill(a, a)$b, is_equivalent_to(rbind(a, a)$b))
  
  b <- data.frame(c = 1:3)

  ab1 <- rbind.fill(a, b) [           , letters[1:3]]
  ab2 <- rbind.fill(b, a) [c(4:6, 1:3), letters[1:3]]
  ab2$a <- factor(ab2$a, levels(ab1$a))
  rownames(ab2) <- NULL
  
  expect_that(ab1, equals(ab2))
})

test_that("missing levels in factors preserved", {
  f <- addNA(factor(c("a", "b", NA)))
  df1 <- data.frame(a = f)
  df2 <- data.frame(b = f)
  rbind.fill(df1, df2)
})

test_that("time zones are preserved", {
  dstart <- "2011-01-01 00:01"
  dstop <- "2011-01-02 04:15"

  get_tz <- function(x) attr(as.POSIXlt(x), "tz")

  tzs <- c("", "CET", "UTC")
  for(tz in tzs) {
    start <- data.frame(x = as.POSIXct(dstart, tz = tz))
    end <- data.frame(x = as.POSIXct(dstop, tz = tz))
    
    both <- rbind.fill(start, end)
    expect_that(get_tz(both$x)[1], equals(tz), label = tz)
  }

})

test_that("arrays are ok", {
  df <- data.frame(x = 1)
  df$x <- array(1, 1)

  df2 <- rbind.fill(df, df)
  expect_that(df2$x, is_equivalent_to(rbind(df, df)$x))
})
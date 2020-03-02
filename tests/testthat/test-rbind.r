context("rbind.fill")

test_that("variable classes are preserved", {
  a <- data.frame(
    a = factor(letters[1:3]),
    b = 1:3,
    c = date(),
    stringsAsFactors = TRUE
  )
  b <- data.frame(
    a = factor(letters[3:5]),
    d = as.Date(c("2008-01-01", "2009-01-01", "2010-01-01")))
  b$e <- as.POSIXlt(as.Date(c("2008-01-01", "2009-01-01", "2010-01-01")))
  b$f <- matrix (1:6, nrow = 3)

  ab1 <- rbind.fill(a, b)[, letters[1:6]]
  ab2 <- rbind.fill(b, a)[c(4:6, 1:3), letters[1:6]]
  ab2$a <- factor(ab2$a, levels(ab1$a))
  rownames(ab2) <- NULL

  expect_that(ab1, equals(ab2))

  expect_s3_class(ab1$a, "factor")
  expect_type(ab1$b, "integer")
  expect_s3_class(ab1$c, "factor")
  expect_s3_class(ab1$d, "Date")
  expect_s3_class(ab1$e, "POSIXct")
  expect_equal(dim(ab1$f), c(6, 2))
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

test_that("character or factor or list-matrices are preserved", {
  d1 <- data.frame(a=1:2,
                   x=I(matrix(c('a', 'b', 'c', 'd'), nrow=2)))
  d2 <- data.frame(b=1:2,
                   x=I(`dim<-`(factor(c('a', 'b', 'c', 'd')), c(2,2))))
  d3 <- data.frame(b=1:2,
                   x=I(array(as.list(1:4), c(2,2))))

  b1 <- rbind.fill(d1, d1)
  b2 <- rbind.fill(d2, d2)
  b3 <- rbind.fill(d3, d3)

  expect_equal(dim(b1$x), c(4,2))
  expect_equal(typeof(b1$x), "character")

  expect_equal(dim(b2$x), c(4,2))
  expect_is(b2$x, "factor")

  expect_equal(dim(b3$x), c(4,2))
  expect_equal(typeof(b3$x), "list")
})

test_that("missing levels in factors preserved", {
  f <- addNA(factor(c("a", "b", NA)))
  df1 <- data.frame(a = f, c = f)
  df2 <- data.frame(b = f, c = f)
  out <- rbind.fill(df1, df2)
  expect_equal(levels(out$a), levels(f))
  expect_equal(levels(out$b), levels(f))
  expect_equal(levels(out$c), levels(f))
})

test_that("time zones are preserved", {
  dstart <- "2011-01-01 00:01"
  dstop <- "2011-01-02 04:15"

  get_tz <- function(x) attr(as.POSIXlt(x), "tz")

  tzs <- c("CET", "UTC")
  for (tz in tzs) {
    start <- data.frame(x = as.POSIXct(dstart, tz = tz))
    end <- data.frame(x = as.POSIXct(dstop, tz = tz))

    both <- rbind.fill(start, end)
    expect_that(get_tz(both$x)[1], equals(tz), label = tz)
  }

})

test_that("1d arrays treated as vectors", {
  df <- data.frame(x = 1)
  df$x <- array(1, 1)

  #1d arrays converted into vectors
  df2 <- rbind.fill(df, df)
  expect_that(df2$x, is_equivalent_to(rbind(df, df)$x))
  expect_that(dim(df2$x), equals(dim(rbind(df, df)$x)))

  #if dims are stripped, dimnames should be also
  df <- data.frame(x = 1)
  df$x <- array(2, 1, list(x="one"))
  df2 <- rbind.fill(df, df)
  expect_null(dimnames(df2$x))

  #can bind 1d array to vector
  dfV <- data.frame(x=3)
  dfO1 <- rbind.fill(df, dfV)
  dfO2 <- rbind.fill(dfV, df)
  expect_equal(dfO1, data.frame(x=c(2, 3)))
  expect_equal(dfO2, data.frame(x=c(3, 2)))
})

test_that("multidim arrays ok", {
  library(abind)
  df <- data.frame(x = 1:3)
  df$x <- array(1:27, c(3,3,3))

  df2 <- rbind.fill(df, df)
  expect_equal(dim(df2$x), dim(abind(along=1, df$x, df$x)))
  expect_that(df2$x, is_equivalent_to(abind(along=1, df$x, df$x)))
 })

test_that("Array column names preserved", {
  x <- data.frame(hair.color = dimnames(HairEyeColor)[[1]])
  x$obs <- unclass(HairEyeColor[,,1])

  xx1 <- rbind(x, x)
  xx2 <- rbind.fill(x, x)

  #plyr is against row names, but should respect col names like rbind
  rownames(xx1) <- NULL
  rownames(xx1$obs) <- NULL

  #but unlike rbind it should also preserve names-of-dimnames.
  names(dimnames(xx1$obs)) <- c("", "Eye")

  expect_equal(xx1, xx2)
})

test_that("attributes are preserved", {
  d1 <- data.frame(a = runif(10), b = runif(10))
  d2 <- data.frame(a = runif(10), b = runif(10))

  attr(d1$b, "foo") <- "one"
  attr(d1$b, "bar") <- "bar"
  attr(d2$b, "foo") <- "two"
  attr(d2$b, "baz") <- "baz"

  d12 <- rbind.fill(d1, d2)
  d21 <- rbind.fill(d2, d1)

  expect_that(attr(d12$b, "foo"), equals("one"))
  expect_that(attr(d21$b, "foo"), equals("two"))
})

test_that("characters override and convert factors", {
  d1a <- data.frame(x=c('a','b'), y=1:2)
  d2a <- data.frame(x=c('c','d'), z=1:2, stringsAsFactors=F)

  d1b <- data.frame(x=c('a','b'), y=1:2, stringsAsFactors=F)
  d2b <- data.frame(x=c('c','d'), z=1:2)

  d3a <- rbind.fill(d1a,d2a)
  d3b <- rbind.fill(d1b,d2b)

  expect_equal(d3a$x, c("a", "b", "c", "d"))
  expect_equal(d3b$x, c("a", "b", "c", "d"))
})

test_that("factor to character conversion preserves attributes", {
  d1 <- data.frame(a = letters[1:10], b = factor(letters[11:20]),
                   stringsAsFactors=FALSE)
  d2 <- data.frame(a = factor(letters[11:20]), b = letters[11:20],
                   stringsAsFactors=FALSE)

  attr(d1$a, "foo") <- "one"
  attr(d1$b, "foo") <- "two"
  attr(d2$a, "foo") <- "bar"
  attr(d2$b, "foo") <- "baz"

  d12 <- rbind.fill(d1, d2)

  expect_equal(attr(d12$a, "foo"), "one")
  expect_equal(attr(d12$b, "foo"), "two")
})

test_that("zero row data frames ok", {
  d1 <- data.frame(x = 1:2, y = 2:3)
  d2 <- data.frame(y = 3:4, z = 5:6)

  za <- rbind.fill(subset(d1, FALSE))
  zb <- rbind.fill(d1, subset(d2, FALSE))
  zc <- rbind.fill(subset(d1, FALSE), subset(d2, FALSE))

  expect_equal(class(za), "data.frame")
  expect_equal(nrow(za), 0)
  expect_true(all(names(za) %in% c("x", "y")))

  expect_equal(class(zb), "data.frame")
  expect_equal(nrow(zb), 2)
  expect_true(all(names(zb) %in% c("x", "y", "z")))
  expect_equal(zb$y, d1$y)
  expect_equal(zb$z, rep(as.numeric(NA), nrow(d1)))

  expect_equal(class(zc), "data.frame")
  expect_equal(nrow(zc), 0)
  expect_true(all(names(zc) %in% c("x", "y", "z")))
})

test_that("zero col data frames ok", {
  d1 <- data.frame(x = "a", y = 1L)
  d2 <- data.frame(y = 2L, z = 3L)

  za <- rbind.fill(d1[0, ], d2[0, ])
  zb <- rbind.fill(d1[0, ], d2)
  zc <- rbind.fill(d1, d2[0, ])

  expect_equal(names(za), c("x", "y", "z"))
  expect_equal(names(zb), c("x", "y", "z"))
  expect_equal(names(zc), c("x", "y", "z"))

  expect_equal(nrow(za), 0)
  expect_equal(nrow(zb), 1)
  expect_equal(nrow(zc), 1)
})

test_that("rbind.fill rejects non-vector columns", {
  a <- list(a=list(1), b=c(3), c="d", f=function() NULL)
  attr(a, "row.names") <- c(NA_integer_, -1)
  class(a) <- "data.frame"
  expect_error(rbind.fill(a,a), "cannot make")
})

test_that("rbind.fill rejects data frame columns", {
  a <- data.frame(a=1:3, b=2:4, c=3:5)
  a$c <- data.frame(x=10:12, y=11:13)
  rownames(a) <- NULL
  rownames(a$c) <- NULL
  expect_error(rbind.fill(a,a), "not supported")
})

rbind_time <- function(size,
                       classes = c("numeric", "character",
                                   "array", "factor", "time")) {
  unit <- quickdf(list(numeric = 1:3,
                       character = c("a", "b", "c"),
                       array = array(1:6, c(3,2)),
                       factor = factor(c("a", "b", "c")),
                       time = as.POSIXct(Sys.time()) + 1:3))
  args <- rep(list(unit[classes]), size)
  system.time(do.call(rbind.fill, args))
}

get_rbind_times <- function(...) {
  # nolint start
  rbind_time(10) #warm up/JIT
  mdply(.fun = rbind_time, ...)
  # nolint end
}

if (identical(Sys.getenv("NOT_CRAN"), "true") &&
    !identical(Sys.getenv("TRAVIS"), "true")) {

expect_linear_enough <- function(timings, threshold=0.1) {
  #expect that no more than `threshold` of a `size` input's runtime is
  #accounted for by quadratic behavior
  model <- lm(I(user.self / size) ~ size, timings)
  expect_lt(threshold, summary(model)$coefficients[2,4])
}

test_that("rbind.fill performance linear", {
  timings <- get_rbind_times(data.frame(size = 2 ^ (1:10)),
                             classes=c("numeric", "character", "array"))
  expect_linear_enough(timings)
})

test_that("rbind.fill performance linear with factors", {
  timings <- get_rbind_times(data.frame(size = 2 ^ (1:10)),
                             classes=c("factor"))
  expect_linear_enough(timings)
})

test_that("rbind.fill performance linear with times", {
  timings <- get_rbind_times(data.frame(size = 2 ^ (1:10)),
                             classes=c("time"))
  expect_linear_enough(timings)
})

test_that("NULLs silently dropped", {
  expect_equal(rbind.fill(mtcars, NULL), mtcars)
  expect_equal(rbind.fill(NULL, mtcars), mtcars)
  expect_equal(rbind.fill(NULL, NULL), NULL)

})

}

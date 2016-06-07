context("Arrays")

test_that("incorrect result dimensions raise errors", {
  fs <- list(
    function(x) rep(x, sample(10, 1)),
    function(x) if (x < 5) x else matrix(x, 2, 2),
    function(x) as.list(rep(x, sample(10, 1))),
    function(x) if (x < 5) list(x) else matrix(list(x), 2, 2)
  )

  expect_that(laply(1:10, fs[[1]]), throws_error("same dim"))
  expect_that(laply(1:10, fs[[2]]), throws_error("same number"))
  expect_that(laply(1:10, fs[[3]]), throws_error("same dim"))
  expect_that(laply(1:10, fs[[4]]), throws_error("same number"))
})

test_that("incompatible result types raise errors", {
  f <- function(x) if (x < 5) c(x, x) else as.list(x)

  expect_that(laply(1:10, f), throws_error("compatible type"))
})

test_that("zero length margin operates on whole object", {
  a <- array(1:24, 2:4)

  expect_that(alply(a, NULL, sum)[[1]], equals(sum(1:24)))
})

test_that("results must have positive dimensions", {
  expect_that(
    aaply(matrix(0,2,2), 2, function(x) NULL),
    throws_error("one or more dimensions"))
})


test_that("simple operations equivalent to vectorised form", {
  expect_that(laply(1:10, mean), is_equivalent_to(1:10))
  expect_that(laply(1:10, sqrt), is_equivalent_to(sqrt(1:10)))
})

test_that("array binding is correct", {
  library(abind)
  f <- function(x) matrix(x, 2, 2)
  m2d <- lapply(1:10, f)
  m3d <- abind(m2d, along = 0)

  expect_that(laply(1:10, f), is_equivalent_to(m3d))

  f <- function(x) array(x, c(2, 2, 2))
  m3d <- lapply(1:10, f)
  m4d <- abind(m3d, along = 0)

  expect_that(laply(1:10, f), is_equivalent_to(m4d))
})

test_that("array binding of lists is correct", {
  #this is identical to the previous test but in list mode
  f <- function(x) matrix(as.list(x), 2, 2)
  m2d <- lapply(1:10, f)
  #as abind itself doesn't do lists...
  m3d <- aperm(array(do.call(c, m2d), c(2, 2, 10)), c(3,1,2))

  expect_that(laply(1:10, f), is_equivalent_to(m3d))
  f <- function(x) array(as.list(x), c(2, 2, 2))
  m3d <- lapply(1:10, f)
  m4d <- aperm(array(do.call(c, m3d), c(2, 2, 2, 10)), c(4, 1, 2, 3))

  expect_that(laply(1:10, f), is_equivalent_to(m4d))
})

# Basis of test contributed by anonymous reviewer.
test_that("idempotent function equivalent to permutation",  {
  x <- array(1:24, 4:2,
    dimnames = list(LETTERS[1:4], letters[24:26], letters[1:2]))

  perms <- unique(alply(as.matrix(subset(expand.grid(x=0:3,y=0:3,z=0:3),
                                         (x + y + z) > 0 & !any(duplicated(setdiff(c(x,y,z), 0))))),
                        1,
                        function(x) setdiff(x, 0)))

  aperms <- llply(perms, function(perm) aperm(x, unique(c(perm, 1:3))))
  aaplys <- llply(perms, function(perm) aaply(x, perm, identity))

  for (i in seq_along(aperms)) {
    perm <- paste(perms[[i]], collapse = ", ")
    expect_that(dim(aaplys[[i]]), equals(dim(aperms[[i]])), perm)
    expect_that(unname(dimnames(aaplys[[i]])), equals(dimnames(aperms[[i]])),
      perm)
    expect_that(aaplys[[i]], is_equivalent_to(aperms[[i]]), perm)
  }

})

test_that("alply sets dims and dimnames, equivalence to permutation", {
  x <- array(1:24, 4:2,
             dimnames = list(dim1=LETTERS[1:4], dim2=letters[c(24,26,25)], dim3=NULL))
  #unlisting an alply should leave elements the the same order as
  #an aperm with the unused dimensions shifted to the front.
  #check against all ways to split this array
  p_alply <- unique(alply(as.matrix(subset(expand.grid(x=0:3,y=0:3,z=0:3),
                                         (x + y + z) > 0 & !any(duplicated(setdiff(c(x,y,z), 0))))),
                        1, function(x) setdiff(x, 0)))
  p_aperm <- llply(p_alply, function(x) union(setdiff(1:3, x), x))
  alplys <- lapply(p_alply, alply, .data=x, identity, .dims = TRUE)
  #alply will fill in dimnames on a dim that has none, so match that here
  dimnames(x)[[3]] <- c("1", "2")
  aperms <- llply(p_aperm, .fun=aperm, a=x)

  m_ply(cbind(x_perm=p_alply, x_ply=alplys, x_aperm=aperms),
        function(x_perm, x_ply, x_aperm) {
          expect_equivalent(dim(x_ply),
                            dim(x)[x_perm])
          expect_equivalent(dimnames(x_ply),
                            dimnames(x)[x_perm])
          expect_equivalent(dim(x_ply),
                            dim(x_aperm)[(length(dim(x)) - length(x_perm) + 1):(length(dim(x)))])
          expect_equivalent(as.vector(unlist(x_ply)), as.vector(x_aperm))
  })
})

# Test contributed by Baptiste Auguie
test_that("single column data frames work when treated as an array", {
  foo <- function(a="a", b="b", c="c", ...){
    paste(a, b, c, sep="")
  }

  df <- data.frame(b=1:2)
  res <- adply(df, 1, splat(foo))

  expect_that(res$b, equals(1:2))
  expect_that(as.character(res$V1), equals(c("a1c", "a2c")))
})

test_that("aaply equivalent to apply with correct permutation", {
  a <- matrix(seq_len(400), ncol = 20)
  expect_equivalent(rowMeans(a), aaply(a, 1, mean))
  expect_equivalent(colMeans(a), aaply(a, 2, mean))

  b <- structure(a, dimnames = amv_dimnames(a))
  expect_equivalent(rowMeans(b), aaply(b, 1, mean))
  expect_equivalent(colMeans(b), aaply(b, 2, mean))
})

test_that("array reconstruction correct with missing cells", {
  df <- data.frame(i = rep(1:3, each = 12), j = rep(1:3, each = 4), v = 1:36)
  df <- subset(df, i != j)

  da <- daply(df, .(i, j), function(q) sum(q$v))
  dd <- ddply(df, .(i, j), summarise, v1 = sum(v))

  m <- matrix(NA, 3, 3)
  m[cbind(dd$i, dd$j)] <- dd$v1

  expect_that(da, equals(m, check.attributes = FALSE))
})


set_dimnames <- function(x, nm) {
  dimnames(x) <- nm
  x
}

test_that("array names do not affect output", {
  base <- array(1:48, dim = c(12, 4))
  arrays <- list(
    none = base,
    numeric = set_dimnames(base, list(R = 1:12, C = 1:4)),
    numeric_rev = set_dimnames(base, list(R = 12:1, C = 4:1)),
    alpha = set_dimnames(base, list(R = letters[1:12], C = LETTERS[1:4])),
    alpha_rev = set_dimnames(base, list(R = letters[12:1], C = LETTERS[4:1]))
  )

  for (name in names(arrays)) {
    array <- arrays[[name]]
    expect_that(aaply(array, 1, sum),
      equals(rowSums(array), check.attributes = FALSE), info = name)
    expect_that(aaply(array, 2, sum),
      equals(colSums(array), check.attributes = FALSE), info = name)
  }

})

test_that("no support for duplicate names (#211)", {

  n <- function(x) {
    setNames(x, letters[c(1:9,2)])
  }
  B <- list(X=n(1:10), Y=n(11:20), Z=n(21:30))
  expect_warning(laply(B, identity), "Duplicate names")

  AB <- c('a', 'b', 'a', 'b')
  ABCD <- c('a', 'b', 'c', 'd')
  ar <-  array(rep(rep(rep(1:4, 4), 4), 2), dim=c(4, 4, 2), dimnames=list(ABCD, ABCD, c('i', 'ii')))
  ar[,,2] <- ar[,,2]+4
  dimnames(ar)[1:2] <- list(AB, AB)

  if (getRversion() >= "3.4.0") {
    expect_error(aaply(ar, 3, identity), "duplicated")
  } else {
    expect_warning(aaply(ar, 3, identity), "Duplicate names")
  }
})

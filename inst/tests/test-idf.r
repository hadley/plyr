context("Immutable")

# Create smaller subset of baseball data (for speed)
bsmall <- subset(baseball, id %in% sample(unique(baseball$id), 20))[, 1:5]
bsmall$id <- factor(bsmall$id)
bsmall <- bsmall[sample(rownames(bsmall)),  ]
rownames(bsmall) <- NULL

test_that("idf is immutable", {
  #Since idf are constructed by scratch in both idata.frame and `[.idf]`
  #I will test idf objects created both ways.

  #create both before testing any, to make sure that subsetting
  #doesn't change the subsetted idf
  idf <- idata.frame(bsmall)
  x <- idf[1:10, ]
  y <- bsmall[1:10, ]

  expect_error(x[1,"year"] <- 1994)
  expect_error(x[["stint"]] <- rev(y[["stint"]]))
  expect_error(x$team <- sort(y$team))
  expect_error(names(idf) <- c("ID", "YR", "ST", "TM", "LG"))

  expect_error(idf[1,"year"] <- 1994)
  expect_error(idf[["stint"]] <- rev(bsmall[["stint"]]))
  expect_error(idf$team <- sort(bsmall$team))
  expect_error(names(idf) <- c("ID", "YR", "ST", "TM", "LG"))
})

test_that("idf subset by [i]", {
  idf <- idata.frame(bsmall)

  x <- idf[3]
  y <- bsmall[3]

  expect_equal(idf[[2]], bsmall[[2]])
  expect_equal(x[[1]], y[[1]])
})

test_that("idf subset data by [i,j]", {
  idf <- idata.frame(bsmall)

  x <- idf[1:10, ]
  y <- bsmall[1:10, ]

  xx <- x[3:5, c('id', 'team')]
  yy <- y[3:5, c('id', 'team')]

  xxx <- idf[ , names(idf)]
  yyy <- idf[ , names(y)]

  expect_equal(idf[3, "year"], bsmall[[3, "year"]])
  expect_equal(x[, "year"], y[, "year"])
  expect_equal(xx[, "id"], yy[, "id"])
  expect_equal(xxx[, "team"], yyy[, "team"])
})

test_that("idf extract by [[i]]", {
  idf <- idata.frame(bsmall)

  x <- idf[6:20,]
  y <- bsmall[6:20,]

  expect_equal(x[[4]], y[[4]])
  expect_equal(idf[[3]], bsmall[[3]])
  expect_equal(idf[["year"]], bsmall[["year"]])
})

test_that("idf extract $name", {
  idf <- idata.frame(bsmall)

  x <- idf[500:510,]
  y <- bsmall[500:510,]

  expect_equal(x$team, y$team)
  expect_equal(idf$team, bsmall$team)
})

test_that("idf as environment", {
  idf <- idata.frame(bsmall)

  x <- idf[5:10,]
  y <- bsmall[5:10,]

  expect_equal(with(x, mean(year)), with(y, mean(year)))
  expect_equal(with(idf, table(team)), with(bsmall, table(team)))
})

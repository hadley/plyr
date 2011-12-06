context("Join")

# Create smaller subset of baseball data (for speed)
bsmall <- subset(baseball, id %in% sample(unique(baseball$id), 20))[, 1:5]
bsmall$id <- factor(bsmall$id)
bsmall <- bsmall[sample(rownames(bsmall)),  ]
rownames(bsmall) <- NULL

first <- ddply(bsmall, "id", summarise, first = min(year))

test_that("results consistent with merge", {  
  b2 <- merge(bsmall, first, by = "id", all.x = TRUE)
  b3 <- join(bsmall, first, by = "id")
  b4 <- join(first, bsmall, by = "id")[names(b3)]
  
  b2 <- arrange(b2, id, year, stint)
  b3 <- arrange(b3, id, year, stint)
  b4 <- arrange(b4, id, year, stint)
  
  expect_that(b2, equals(b3))
  expect_that(b2, equals(b4))
})

test_that("order is preserved", {
  b3 <- join(bsmall, first, by = "id")

  expect_that(bsmall$id, equals(b3$id))
  expect_that(bsmall$year, equals(b3$year))
  expect_that(bsmall$stint, equals(b3$stint))  
})

test_that("rownames are preserved", {
  b3 <- join(bsmall, first, by = "id")
  expect_that(rownames(b3), equals(rownames(bsmall)))
})

test_that("duplicated keys are duplicated", {
  x <- data.frame(a = c("a", "b"), b = c("a", "b"))
  y <- data.frame(a = c("a", "a"), z = c(1, 2))
  
  left <- join(x, y, by = "a")
  expect_that(nrow(left), equals(3))
  expect_that(left$z, equals(c(1, 2, NA)))
  
  inner <- join(x, y, by = "a", type = "inner")
  expect_that(nrow(inner), equals(2))
  expect_that(inner$z, equals(c(1, 2)))
})

test_that("full merge preserves x and y", {
  a <- data.frame(x = 1:10, a = 1:10)
  b <- data.frame(x = 11:15, b = 1:5)
  
  ab <- join(a, b, by = "x", type = "full")
  expect_that(names(ab), equals(c("x", "a", "b")))
  expect_that(ab$x, equals(1:15))
  expect_that(ab$a, equals(c(1:10, rep(NA, 5))))
  expect_that(ab$b, equals(c(rep(NA, 10), 1:5)))    
})

test_that("left and right are equivalent", {
  d1 <- data.frame(a = 1:3, b = 1:3)
  d2 <- data.frame(a = 1:4, c = 1:4)

  right <- join(d1, d2, type="right", by = "a")
  left <- join(d2, d1, type="left", by = "a")
  expect_that(left[c("a", "b" ,"c")], equals(right[c("a", "b" ,"c")]))

  right <- join(d1, d2, type="right", by = "a", match = "first")
  left <- join(d2, d1, type="left", by = "a", match = "first")
  expect_that(left[c("a", "b" ,"c")], equals(right[c("a", "b" ,"c")]))

})


test_that("large number of columns work", {
  df1 <- data.frame(matrix(1:100, ncol = 50), y = 1:2)
  df2 <- data.frame(matrix(1:100, ncol = 50), z = 3:4)
  
  df <- join(df1, df2)
  expect_that(df$y, equals(1:2))
  expect_that(df$z, equals(3:4))
  
})

test_that("many potential combinations works", {
  factor_n <- function(m, n) {
    factor(sample(n, m, rep = T), levels = seq_len(n))
  }
  df1 <- as.data.frame(replicate(20, factor_n(100, 100)))
  df2 <- as.data.frame(replicate(20, factor_n(100, 100)))

  j <- join(df1, df2)
  j <- merge(df1, df2, all.x = TRUE)
  
  
})
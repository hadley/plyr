context("Join")

a <- data.frame(a = 1:10, b = letters[1:10])
a_even <- a[seq(2, 10, by = 2), ]
a_odd <- a[seq(1, 9, by = 2), ]
b <- data.frame(a = 1:10, c = LETTERS[1:10])
b_even <- b[seq(2, 10, by = 2), ]
b_odd <- b[seq(1, 9, by = 2), ]

# Create smaller subset of baseball data (for speed)
bsmall <- subset(baseball, id %in% sample(unique(baseball$id), 20))[, 1:5]
bsmall$id <- factor(bsmall$id)
bsmall <- bsmall[sample(rownames(bsmall)),  ]
rownames(bsmall) <- NULL

first <- ddply(bsmall, "id", summarise, first = min(year))

test_that("results consistent with merge", {  
  b2 <- merge(bsmall, first, by = "id", all.x = TRUE)
  b3 <- join(bsmall, first, by = "id")
  
  b2 <- arrange(b2, id, year, stint)
  b3 <- arrange(b3, id, year, stint)
  rownames(b2) <- NULL
  rownames(b3) <- NULL
  
  expect_that(b2, equals(b3))
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

test_that("duplicated keys are an error", {
  
  
})

test_that("left join preserves y", {
  
})

context("Informative messages")

test_that(".inform parameter works for all l?ply functions", {
  funcnames <- ls(name = asNamespace("plyr"), pattern = "^l[^i]ply$")

  old_options <- options(show.error.messages = FALSE)
  on.exit(options(old_options), add = TRUE)

  input <- 1:10
  for (funcname in funcnames) {
    func <- get(funcname, asNamespace("plyr"))
    expect_error(func(input, function(...) stop("qq"), .inform = TRUE), "piece 1", info = funcname)
  }
})

test_that(".inform parameter works for all d?ply functions", {
  funcnames <- ls(name = asNamespace("plyr"), pattern = "^d[^i]ply$")

  old_options <- options(show.error.messages = FALSE)
  on.exit(options(old_options), add = TRUE)

  input <- data.frame(a = 1:10)
  for (funcname in funcnames) {
    func <- get(funcname, asNamespace("plyr"))
    expect_error(func(input, .(), function(...) stop("qq"), .inform = TRUE), "piece 1", info = funcname)
  }
})

test_that(".inform parameter works for all a?ply functions", {
  funcnames <- ls(name = asNamespace("plyr"), pattern = "^a[^i]ply$")

  old_options <- options(show.error.messages = FALSE)
  on.exit(options(old_options), add = TRUE)

  input <- data.frame(a = 1:10)
  for (funcname in funcnames) {
    func <- get(funcname, asNamespace("plyr"))
    expect_error(func(input, 1, function(...) stop("qq"), .inform = TRUE), "piece 1", info = funcname)
  }
})

test_that(".inform parameter works for all m?ply functions", {
  funcnames <- ls(name = asNamespace("plyr"), pattern = "^m[^i]ply$")

  old_options <- options(show.error.messages = FALSE)
  on.exit(options(old_options), add = TRUE)

  input <- data.frame(a = 1:10)
  for (funcname in funcnames) {
    func <- get(funcname, asNamespace("plyr"))
    expect_error(func(input, function(...) stop("qq"), .inform = TRUE), "piece 1", info = funcname)
  }
})

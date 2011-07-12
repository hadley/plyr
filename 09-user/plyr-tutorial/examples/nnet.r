library(nnet)
library(ggplot2)

w <- read.csv("wiggly.csv")
qplot(x, y, data = w, colour = class)
ggsave("nnet-example.pdf", width = 6, height = 6)

# Quick function to compute the accuracy of nnet predictions - the number of
# correct predictions divided by the total number of observations
accuracy <- function(mod, true) {
  pred <- factor(predict(mod, type = "class"), levels = levels(true))
  tb <- table(pred, true)
  sum(diag(tb)) / sum(tb)
}


# nnet uses a gradient descent method which is critical dependent on starting
# values.  This means it's always a good idea to try multiple random starts
nnet(class ~ x + y, data = w, size = 3)
nnet(class ~ x + y, data = w, size = 3)
nnet(class ~ x + y, data = w, size = 3)
nnet(class ~ x + y, data = w, size = 3)

# rlply makes this easy to do.  The arguments are a little different (but
# a similar flavour) to the other plyr methods: the first argument is the
# number of runs to do, and the second argument is an _expression_ to
# evaluate.  This works in a similar way to replicate, but as with all plyr
# methods you can choose the output type: rdply, rlply, raply.
models <- rlply(50, nnet(class ~ x + y, data = w, size = 3, trace = FALSE))

accdf <- ldply(models, "accuracy", true = w$class)
accdf
qplot(accuracy, data = accdf, binwith = 0.02)

# What if we also want to experiment with some of the parameters of the
# function.  We'll first turn the above code into a function, so we don't need
# to keep typing out the same stuff.
wiggly_nnet <- function(...) {
  nnet(class ~ x + y, data = w, trace = FALSE, ...)
}
rlply(5, wiggly_nnet(size = 3))

# We then create a data frame of the options we'd like to try.  
opts <- data.frame(size = 1:10, maxiter = 50)

# m*ply calls the function once with each row of the data frame, supplying
# the columns as arguments to the function: nnet(size = 1, maxiter = 50),
# nnet(size = 2, maxiter = 50), ..., nnet(size = 10, maxiter = 50)
models <- mlply(opts, wiggly_nnet)
ldply(models, "accuracy", true = w$class)

# Of course we really want to combine both rlply and mlply for this example
acc <- rdply(20, ldply(mlply(opts[1:5,], wiggly_nnet), "accuracy", true = w$class))
qplot(accuracy, data = acc, binwidth = 0.02, facets = ~ size)

# expand.grid() is useful if we want to try all parameter combinations

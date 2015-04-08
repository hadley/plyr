

```r
library(magrittr)

l <- lintr::lint_package()
```

```
## ............................................................................................
```

```r
l %>%
  as.data.frame %>%
  mutate(linter = gsub("'[^']*'", "''", message)) %>%
  count("linter") %>%
  arrange(-freq) %>%
  knitr::kable()
```



|linter                                                            | freq|
|:-----------------------------------------------------------------|----:|
|Place a space before left parenthesis, except in a function call. |    9|

```r
l
```

```
## R/each.r:51:21: style: Place a space before left parenthesis, except in a function call.
##       res <- fs[[1]](x, ...)
##                     ^
## R/each.r:68:46: style: Place a space before left parenthesis, except in a function call.
##         for (i in 1:n) result[[i]] <- fs[[i]](x, ...)
##                                              ^
## R/each.r:71:45: style: Place a space before left parenthesis, except in a function call.
##         for (i in 1:n) proto[[i]] <- fs[[i]](x, ...)
##                                             ^
## R/here.r:24:39: style: Place a space before left parenthesis, except in a function call.
##   call <- substitute(function(...) (f)(...), list(f = f))
##                                       ^
## R/id.r:51:14: style: Place a space before left parenthesis, except in a function call.
##     res <- c((mat - 1L) %*% combs + 1L)
##              ^
## R/rbind-fill.r:70:21: style: Place a space before left parenthesis, except in a function call.
##       setters[[var]](rng, df[[var]])
##                     ^
## tests/testthat/test-rbind.r:289:50: style: Place a space before left parenthesis, except in a function call.
##   timings <- get_rbind_times(data.frame(size = 2^(1:10)),
##                                                  ^
## tests/testthat/test-rbind.r:295:50: style: Place a space before left parenthesis, except in a function call.
##   timings <- get_rbind_times(data.frame(size = 2^(1:10)),
##                                                  ^
## tests/testthat/test-rbind.r:301:50: style: Place a space before left parenthesis, except in a function call.
##   timings <- get_rbind_times(data.frame(size = 2^(1:10)),
##                                                  ^
```


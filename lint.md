

```r
library(magrittr)
library(plyr)

l <- lintr::lint_package()
```

```
## ............................................................................................
```

```r
l %>%
  as.data.frame %>%
  count("linter") %>%
  arrange(-freq) %>%
  knitr::kable()
```



|linter               | freq|
|:--------------------|----:|
|spaces_inside_linter |    1|

```r
l %>%
  as.data.frame %>%
  count("linter") %>%
  arrange(-freq) %>%
  with(sprintf("with_defaults(\n  %s\n)", paste(sprintf("%s # %s", linter, freq), collapse = "\n  , "))) %>%
  cat
```

```
## with_defaults(
##   spaces_inside_linter # 1
## )
```

```r
l
```

```
## R/id.r:34:13: style: Do not place spaces around code in parentheses or square brackets.
##     res <- c( (mat - 1L) %*% combs + 1L)
##             ^
```


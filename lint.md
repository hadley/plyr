

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



|linter                                | freq|
|:-------------------------------------|----:|
|Trailing blank lines are superfluous. |    1|

```r
l
```

```
## R/RcppExports.R:36:1: style: Trailing blank lines are superfluous.
## 
## ^
```




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



|linter | freq|
|:------|----:|

```r
l
```


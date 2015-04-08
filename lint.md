

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



|linter | freq|
|:------|----:|

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
##   
## )
```

```r
l
```


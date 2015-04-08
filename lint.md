

```r
library(magrittr)
exclude_linters <- c(
  "single_quotes_linter", # 52
  "camel_case_linter", # 36
  "line_length_linter", # 26
  "infix_spaces_linter", # 24
  "spaces_left_parentheses_linter", # 20
  "closed_curly_linter", # 10
  "open_curly_linter" # 9
)

exclude_linter_indexes <- match(exclude_linters, names(lintr::default_linters))

l <- lintr::lint_package(linters=lintr::default_linters[-exclude_linter_indexes])
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


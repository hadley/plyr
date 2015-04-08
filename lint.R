library(magrittr)
library(plyr)

l <- lintr::lint_package()
l %>%
  as.data.frame %>%
  count("linter") %>%
  arrange(-freq) %>%
  knitr::kable()

l

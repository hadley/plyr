library(magrittr)
library(plyr)

l <- lintr::lint_package()
l %>%
  as.data.frame %>%
  count("linter") %>%
  arrange(-freq) %>%
  knitr::kable()

l %>%
  as.data.frame %>%
  count("linter") %>%
  arrange(-freq) %>%
  with(sprintf("with_defaults(\n  %s\n)", paste(sprintf("%s # %s", linter, freq), collapse = "\n  , "))) %>%
  cat

l

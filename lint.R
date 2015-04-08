library(magrittr)
l <- lintr::lint_package()
#l <- lintr::lint_package(linters=lintr::default_linters[c(-2,-7,-12,-16,-5,-8,-11,-10,-17)])
l %>%
  as.data.frame %>%
  mutate(linter = gsub("'[^']*'", "''", message)) %>%
  count("linter") %>%
  arrange(-freq) %>%
  knitr::kable()

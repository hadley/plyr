

```r
library(magrittr)
l <- lintr::lint_package()
```

```
## ............................................................................................
```

```r
#l <- lintr::lint_package(linters=lintr::default_linters[c(-2,-7,-12,-16,-5,-8,-11,-10,-17)])
l %>%
  as.data.frame %>%
  mutate(linter = gsub("'[^']*'", "''", message)) %>%
  count("linter") %>%
  arrange(-freq) %>%
  knitr::kable()
```



|linter                                                                                              | freq|
|:---------------------------------------------------------------------------------------------------|----:|
|Only use double-quotes.                                                                             |   52|
|Variable and function names should be all lowercase.                                                |   36|
|lines should not be more than 80 characters.                                                        |   26|
|Trailing whitespace is superfluous.                                                                 |   26|
|Put spaces around all infix operators.                                                              |   24|
|Place a space before left parenthesis, except in a function call.                                   |   20|
|Closing curly-braces should always be on their own line, unless it's followed by an else.           |   10|
|Opening curly braces should never go on their own line and should always be followed by a new line. |    9|
|local variable '' assigned but may not be used                                                      |    7|
|Trailing blank lines are superfluous.                                                               |    7|
|no visible global function definition for ''                                                        |    4|
|Variable and function names should not be longer than 30 characters.                                |    2|
|Words within variable and function names should be separated by '' rather than ''.                  |    2|
|no visible binding for global variable ''                                                           |    1|


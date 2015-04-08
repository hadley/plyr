

```r
library(magrittr)
exclude_linters <- c(
  "single_quotes_linter", # 52
  "camel_case_linter", # 36
  "line_length_linter", # 26
  "trailing_whitespace_linter", # 26
  "infix_spaces_linter", # 24
  "spaces_left_parentheses_linter", # 20
  "closed_curly_linter", # 10
  "open_curly_linter", # 9
  "trailing_blank_lines_linter" # 7
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



|linter                                                                             | freq|
|:----------------------------------------------------------------------------------|----:|
|local variable '' assigned but may not be used                                     |    7|
|no visible global function definition for ''                                       |    4|
|Variable and function names should not be longer than 30 characters.               |    2|
|Words within variable and function names should be separated by '' rather than ''. |    2|
|no visible binding for global variable ''                                          |    1|

```r
l
```

```
## R/data-frame.r:17:3: warning: local variable 'name' assigned but may not be used
##   name <- deparse(substitute(x))
##   ^~~~
## R/each.r:46:3: warning: local variable 'proto' assigned but may not be used
##   proto <- NULL
##   ^~~~~
## R/each.r:47:3: warning: local variable 'result' assigned but may not be used
##   result <- NULL
##   ^~~~~~
## R/join.r:84:5: warning: local variable 'new.cols' assigned but may not be used
##     new.cols <- setdiff(names(x), by)
##     ^~~~~~~~
## R/join.r:117:5: warning: local variable 'new.cols' assigned but may not be used
##     new.cols <- setdiff(names(x), by)
##     ^~~~~~~~
## R/progress.r:161:15: warning: no visible global function definition for 'winProgressBar'
##       win <<- winProgressBar(max = x, title = title, ...)
##               ^~~~~~~~~~~~~~
## R/progress.r:162:7: warning: no visible global function definition for 'setWinProgressBar'
##       setWinProgressBar(win, 0)
##       ^~~~~~~~~~~~~~~~~
## R/progress.r:166:7: warning: no visible global function definition for 'setWinProgressBar'
##       setWinProgressBar(win, n)
##       ^~~~~~~~~~~~~~~~~
## R/progress-time.r:27:12: warning: local variable '.last_update_time' assigned but may not be used
##   start <- .last_update_time <- proc.time()[3]
##            ^~~~~~~~~~~~~~~~~
## R/progress-time.r:28:3: warning: local variable 'times' assigned but may not be used
##   times <- numeric(n)
##   ^~~~~
## R/summarise.r:38:67: style: Words within variable and function names should be separated by '_' rather than '.'.
##     names <- unname(unlist(lapply(match.call(expand.dots = FALSE)$`...`, deparse)))
##                                                                   ^~~~~
## R/utils-functional.r:14:46: style: Words within variable and function names should be separated by '_' rather than '.'.
##   match.call(def, call, expand.dots = FALSE)$`...`
##                                              ^~~~~
## tests/testthat/test-quote.r:30:15: style: Variable and function names should not be longer than 30 characters.
##  q <- .(foo = barjasdfgjadhfgjsdhfgusdhfgusheguisdhguioahsrofasdgsdfgsdfg +
##               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## tests/testthat/test-quote.r:31:15: style: Variable and function names should not be longer than 30 characters.
##               dfgafgasdfgsdfgsdfgsdfgsdfgsdfgsdfg)
##               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## tests/testthat/test-rbind.r:269:3: warning: no visible global function definition for 'rbind_time'
##   rbind_time(10) #warm up/JIT
##   ^~~~~~~~~~
## tests/testthat/test-rbind.r:270:16: warning: no visible binding for global variable 'rbind_time'
##   mdply(.fun = rbind_time, ...)
##                ^~~~~~~~~~
```


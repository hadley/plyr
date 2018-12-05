# plyr

<!-- badges: start -->
[![Lifecycle: retired](https://img.shields.io/badge/lifecycle-retired-orange.svg)](https://www.tidyverse.org/lifecycle/#retired)
[![CRAN status](https://www.r-pkg.org/badges/version/plyr)](https://cran.r-project.org/package=plyr)
[![Travis build status](https://travis-ci.org/hadley/plyr.svg?branch=master)](https://travis-ci.org/hadley/plyr)
[![Codecov test coverage](https://codecov.io/gh/hadley/plyr/branch/master/graph/badge.svg)](https://codecov.io/gh/hadley/plyr?branch=master)
<!-- badges: end -->

plyr is a set of tools for a common set of problems: you need to __split__ up a big data structure into homogeneous pieces, __apply__ a function to each piece and then __combine__ all the results back together. For example, you might want to:

  * fit the same model each patient subsets of a data frame
  * quickly calculate summary statistics for each group
  * perform group-wise transformations like scaling or standardising

It's already possible to do this with base R functions (like split and the apply family of functions), but plyr makes it all a bit easier with:

  * totally consistent names, arguments and outputs
  * convenient parallelisation through the foreach package
  * input from and output to data.frames, matrices and lists
  * progress bars to keep track of long running operations
  * built-in error recovery, and informative error messages
  * labels that are maintained across all transformations

Considerable effort has been put into making plyr fast and memory efficient, and in many cases plyr is as fast as, or faster than, the built-in equivalents.

A detailed introduction to plyr has been published in JSS: "The Split-Apply-Combine Strategy for Data Analysis", http://www.jstatsoft.org/v40/i01/. You can find out more at http://had.co.nz/plyr/, or track development at http://github.com/hadley/plyr. You can ask questions about plyr (and data manipulation in general) on the plyr mailing list. Sign up at http://groups.google.com/group/manipulatr.

## Status [![Lifecycle: retired](https://img.shields.io/badge/lifecycle-retired-orange.svg)](https://www.tidyverse.org/lifecycle/#retired)

plyr is retired: this means only changes necessary to keep it on CRAN will be made. We recommend using [dplyr](http://dplyr.tidyverse.org/) (for data frames) or [purrr](http://purrr.tidyverse.org/) (for lists) instead.


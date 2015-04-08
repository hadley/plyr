[![Build Status](https://travis-ci.org/hadley/plyr.png?branch=master)](https://travis-ci.org/hadley/plyr) [![Coverage Status](https://coveralls.io/repos/hadley/plyr/badge.svg?branch=master)](https://coveralls.io/r/hadley/plyr?branch=master)

# plyr

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

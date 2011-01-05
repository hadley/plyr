# plyr

<img src="pliers.jpg" width="369" height="137" align="right" />

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

Considerable effort has been put into making plyr fast and memory efficient, and in many cases plyr is as fast as, or faster than, the built-in functions.

If you are interested in the watching the development of plyr, please see the [development site](http://github.com/hadley/plyr) on [github](http://github.com)

## 2009 plyr tutorial

All course materials are [available online](09-user/).

## How to install

The current version of plyr is __1.4__ and is available from (CRAN)[http://cran.r-project.org/web/packages/plyr/] so you can install it using the following R command:

    install.packages("plyr")

## Documentation<

The best place to start is the introductory guide: [plyr: divide and conquer](plyr-intro-090510.pdf)</a>.  (Updated May 10, 2009).

## Mailing list

You are welcome to ask plyr questions on R-help, but if you'd like to participate in a more focussed mailing list, please sign up for the manipulatr mailing list:

<form action="http://groups.google.com/group/manipulatr/boxsubscribe">
  Your email address: <input type="text" name="email"> <input type="submit" value="Subscribe">
</form>

You must be a member to post messages, but anyone can [read the archived discussions](http://groups.google.com/group/manipulatr).

## Get involved

If you've discovered any bugs in the plyr package, or you have thought of a killer new feature, please email me: [h.wickham@gmail.com](mailto:h.wickham@gmail.com.
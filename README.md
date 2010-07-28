plyr is a set of tools for a common set of problems: you need to break down a big data structure into manageable pieces, operate on each piece and then put all the pieces back together.  For example, you might want to:

  * fit the same model to subsets of a data frame
  * quickly calculate summary statistics for each group
  * perform group-wise transformations like scaling or standardising

It's already possible to do this with built-in functions (like split and the apply functions), but plyr just makes it all a bit easier with:

  * totally consistent names, arguments and outputs
  * input from and output to data.frames, matrices and lists
  * progress bars to keep track of long running operations
  * built-in error recovery, and informative error messages

Some considerable effort has been put into making plyr fast and memory efficient, and in many cases plyr is as fast, or faster than, the built-in functions.

You can find out more at http://had.co.nz/plyr/, including a 20 page introductory guide, http://had.co.nz/plyr/plyr-intro.pdf.  You can ask questions about plyr (and data-manipulation in general) on the plyr mailing list. Sign up at http://groups.google.com/group/manipulatr

## Changes

This is a minor update to:

* Use namespace best practices

* Fix an error in a C function - I suspect this is what was causing crashes
  in the ggplot2 and failures with UBSAN, but I couldn't reliably reproduce
  locally. The code was clearly incorrect, and the new behaviour should be
  better.

## Test environments

* local OS X install, R 3.1.2
* ubuntu 12.04 (on travis-ci), R 3.1.2
* win-builder (devel and release)

## R CMD check results

There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* My email address has changed from <h.wickham@gmail.com> to 
  <hadley@rstudio.com>. I'll send the confirmation from my old email
  shortly.

* checking dependencies in R code ... NOTE
  Namespace in Imports field not imported from: 'R6'

  R6 is a build-time dependency.

## Downstream dependencies
I have also run R CMD check on downstream dependencies of plyr 
(https://github.com/hadley/plyr/tree/master/revdep). All packages 
that I could install passed except:


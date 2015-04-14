## Changes

This is a minor update. It includes:

* Fixes for R CMD check notes.

* Some small backward compatible changes.

* Fix an error in a C function - I suspect this is what was causing crashes
  in the ggplot2 and failures with UBSAN, but I couldn't reliably reproduce
  locally. The code was clearly incorrect, and the new behaviour should be
  better.

## Test environments

* local OS X install, R 3.1.3
* ubuntu 12.04 (on travis-ci), R 3.1.3
* win-builder (devel and release)

## R CMD check results

There were no ERRORs or WARNINGs. 

There was one NOTE:

* My email address has changed from <h.wickham@gmail.com> to 
  <hadley@rstudio.com>. I'll send the confirmation from my old email
  shortly.

## Downstream dependencies
I have also run R CMD check on downstream dependencies of plyr 
(https://github.com/hadley/plyr/tree/master/revdep). I have noted ERRORs and 
WARNINGs below - I do not believe them to be related to changes to plyr:

* abd: fails to unload lattice.
* ChemoSpec: example requires suggested package (and binary for that package is 
  not available on the mac)
* mlr: fails in same way on CRAN.
* mosaic: fails after web request. Fails in same way on CRAN.
* RSiteCatalyst: fails with authentication error.

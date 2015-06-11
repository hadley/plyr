## Changes

This works around what I believe is a PROTECTion in Rcpp: `loop_apply` was occassionally returning random data.

## Test environments

* local OS X install, R 3.2.0
* ubuntu 12.04 (on travis-ci), R 3.2.0
* win-builder (devel and release)

## R CMD check results

There were no ERRORs, WARNINGs or NOTEs. 

## Downstream dependencies
I have also run R CMD check on all 312 downstream dependencies of plyr 
(https://github.com/hadley/plyr/tree/master/revdep). I have noted ERRORs and 
WARNINGs below - I do not believe them to be related to changes to plyr:

* abd: fails to unload lattice.
* ChemoSpec: example requires suggested package (and binary for that package is 
  not available on the mac)
* mlr: fails in same way on CRAN.
* mosaic: fails after web request. Fails in same way on CRAN.
* RSiteCatalyst: fails with authentication error.

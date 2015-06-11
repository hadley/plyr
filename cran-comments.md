## Changes

* Work around a PROTECTion failure in Rcpp
* Fix a test failure on R-devel.

## Test environments

* local OS X install, R 3.2.0
* ubuntu 12.04 (on travis-ci), R 3.2.0
* win-builder (devel and release)

## R CMD check results

There were no ERRORs, WARNINGs or NOTEs. 

## Downstream dependencies
I have also run R CMD check on all 312 downstream dependencies of plyr 
(https://github.com/hadley/plyr/tree/master/revdep). I have noted ERRORs below.
Given the minimal change to plyr, I do not believe these errors to be a result
of changes to plyr.

* caretEnsemble
* ChemoSpec: example fails with missing suggested package
* dataRetrieval
* gemtc: missing system dependency
* ggmap: existing CRAN failure
* mlr: appears to be NAMESPACE problem
* pxweb: appears to be web connectivity problem
* REDCapR: auth failure
* RSiteCatalyst: auth failure

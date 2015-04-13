## Changes

This is a minor update to:

* Use namespace best practices

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

There was two NOTEs:

* My email address has changed from <h.wickham@gmail.com> to 
  <hadley@rstudio.com>. I'll send the confirmation from my old email
  shortly.

* BD, Becton and plyr are not misspellings.

## Downstream dependencies
I have also run R CMD check on downstream dependencies of plyr 
(https://github.com/hadley/plyr/tree/master/revdep). All packages 
that I could install passed except:

* NAT: the error occurs in a test "we can read neuron from remote url", which
  suggests it's an interim failure (plus it only occur once in the 3+ times
  I ran the revdep checks)
  
* RSiteCatalyst: appears to be authentication related.


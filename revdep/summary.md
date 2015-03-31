# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.1.3 (2015-03-09) |
|system   |x86_64, darwin13.4.0         |
|ui       |RStudio (0.99.362)           |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |America/Chicago              |

## Packages

|package    |*  |version |date       |source         |
|:----------|:--|:-------|:----------|:--------------|
|abind      |*  |1.4-3   |2015-03-13 |CRAN (R 3.1.3) |
|doParallel |*  |1.0.8   |2014-02-28 |CRAN (R 3.1.2) |
|foreach    |*  |1.4.2   |2014-04-11 |CRAN (R 3.1.2) |
|iterators  |*  |1.0.7   |2014-04-11 |CRAN (R 3.1.2) |
|itertools  |*  |0.1-3   |2014-03-12 |CRAN (R 3.1.2) |
|Rcpp       |*  |0.11.5  |2015-03-06 |CRAN (R 3.1.3) |
|testthat   |   |0.9.1   |2014-10-01 |CRAN (R 3.1.2) |

# Check results
289 checked out of 290 dependencies 

## abctools (1.0)
Maintainer: Matt Nunes <m.nunes@lancaster.ac.uk>

```
checking whether package ‘abctools’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/RtmpaTGn9N/check_cran3da26de4b7c3/abctools.Rcheck/00install.out’ for details.
```

## abd (0.2-7)
Maintainer: Kevin M. Middleton <middletonk@missouri.edu>

__OK__

## acs (1.2)
Maintainer: Ezra Haber Glenn <eglenn@mit.edu>

```
checking R code for possible problems ... NOTE
geo.lookup: no visible binding for global variable ‘fips.state’
geo.lookup: no visible binding for global variable
  ‘fips.county.subdivision’
geo.lookup: no visible binding for global variable ‘fips.school’
geo.make : .geo.unit.make: no visible binding for global variable
  ‘fips.american.indian.area’
geo.make : .geo.unit.make: no visible binding for global variable
  ‘fips.state’
geo.make : .geo.unit.make: no visible binding for global variable
  ‘fips.county’
geo.make : .geo.unit.make: no visible binding for global variable
  ‘fips.county.subdivision’
geo.make : .geo.unit.make: no visible binding for global variable
  ‘fips.place’
geo.make : .geo.unit.make: no visible binding for global variable
  ‘fips.school’
```

## afex (0.13-145)
Maintainer: Henrik Singmann <singmann+afex@gmail.com>

__OK__

## aLFQ (1.3.2)
Maintainer: George Rosenberger <rosenberger@imsb.biol.ethz.ch>

```
checking whether package ‘aLFQ’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/RtmpaTGn9N/check_cran3da26de4b7c3/aLFQ.Rcheck/00install.out’ for details.
```

## alm (0.4.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: http://www.github.com/ropensci/alm/issues

__OK__

## AntWeb (0.7)
Maintainer: 'Karthik Ram' <karthik.ram@gmail.com>  
Bug reports: https://github.com/ropensci/AntWeb/issues

__OK__

## AppliedPredictiveModeling (1.1-6)
Maintainer: Max Kuhn <mxkuhn@gmail.com>

```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘ellipse’ ‘lattice’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
bookTheme: no visible global function definition for ‘trellis.par.set’
transparentTheme: no visible global function definition for
  ‘trellis.par.set’
upperp: no visible global function definition for ‘ellipse’
upperp: no visible global function definition for ‘panel.xyplot’
upperp: no visible global function definition for ‘trellis.par.get’
```

## aqp (1.8)
Maintainer: Dylan Beaudette <debeaudette@ucdavis.edu>

```
checking package dependencies ... NOTE
Packages suggested but not available for checking: ‘soilDB’ ‘compositions’
```
```
checking examples ... ERROR
Running examples in ‘aqp-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: addVolumeFraction
> ### Title: Symbolize Volume Fraction on a Soil Profile Collection Plot
> ### Aliases: addVolumeFraction
> ### Keywords: ~kwd1
> 
> ### ** Examples
> 
> # sample data
> data(loafercreek, package='soilDB')
Error in find.package(package, lib.loc, verbose = verbose) : 
  there is no package called ‘soilDB’
Calls: data -> find.package
Execution halted
```

## ARPobservation (1.1)
Maintainer: James E. Pustejovsky <jepusto@gmail.com>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'Observation-algorithms.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## ARTool (0.9.3)
Maintainer: Matthew Kay <mjskay@uw.edu>  
Bug reports: https://github.com/mjskay/ARTool/issues/new

__OK__

## bams (1.6)
Maintainer: Toby Dylan Hocking <toby@sg.cs.titech.ac.jp>

```
checking package dependencies ... NOTE
Packages suggested but not available for checking: ‘GLAD’ ‘DNAcopy’ ‘gada’
```
```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘DNAcopy’ ‘GLAD’ ‘cghseg’ ‘changepoint’ ‘gada’ ‘grid’ ‘proto’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
Missing or unexported object: ‘ggplot2::coord_transform’
Unexported objects imported by ':::' calls:
  ‘cghseg:::segmeanCO’ ‘ggplot2:::GeomRect’
  See the note in ?`:::` about the use of this operator.
```
```
checking R code for possible problems ... NOTE
dnacopy.smoothvec : <anonymous>: no visible global function definition
  for ‘smooth.CNA’
dnacopy.smoothvec : <anonymous>: no visible global function definition
  for ‘segment’
dnacopy.smoothvec : <anonymous>: no visible binding for global variable
  ‘segment’
gada.results : <anonymous> : <anonymous>: no visible global function
  definition for ‘WextIextToSegments’
geom_tallrect: no visible global function definition for ‘proto’
geom_tallrect : draw_groups: no visible global function definition for
  ‘unit’
run.pelt: no visible binding for global variable ‘cpt.mean’
runglad: no visible global function definition for ‘as.profileCGH’
runglad : <anonymous>: no visible binding for global variable ‘daglad’
runglad : <anonymous> : <anonymous>: no visible binding for global
  variable ‘glad’
```
```
checking line endings in Makefiles ... NOTE
Found the following Makefile(s) without a final LF:
  inst/article/Makefile
Some ‘make’ programs ignore lines not ending in LF.
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'redoing-the-article.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## BatchExperiments (1.4.1)
Maintainer: Michel Lang <michellang@gmail.com>  
Bug reports: https://github.com/tudo-r/BatchExperiments/issues

```
checking dependencies in R code ... NOTE
Unexported objects imported by ':::' calls:
  ‘BatchJobs:::addIntModulo’ ‘BatchJobs:::buffer’
  ‘BatchJobs:::checkDir’ ‘BatchJobs:::checkId’ ‘BatchJobs:::checkIds’
  ‘BatchJobs:::checkPart’ ‘BatchJobs:::createShardedDirs’
  ‘BatchJobs:::dbConnectToJobsDB’ ‘BatchJobs:::dbCreateJobStatusTable’
  ‘BatchJobs:::dbDoQuery’ ‘BatchJobs:::dbFindDone’
  ‘BatchJobs:::dbFindRunning’ ‘BatchJobs:::dbRemoveJobs’
  ‘BatchJobs:::dbSelectWithIds’ ‘BatchJobs:::getJobDirs’
  ‘BatchJobs:::getJobInfoInternal’ ‘BatchJobs:::getKillJob’
  ‘BatchJobs:::getListJobs’ ‘BatchJobs:::getRandomSeed’
  ‘BatchJobs:::getResult’ ‘BatchJobs:::isRegistryDir’
  ‘BatchJobs:::makeRegistryInternal’ ‘BatchJobs:::saveRegistry’
  ‘BatchJobs:::seeder’ ‘BatchJobs:::syncRegistry’
  See the note in ?`:::` about the use of this operator.
```

## bayesGDS (0.6.1)
Maintainer: Michael Braun <braunm@smu.edu>

__OK__

## bayesPop (5.2-2)
Maintainer: Hana Sevcikova <hanas@uw.edu>

__OK__

## bcpa (1.1)
Maintainer: Eliezer Gurarie <eliezg@uw.edu>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: Rcpp
Loading required package: plyr
Warning in plot.xy(xy.coords(x, y), type = type, ...) :
  plot type 'black' will be truncated to first character
Warning in plot.xy(xy.coords(x, y), type = type, ...) :
  plot type 'black' will be truncated to first character
Warning in replayPlot(x) :
  plot type 'black' will be truncated to first character
Warning in replayPlot(x) :
  plot type 'black' will be truncated to first character
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'bcpa.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## bdvis (0.1.0)
Maintainer: Vijay Barve <vijay.barve@gmail.com>

__OK__

## bear (2.6.4)
Maintainer: Yung-jin Lee <mobilepk@gmail.com>

```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘plyr’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```

## benchmark (0.3-6)
Maintainer: Manuel J. A. Eugster <manuel@mjae.net>

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘Rgraphviz’
```
```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘multcomp’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
boxplot.AlgorithmPerformance: no visible binding for global variable
  ‘algorithms’
boxplot.AlgorithmPerformance: no visible binding for global variable
  ‘value’
boxplot.AlgorithmPerformance: no visible binding for global variable
  ‘samples’
bsgraph0.dist: no visible global function definition for ‘addEdge’
bsgraph0.graphNEL: no visible global function definition for
  ‘getDefaultAttrs’
bsgraph0.graphNEL: no visible global function definition for ‘agopen’
densityplot.AlgorithmPerformance: no visible binding for global
  variable ‘value’
densityplot.AlgorithmPerformance: no visible binding for global
  variable ‘algorithms’
mi: no visible global function definition for ‘mi.plugin’
patch.relation_class_ids: no visible global function definition for
  ‘relation_is_strict_weak_order’
plot.DatasetCharacterization: no visible binding for global variable
  ‘characteristics’
plot.DatasetCharacterization: no visible binding for global variable
  ‘value’
plot.DatasetCharacterization: no visible binding for global variable
  ‘samples’
plot.TestResult: no visible binding for global variable ‘samples’
plot.TestResult: no visible binding for global variable ‘value’
stripchart.AlgorithmPerformance: no visible binding for global variable
  ‘algorithms’
stripchart.AlgorithmPerformance: no visible binding for global variable
  ‘value’
stripchart.AlgorithmPerformance: no visible binding for global variable
  ‘samples’
```
```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘graph’
```

## BEQI2 (2.0-0)
Maintainer: Dennis Walvoort <dennis.Walvoort@wur.nl>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
For more information on the usage of the BEQI2 tool, type: vignette("BEQI2")
Number of duplicated records: 1
These will be removed
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'BEQI2.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## Biograph (2.0.4)
Maintainer: Frans Willekens <willekens@demogr.mpg.de>

__OK__

## biom (0.3.12)
Maintainer: Paul J. McMurdie <mcmurdie@stanford.edu>  
Bug reports: https://github.com/joey711/biom/issues

__OK__

## bmk (1.0)
Maintainer: Matthew Krachey <matthewkrachey@yahoo.com>

```
checking dependencies in R code ... NOTE
'library' or 'require' calls to packages already attached by Depends:
  ‘coda’ ‘functional’ ‘plyr’
  Please remove these calls from your code.
Packages in Depends field not imported from:
  ‘coda’ ‘functional’ ‘plyr’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
bmkconverge: no visible global function definition for ‘Compose’
bmksensitive: no visible global function definition for ‘Compose’
bmksummary: no visible global function definition for ‘Compose’
bmksummary: no visible global function definition for ‘Curry’
bmksummary: no visible global function definition for ‘mcmc’
bmksummary: no visible global function definition for ‘mcmc.list’
bmksummary: no visible global function definition for ‘effectiveSize’
bmksummary: no visible global function definition for ‘gelman.diag’
```

## bold (0.2.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/bold/issues

__OK__

## boottol (2.0)
Maintainer: Garrett Schiltgen <garrett.schiltgen@gmail.com>

__OK__

## broom (0.3.6)
Maintainer: David Robinson <admiral.david@gmail.com>  
Bug reports: http://github.com/dgrtwo/broom/issues

__OK__

## BSGS (1.0)
Maintainer: Kuo-Jung Lee <kuojunglee@mail.ncku.edu.tw>

__OK__

## BTSPAS (2014.0901)
Maintainer: Carl J Schwarz <cschwarz@stat.sfu.ca>

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘BRugs’
```
```
checking whether package ‘BTSPAS’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/RtmpaTGn9N/check_cran3da26de4b7c3/BTSPAS.Rcheck/00install.out’ for details.
```

## caret (6.0-41)
Maintainer: Max Kuhn <Max.Kuhn@pfizer.com>

```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘MASS’ ‘earth’ ‘fastICA’ ‘ipred’ ‘klaR’ ‘nnet’ ‘pROC’ ‘party’ ‘proxy’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Attaching package: ‘pROC’

The following objects are masked from ‘package:stats’:

    cov, smooth, var


Attaching package: ‘pls’

The following object is masked from ‘package:caret’:

    R2

The following object is masked from ‘package:stats’:

    loadings

Loading required package: klaR
Loading required package: MASS
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'caret.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## caretEnsemble (1.0.0)
Maintainer: Zachary A. Mayer <zach.mayer@gmail.com>  
Bug reports: https://github.com/zachmayer/caretEnsemble/issues

__OK__

## cda (1.5.1)
Maintainer: Baptiste Auguie <baptiste.auguie@gmail.com>

```
checking package dependencies ... ERROR
Package required but not available: ‘RcppArmadillo’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## CDM (4.2-12)
Maintainer: Alexander Robitzsch <a.robitzsch@bifie.at>

```
checking package dependencies ... ERROR
Packages required but not available: ‘WrightMap’ ‘RcppArmadillo’

Package suggested but not available for checking: ‘BIFIEsurvey’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## chemosensors (0.7.8)
Maintainer: Andrey Ziyatdinov <andrey.ziyatdinov@upc.edu>

```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘doMC’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```

## ChemoSpec (4.0.1)
Maintainer: Bryan A. Hanson <hanson@depauw.edu>  
Bug reports: https://github.com/bryanhanson/ChemoSpec/issues

```
checking package dependencies ... NOTE
Packages suggested but not available for checking:
  ‘speaq’ ‘clusterCrit’ ‘NbClust’ ‘js’ ‘exCon’
```
```
checking examples ... ERROR
Running examples in ‘ChemoSpec-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: clupaSpectra
> ### Title: Conduct Hierarchical Cluster-Based Peak Alignment on a Spectra
> ###   Object
> ### Aliases: clupaSpectra
> ### Keywords: utilities
> 
> ### ** Examples
> 
> data(alignMUD)
> plotSpectra(alignMUD, which = 1:20, lab.pos = 4.5, offset = 0.1,
+ 	yrange = c(0, 1900), amp = 500, xlim = c(1.5, 1.8),
+ 	main = "Misaligned NMR Spectra (alignMUD)")
> aMUD <- clupaSpectra(alignMUD)
Error in clupaSpectra(alignMUD) : 
  You need to install package speaq to use this function
Execution halted
```

## classifly (0.4)
Maintainer: Hadley Wickham <h.wickham@gmail.com>

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘rggobi’
```
```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘rggobi’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```

## classify (1.3)
Maintainer: Dr Chris Wheadon <chris.wheadon@gmail.com>

```
checking whether package ‘classify’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/RtmpaTGn9N/check_cran3da26de4b7c3/classify.Rcheck/00install.out’ for details.
```

## clhs (0.5-4)
Maintainer: Pierre Roudier <roudierp@landcareresearch.co.nz>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Warning: attributes are not identical across measure variables; they will be dropped
Warning: attributes are not identical across measure variables; they will be dropped
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'vignette.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## clickstream (1.1.3)
Maintainer: Michael Scholz <michael.scholz@uni-passau.de>

__OK__

## clusterfly (0.4)
Maintainer: Hadley Wickham <h.wickham@gmail.com>

```
checking package dependencies ... ERROR
Packages required but not available: ‘rggobi’ ‘RGtk2’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## coefplot (1.2.0)
Maintainer: Jared P. Lander <packages@jaredlander.com>

```
checking DESCRIPTION meta-information ... NOTE
Deprecated license: BSD
```

## confidence (1.1-0)
Maintainer: Dennis J. J. Walvoort <dennis.Walvoort@wur.nl>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: tcltk

For more information on the usage of the Confidence tool, type:
vignette("confidence")
Examples of input files can be found in:
'/private/tmp/RtmpaTGn9N/check_cran3da26de4b7c3/confidence.Rcheck/confidence/extdata'
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'confidence.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## cpca (0.1.2)
Maintainer: Andrey Ziyatdinov <andrey.ziyatdinov@upc.edu>

__OK__

## CPMCGLM (1.1)
Maintainer: Jeremie Riou <jeremie.riou@isped.u-bordeaux2.fr>

__OK__

## cshapes (0.4-2)
Maintainer: Nils B. Weidmann <nils.weidmann@uni-konstanz.de>

```
checking installed package size ... NOTE
  installed size is  5.3Mb
  sub-directories of 1Mb or more:
    shp   5.2Mb
```

## d3Network (0.5.2.1)
Maintainer: Christopher Gandrud <christopher.gandrud@gmail.com>  
Bug reports: https://github.com/christophergandrud/d3Network/issues

__OK__

## data.table (1.9.4)
Maintainer: Matt Dowle <mdowle@mdowle.plus.com>  
Bug reports: https://github.com/Rdatatable/data.table/issues

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'datatable-faq.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## dataRetrieval (2.1.2)
Maintainer: Laura DeCicco <ldecicco@usgs.gov>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'dataRetrieval.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## dcmr (1.0)
Maintainer: Diane Losardo <dlosardo@amplify.com>

__OK__

## decctools (0.2.0)
Maintainer: James Keirstead <j.keirstead@imperial.ac.uk>

__OK__

## Deducer (0.7-7)
Maintainer: Ian Fellows <ian@fellstat.com>

__OK__

## demi (1.1.2)
Maintainer: Sten Ilmjarv <sten.ilmjarv@gmail.com>

```
checking package dependencies ... ERROR
Packages required but not available: ‘affxparser’ ‘affy’ ‘oligo’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## dendextend (0.18.3)
Maintainer: Tal Galili <tal.galili@gmail.com>  
Bug reports: https://github.com/talgalili/dendextend/issues

```
checking package dependencies ... NOTE
Package which this enhances but not available for checking: ‘labeltodendro’
```
```
checking Rd cross-references ... NOTE
Packages unavailable to check Rd xrefs: ‘WGCNA’, ‘distory’, ‘moduleColor’
```

## DescribeDisplay (0.2.4)
Maintainer: Di Cook <dicook@iastate.edu>

```
checking DESCRIPTION meta-information ... NOTE
Deprecated license: BSD
```
```
checking top-level files ... NOTE
Non-standard files/directories found at top level:
  ‘ggobi-xml’ ‘load.r’ ‘write-xml.rnw’
```
```
checking dependencies in R code ... NOTE
Package in Depends field not imported from: ‘proto’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```

## discreteRV (1.1.4)
Maintainer: Eric Hare <erichare@iastate.edu>

__OK__

## dostats (1.3.1)
Maintainer: Andrew Redd <Andrew.Redd@hsc.utah.edu>

```
checking R code for possible problems ... NOTE
Table1: no visible global function definition for ‘idata.frame’
copy_names: no visible global function definition for ‘dlply’
depth: no visible global function definition for ‘laply’
dseval_fork: no visible global function definition for ‘dlply’
dseval_left.dostats.formula.bind: no visible global function definition
  for ‘llply’
dseval_right.dostats.formula.bind: no visible global function
  definition for ‘llply’
dseval_right.dostats.formula.bind: no visible global function
  definition for ‘laply’
dseval_right.dostats.formula.by_two_fun: no visible global function
  definition for ‘llply’
dseval_right.dostats.formula.nest: no visible global function
  definition for ‘llply’
dseval_right.dostats.formula.nest: no visible global function
  definition for ‘laply’
find_headers.hdf: no visible global function definition for ‘llply’
find_headers.hdf: no visible global function definition for ‘laply’
find_headers.list: no visible global function definition for ‘llply’
find_headers.list: no visible global function definition for ‘laply’
format.hdf: no visible global function definition for ‘llply’
get_vars.dostats.formula.bind: no visible global function definition
  for ‘llply’
get_vars.dostats.formula.nest: no visible global function definition
  for ‘llply’
hdf: no visible global function definition for ‘llply’
hdf: no visible global function definition for ‘laply’
is_uniform: no visible global function definition for ‘laply’
listrows: no visible global function definition for ‘mlply’
make_pmat: no visible global function definition for ‘laply’
make_ppath: no visible global function definition for ‘llply’
parse_bind: no visible global function definition for ‘llply’
parse_by_two_fun: no visible global function definition for ‘llply’
parse_nest: no visible global function definition for ‘llply’
rbind.hdf: no visible global function definition for ‘llply’
rbind.hdf: no visible global function definition for ‘laply’
rbind.hdf : <anonymous>: no visible global function definition for
  ‘llply’
take_names.default: no visible global function definition for ‘llply’
trace_parents: no visible global function definition for ‘llply’
unroll: no visible global function definition for ‘llply’
```

## dropR (0.1)
Maintainer: Matthias Bannert <bannert@kof.ethz.ch>

__OK__

## dynsurv (0.2-2)
Maintainer: Jun Yan <jun.yan@uconn.edu>

__OK__

## EBMAforecast (0.42)
Maintainer: Jacob Montgomery <jacob.montgomery@wustl.edu>

```
checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘Hmisc’ ‘abind’ ‘ensembleBMA’ ‘methods’ ‘plyr’ ‘separationplot’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
plot,FDatFitLogit: no visible binding for global variable ‘y’
plot,FDatFitNormal: no visible binding for global variable ‘y’
```

## ecoengine (1.9.1)
Maintainer: Karthik Ram <karthik.ram@gmail.com>  
Bug reports: https://github.com/ropensci/ecoengine/issues

__OK__

## eeptools (0.3.1)
Maintainer: Jared E. Knowles <jknowles@gmail.com>

```
checking R code for possible problems ... NOTE
moves_calc: no visible binding for global variable ‘id’
```

## EIAdata (0.0.3)
Maintainer: Matthew Brigida <matt@complete-markets.com>

__OK__

## emdatr (0.2)
Maintainer: Gopi Goteti <my.ration.shop@gmail.com>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: emdatr
Loading required package: RCurl
Loading required package: bitops
Loading required package: ggplot2
Loading required package: plyr
downloading data from bitbucket. might take a few moments...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'emdatr.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## emdbook (1.3.7)
Maintainer: Ben Bolker <bolker@mcmaster.ca>

__OK__

## enigma (0.1.1)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropengov/enigma/issues

__OK__

## EpiContactTrace (0.8.8)
Maintainer: Stefan Widgren <stefan.widgren@sva.se>

```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘animation’ ‘ggmap’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
Animate : create_map: no visible global function definition for ‘ggmap’
Animate : create_map: no visible global function definition for
  ‘geom_segment’
Animate : create_map: no visible global function definition for
  ‘aes_string’
Animate : create_map: no visible global function definition for ‘labs’
Animate : create_map: no visible global function definition for
  ‘ggtitle’
Animate : create_map: no visible global function definition for
  ‘ani.pause’
Animate: no visible global function definition for ‘saveHTML’
```

## eurostat (1.0.16)
Maintainer: Lahti Leo <louhos@googlegroups.com>  
Bug reports: https://github.com/ropengov/eurostat/issues

__OK__

## extracat (1.7-1)
Maintainer: Alexander Pilhoefer <alexander.pilhoefer@math.uni-augsburg.de>

__OK__

## ez (4.2-2)
Maintainer: Michael A. Lawrence <mike.lwrnc@gmail.com>

__OK__

## ezsim (0.5.5)
Maintainer: TszKin Julian Chan <ctszkin@gmail.com>  
Bug reports: TszKin Julian Chan <ctszkin@gmail.com>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'vignette.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## FAOSTAT (1.9)
Maintainer: Filippo Gheri <filippo.gheri@fao.org>

```
checking data for non-ASCII characters ... NOTE
  Note: found 178 marked UTF-8 strings
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'FAOSTAT.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## fishmove (0.3-1)
Maintainer: Johannes Radinger <jradinger@igb-berlin.de>

__OK__

## freqweights (1.0.1)
Maintainer: Emilio Torres-Manzanera <torres@uniovi.es>

__OK__

## fSRM (0.6.1)
Maintainer: Felix Schönbrodt <felix@nicebread.de>

__OK__

## gcbd (0.2.5)
Maintainer: Dirk Eddelbuettel <edd@debian.org>

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘gputools’
```
```
checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘RSQLite’ ‘lattice’ ‘plyr’ ‘reshape’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
createDatabase: no visible global function definition for ‘dbDriver’
createDatabase: no visible global function definition for
  ‘dbBuildTableDefinition’
createDatabase: no visible global function definition for ‘dbConnect’
createDatabase: no visible global function definition for ‘dbGetQuery’
createDatabase: no visible global function definition for
  ‘dbDisconnect’
databaseResult: no visible global function definition for ‘dbConnect’
databaseResult: no visible global function definition for ‘dbDriver’
databaseResult: no visible global function definition for
  ‘dbWriteTable’
databaseResult: no visible global function definition for
  ‘dbDisconnect’
figure_Lattice: no visible global function definition for ‘melt’
figure_Lattice: no visible global function definition for
  ‘trellis.par.get’
figure_Lattice: no visible global function definition for
  ‘trellis.par.set’
figure_LatticeByArch: no visible global function definition for ‘melt’
figure_LatticeByArch: no visible global function definition for
  ‘trellis.par.get’
figure_LatticeByArch: no visible global function definition for
  ‘trellis.par.set’
figure_LogLogIntercept: no visible global function definition for
  ‘trellis.par.get’
figure_LogLogIntercept: no visible global function definition for
  ‘trellis.par.set’
figure_LogLogLattice: no visible global function definition for ‘melt’
figure_LogLogLattice: no visible global function definition for
  ‘trellis.par.get’
figure_LogLogLattice: no visible global function definition for
  ‘trellis.par.set’
figure_LogLogSlopes: no visible global function definition for
  ‘trellis.par.get’
figure_LogLogSlopes: no visible global function definition for
  ‘trellis.par.set’
getBenchmarkData: no visible global function definition for ‘dbConnect’
getBenchmarkData: no visible global function definition for ‘dbDriver’
getBenchmarkData: no visible global function definition for
  ‘dbGetQuery’
getBenchmarkData: no visible global function definition for
  ‘dbDisconnect’
loglogAnalysis: no visible global function definition for ‘dbConnect’
loglogAnalysis: no visible global function definition for ‘dbDriver’
loglogAnalysis: no visible global function definition for ‘dbGetQuery’
loglogAnalysis: no visible global function definition for
  ‘dbDisconnect’
loglogAnalysis: no visible global function definition for ‘ddply’
loglogAnalysis: no visible global function definition for ‘melt’
luBenchmark: no visible global function definition for ‘lu’
matmultBenchmarkgputools: no visible global function definition for
  ‘gpuMatMult’
qrBenchmarkgputools: no visible global function definition for ‘gpuQr’
svdBenchmarkgputools: no visible global function definition for
  ‘gpuSvd’
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: RSQLite
Loading required package: DBI
Loading required package: plyr
Loading required package: reshape

Attaching package: ‘reshape’

The following objects are masked from ‘package:plyr’:

    rename, round_any

Loading required package: lattice
Warning in packageDescription("gputools") :
  no package 'gputools' was found
Error: processing vignette 'gcbd.Rnw' failed with diagnostics:
at gcbd.Rnw:860, subscript out of bounds
Execution halted

```

## gcookbook (1.0)
Maintainer: Winston Chang <winston@stdout.org>

__OK__

## GDELTtools (1.2)
Maintainer: Stephen R. Haptonstahl <srh@haptonstahl.org>

```
checking dependencies in R code ... NOTE
Package in Depends field not imported from: ‘tools’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
IsValidGDELT: no visible global function definition for ‘md5sum’
```

## gdm (1.0)
Maintainer: Matthew C. Fitzpatrick <mfitzpatrick@al.umces.edu>

__OK__

## gems (1.0.0)
Maintainer: Luisa Salazar Vizcaya <luisa.salazar@ispm.unibe.ch>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'gems.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## geospt (1.0-1)
Maintainer: Al� Santacruz <amsantac@unal.edu.co>

__OK__

## gfcanalysis (1.2)
Maintainer: Alex Zvoleff <azvoleff@conservation.org>  
Bug reports: https://github.com/azvoleff/gfcanalysis/issues

```
checking package dependencies ... ERROR
Packages required but not available: ‘rgdal’ ‘rgeos’ ‘rasterVis’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## GGally (0.5.0)
Maintainer: Barret Schloerke <schloerke@gmail.com>

__OK__

## ggenealogy (0.1.0)
Maintainer: Lindsay Rutter <lrutter@iastate.edu>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Warning in .Call("R_igraph_get_shortest_paths", graph, as.igraph.vs(graph,  :
  At structural_properties.c:740 :Couldn't reach some vertices
Warning: There is no path between those two vertices
Warning in loop_apply(n, do.ply) :
  Removed 39 rows containing missing values (geom_segment).
Warning in loop_apply(n, do.ply) :
  Removed 39 rows containing missing values (geom_text).
Warning in loop_apply(n, do.ply) :
  Removed 39 rows containing missing values (geom_segment).
Warning in loop_apply(n, do.ply) :
  Removed 39 rows containing missing values (geom_text).
Warning in loop_apply(n, do.ply) :
  Removed 39 rows containing missing values (geom_segment).
Warning in loop_apply(n, do.ply) :
  Removed 39 rows containing missing values (geom_text).
Warning in loop_apply(n, do.ply) :
  Removed 39 rows containing missing values (geom_segment).
Warning in loop_apply(n, do.ply) :
  Removed 39 rows containing missing values (geom_text).
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'ggenealogy.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## ggmap (2.4)
Maintainer: David Kahle <david.kahle@gmail.com>  
Bug reports: https://github.com/dkahle/ggmap/issues

__OK__

## ggparallel (0.1.1)
Maintainer: Heike Hofmann <hofmann@iastate.edu>

```
checking DESCRIPTION meta-information ... NOTE
License components which are templates and need '+ file LICENSE':
  MIT
```
```
checking top-level files ... NOTE
Non-standard file/directory found at top level:
  ‘ggparallel.Rproj’
```
```
checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘ggplot2’ ‘plyr’ ‘reshape2’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
ggparallel : getRibbons: no visible global function definition for
  ‘melt’
ggparallel : getRibbons: no visible global function definition for
  ‘geom_ribbon’
ggparallel : getRibbons: no visible global function definition for
  ‘aes’
ggparallel : getRibbons: no visible binding for global variable ‘id’
ggparallel : getRibbons: no visible global function definition for
  ‘ddply’
ggparallel : getRibbons: no visible global function definition for ‘.’
ggparallel : getRibbons: no visible global function definition for
  ‘geom_line’
ggparallel : getRibbons: no visible global function definition for
  ‘scale_size’
ggparallel : getRibbons: no visible binding for global variable
  ‘summarise’
ggparallel: no visible global function definition for ‘melt’
ggparallel: no visible global function definition for ‘ddply’
ggparallel: no visible global function definition for ‘.’
ggparallel: no visible binding for global variable ‘summarize’
ggparallel: no visible global function definition for ‘geom_text’
ggparallel: no visible global function definition for ‘aes’
ggparallel: no visible global function definition for ‘theme’
ggparallel: no visible global function definition for ‘ggplot’
ggparallel: no visible global function definition for ‘geom_bar’
ggparallel: no visible global function definition for ‘xlab’
ggparallel: no visible global function definition for
  ‘scale_x_discrete’
```
```
checking Rd line widths ... NOTE
Rd file 'genes.Rd':
  \examples lines wider than 100 characters:
     ggparallel(list("path", "chrom"), text.offset=c(0.03, 0,-0.03), data = genes,  width=0.1, order=c(1,0), angle=0, color="white",
        scale_colour_manual(values = c(   brewer.pal("YlOrRd", n = 9), rep("grey80", 24)), guide="none") +

Rd file 'ggparallel.Rd':
  \examples lines wider than 100 characters:
     ggparallel(names(titanic)[c(1,4,2,3)], titanic, weight=1, asp=0.5, method="hammock", ratio=0.2, order=c(0,0)) +
     ggparallel(names(titanic)[c(1,4,2,3)], titanic, weight="Freq", asp=0.5, method="hammock", order=c(0,0)) +
     ggparallel(list("path", "chrom"), text.offset=c(0.03, 0,-0.03), data = genes,  width=0.1, order=c(1,0), text.angle=0, color="white",
        scale_colour_manual(values = c(   brewer.pal("YlOrRd", n = 9), rep("grey80", 24)), guide="none") +

These lines will be truncated in the PDF manual.
```

## ggplot2 (1.0.1)
Maintainer: Hadley Wickham <h.wickham@gmail.com>  
Bug reports: https://github.com/hadley/ggplot2/issues

__OK__

## ggsubplot (0.3.2)
Maintainer: Garrett Grolemund <garrett@rstudio.com>

__OK__

## ggswissmaps (0.0.2)
Maintainer: Sandro Petrillo Burri <gibo.gaf@gmail.com>

__OK__

## ggthemes (2.1.2)
Maintainer: Jeffrey B. Arnold <jeffrey.arnold@gmail.com>  
Bug reports: http://github.com/jrnold/ggthemes

__OK__

## gpmap (0.1.1)
Maintainer: Arne B. Gjuvsland <arne.gjuvsland@nmbu.no>

```
checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘foreach’ ‘ggplot2’ ‘isotone’ ‘plyr’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
decompose_monotone: no visible global function definition for ‘%dopar%’
decompose_monotone: no visible global function definition for ‘foreach’
decompose_monotone: no visible global function definition for ‘%do%’
decompose_monotone_single: no visible global function definition for
  ‘%dopar%’
decompose_monotone_single: no visible global function definition for
  ‘foreach’
decompose_monotone_single: no visible global function definition for
  ‘laply’
degree_of_monotonicity: no visible global function definition for
  ‘%do%’
degree_of_monotonicity: no visible global function definition for
  ‘foreach’
degree_of_monotonicity_single: no visible global function definition
  for ‘aaply’
monotone_regression: no visible global function definition for
  ‘activeSet’
partial_genotype_order: no visible global function definition for
  ‘aaply’
plot1_dec: no visible global function definition for ‘%do%’
plot1_dec: no visible global function definition for ‘foreach’
plot1_dec: no visible global function definition for ‘ggplot’
plot1_dec: no visible global function definition for ‘aes_string’
plot1_dec: no visible global function definition for ‘geom_point’
plot1_dec: no visible global function definition for ‘facet_wrap’
plot1_dec: no visible global function definition for ‘labs’
plot1_orig: no visible global function definition for ‘%do%’
plot1_orig: no visible global function definition for ‘foreach’
plot1_orig: no visible global function definition for ‘ggplot’
plot1_orig: no visible global function definition for ‘aes_string’
plot1_orig: no visible global function definition for ‘geom_line’
plot1_orig: no visible global function definition for ‘labs’
plot2_dec: no visible global function definition for ‘%do%’
plot2_dec: no visible global function definition for ‘foreach’
plot2_dec: no visible global function definition for ‘ggplot’
plot2_dec: no visible global function definition for ‘aes_string’
plot2_dec: no visible global function definition for ‘geom_line’
plot2_dec: no visible global function definition for ‘facet_wrap’
plot2_dec: no visible global function definition for ‘labs’
plot2_orig: no visible global function definition for ‘%do%’
plot2_orig: no visible global function definition for ‘foreach’
plot2_orig: no visible global function definition for ‘ggplot’
plot2_orig: no visible global function definition for ‘aes_string’
plot2_orig: no visible global function definition for ‘geom_line’
plot2_orig: no visible global function definition for ‘labs’
plot3_dec: no visible global function definition for ‘%do%’
plot3_dec: no visible global function definition for ‘foreach’
plot3_dec: no visible global function definition for ‘ggplot’
plot3_dec: no visible global function definition for ‘aes_string’
plot3_dec: no visible global function definition for ‘geom_line’
plot3_dec: no visible global function definition for ‘facet_grid’
plot3_dec: no visible global function definition for ‘labs’
plot3_orig: no visible global function definition for ‘%do%’
plot3_orig: no visible global function definition for ‘foreach’
plot3_orig: no visible global function definition for ‘ggplot’
plot3_orig: no visible global function definition for ‘aes_string’
plot3_orig: no visible global function definition for ‘geom_line’
plot3_orig: no visible global function definition for ‘facet_wrap’
plot3_orig: no visible global function definition for ‘labs’
```

## gProfileR (0.5)
Maintainer: Tambet Arak <tambet.arak@gmail.com>

__OK__

## granovaGG (1.3)
Maintainer: Brian A. Danielak <brian@briandk.com>

__OK__

## gsDesign (2.9-3)
Maintainer: Keaven Anderson <keaven_anderson@merck.com>

```
checking line endings in Makefiles ... NOTE
Found the following Makefile(s) without a final LF:
  inst/unitTests/Makefile
Some ‘make’ programs ignore lines not ending in LF.
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: gsDesign
Loading required package: ggplot2
Loading required package: xtable
Loading required package: stringr
Loading required package: RUnit
Loading required package: plyr
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'gsSurvTemplate.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## GSIF (0.4-4)
Maintainer: Tomislav Hengl <tom.hengl@wur.nl>

```
checking package dependencies ... ERROR
Packages required but not available:
  ‘RSAGA’ ‘dismo’ ‘rgdal’ ‘aqp’ ‘plotKML’

Packages suggested but not available for checking:
  ‘soiltexture’ ‘spatstat’ ‘quantregForest’ ‘fossil’ ‘gdalUtils’
  ‘maxlike’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## gtable (0.1.2)
Maintainer: Hadley Wickham <h.wickham@gmail.com>

__OK__

## h2o (2.8.4.4)
Maintainer: Tom Kraljevic <tomk@0xdata.com>

```
checking installed package size ... NOTE
  installed size is 40.5Mb
  sub-directories of 1Mb or more:
    java  39.6Mb
```

## harvestr (0.6.0)
Maintainer: Andrew Redd <andrew.redd@hsc.utah.edu>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: coda
Loading required package: MASS
##
## Markov Chain Monte Carlo Package (MCMCpack)
## Copyright (C) 2003-2015 Andrew D. Martin, Kevin M. Quinn, and Jong Hee Park
##
## Support provided by the U.S. National Science Foundation
## (Grants SES-0350646 and SES-0350613)
##
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'harvestr.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## hillmakeR (0.2)
Maintainer: David Gilinson <dgilinson@reefpointgroup.com>

__OK__

## HistData (0.7-5)
Maintainer: Michael Friendly <friendly@yorku.ca>

```
checking Rd cross-references ... NOTE
Packages unavailable to check Rd xrefs: ‘Guerry’, ‘agridat’, ‘alr3’
```

## HiveR (0.2-28)
Maintainer: Bryan A. Hanson <hanson@depauw.edu>  
Bug reports: https://github.com/bryanhanson/HiveR/issues

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
cropping figure/PPNA-1.pdf
PDFCROP 1.38, 2012/11/02 - Copyright (c) 2002-2012 by Heiko Oberdiek.
==> 1 page written on `figure/PPNA-1.pdf'.
cropping figure/PPN4-1.pdf
PDFCROP 1.38, 2012/11/02 - Copyright (c) 2002-2012 by Heiko Oberdiek.
==> 1 page written on `figure/PPN4-1.pdf'.
cropping figure/PPN5-1.pdf
PDFCROP 1.38, 2012/11/02 - Copyright (c) 2002-2012 by Heiko Oberdiek.
==> 1 page written on `figure/PPN5-1.pdf'.
cropping figure/PPN6-1.pdf
PDFCROP 1.38, 2012/11/02 - Copyright (c) 2002-2012 by Heiko Oberdiek.
==> 1 page written on `figure/PPN6-1.pdf'.
cropping figure/E_coli_2-1.pdf
PDFCROP 1.38, 2012/11/02 - Copyright (c) 2002-2012 by Heiko Oberdiek.
==> 1 page written on `figure/E_coli_2-1.pdf'.
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'HiveR.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## HLMdiag (0.2.5)
Maintainer: Adam Loy <loyad01@gmail.com>

```
checking package dependencies ... ERROR
Package required but not available: ‘RcppArmadillo’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## hydrostats (0.2.3)
Maintainer: Nick Bond <n.bond@griffith.edu.au>

__OK__

## intsvy (1.6)
Maintainer: Daniel Caro <daniel.caro@education.ox.ac.uk>  
Bug reports: https://github.com/eldafani/intsvy/issues

__OK__

## IsingSampler (0.2)
Maintainer: Sacha Epskamp <mail@sachaepskamp.com>

__OK__

## ivlewbel (1.1)
Maintainer: Alan Fernihough <alan.fernihough@gmail.com>

```
checking R code for possible problems ... NOTE
clusterVCV: no visible global function definition for ‘estfun’
covc: no visible global function definition for ‘sandwich’
ftest: no visible global function definition for ‘vcovHC’
```

## JAGUAR (2.0)
Maintainer: Chaitanya Acharya <c.acharya@duke.edu>

__OK__

## jsonlite (0.9.15)
Maintainer: Jeroen Ooms <jeroen.ooms@stat.ucla.edu>  
Bug reports: http://github.com/jeroenooms/jsonlite/issues

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Warning in buildVignettes(dir = "/private/tmp/RtmpaTGn9N/check_cran3da26de4b7c3/jsonlite.Rcheck/vign_test/jsonlite") :
  Files named as vignettes but with no recognized vignette engine:
   ‘vignettes/json-opencpu-concordance.tex’
(Is a VignetteBuilder field missing?)

Attaching package: 'jsonlite'

The following object is masked from 'package:utils':

    View

Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'json-opencpu.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## Kernelheaping (0.2)
Maintainer: Marcus Gross <marcus.gross@fu-berlin.de>

__OK__

## kimisc (0.2-1)
Maintainer: Kirill Mueller <mail@kirill-mueller.de>  
Bug reports: https://github.com/krlmlr/kimisc/issues

__OK__

## Kmisc (0.5.0)
Maintainer: Kevin Ushey <kevinushey@gmail.com>  
Bug reports: https://github.com/kevinushey/Kmisc/issues

__OK__

## knitrBootstrap (0.9.0)
Maintainer: Jim Hester <james.f.hester@gmail.com>  
Bug reports: https://github.com/jimhester/knitrBootstrap/issues

__OK__

## kobe (1.3.2)
Maintainer: Laurence Kell <laurie.kell@iccat.int>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...

Attaching package: ‘reshape’

The following objects are masked from ‘package:plyr’:

    rename, round_any

Warning in loop_apply(n, do.ply) :
  Removed 11 rows containing missing values (geom_path).
Warning in loop_apply(n, do.ply) :
  Removed 16 rows containing missing values (geom_path).
Scale for 'y' is already present. Adding another scale for 'y', which will replace the existing scale.
Scale for 'x' is already present. Adding another scale for 'x', which will replace the existing scale.
Warning in loop_apply(n, do.ply) :
  Removed 8 rows containing missing values (geom_point).
Warning in loop_apply(n, do.ply) :
  Removed 8 rows containing missing values (geom_point).
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'kobe.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## Lahman (3.0-1)
Maintainer: Michael Friendly <friendly@yorku.ca>

```
checking installed package size ... NOTE
  installed size is  7.4Mb
  sub-directories of 1Mb or more:
    data   7.2Mb
```
```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘plyr’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```

## LakeMetabolizer (1.1)
Maintainer: Luke Winslow <lawinslow@gmail.com>

```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘R2jags’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
bayesFit: no visible global function definition for ‘jags’
```

## learningr (0.29)
Maintainer: Richie Cotton <richierocks@gmail.com>

```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘pracma’
```
```
checking data for non-ASCII characters ... NOTE
  Note: found 78 marked UTF-8 strings
```

## lfl (1.0)
Maintainer: Michal Burda <michal.burda@osu.cz>

__OK__

## likert (1.2)
Maintainer: Jason Bryer <jason@bryer.org>  
Bug reports: https://github.com/jbryer/likert/issues

```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘shiny’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking data for non-ASCII characters ... NOTE
  Note: found 7 marked UTF-8 strings
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: ggplot2
Loading required package: xtable
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'likert-xtable.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## lint (0.3)
Maintainer: Andrew Redd <andrew.redd@hsc.utah.edu>

```
checking R code for possible problems ... NOTE
autotest_style: no visible global function definition for ‘test_that’
test_style: no visible global function definition for
  ‘expect_equivalent’
```

## lllcrc (1.2)
Maintainer: Zach Kurtz <zkurtz@gmail.com>

__OK__

## lmerTest (2.0-20)
Maintainer: Alexandra Kuznetsova <alku@dtu.dk>

```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘pbkrtest’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```

## lsbclust (1.0.2)
Maintainer: Pieter Schoonees <schoonees@gmail.com>

__OK__

## lsmeans (2.16)
Maintainer: Russ Lenth <russell-lenth@uiowa.edu>

```
checking package dependencies ... NOTE
Packages which this enhances but not available for checking:
  ‘afex’ ‘coxme’ ‘gee’ ‘geepack’ ‘glmmADMB’
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: estimability
NOTE: Results may be misleading due to involvement in interactions
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'extending.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## lubridate (1.3.3)
Maintainer: Garrett Grolemund <garrett@rstudio.com>  
Bug reports: https://github.com/hadley/lubridate/issues

```
checking package dependencies ... NOTE
Packages which this enhances but not available for checking: ‘its’ ‘fts’
```

## marked (1.1.8)
Maintainer: Jeff Laake <Jeff.Laake@noaa.gov>

```
checking whether package ‘marked’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/RtmpaTGn9N/check_cran3da26de4b7c3/marked.Rcheck/00install.out’ for details.
```

## medicalrisk (1.1)
Maintainer: Patrick McCormick <patrick.mccormick@alum.mit.edu>

__OK__

## meifly (0.3)
Maintainer: Hadley Wickham <h.wickham@gmail.com>  
Bug reports: https://github.com/hadley/meifly/issues

__OK__

## metafolio (0.1.0)
Maintainer: Sean C. Anderson <sean@seananderson.ca>  
Bug reports: http://github.com/seananderson/metafolio/issues

```
checking package dependencies ... ERROR
Package required but not available: ‘RcppArmadillo’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## metafor (1.9-5)
Maintainer: Wolfgang Viechtbauer <wvb@metafor-project.org>

```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘Epi’ ‘lme4’ ‘polycor’ ‘survival’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```

## metagen (1.0)
Maintainer: Thomas W. D. Möbius <kontakt@thomasmoebius.de>

__OK__

## mizer (0.2)
Maintainer: Finlay Scott <finlay.scott@jrc.ec.europa.eu>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Warning in xy.coords(x, y, xlabel, ylabel, log) :
  1 y value <= 0 omitted from logarithmic plot
species, w\\_inf, w\\_mat, beta, sigma, r\\_max, k\\_vbError in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'mizer_vignette.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## mlr (2.3)
Maintainer: Bernd Bischl <bernd_bischl@gmx.net>  
Bug reports: https://github.com/berndbischl/mlr/issues

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘xgboost’
```
```
checking dependencies in R code ... NOTE
Missing or unexported object: ‘kohonen::predict.kohonen’
```
```
checking tests ... ERROR
Running the tests in ‘tests/run-base.R’ failed.
Last 13 lines of output:
  makeClassifTask(data = 44, target = "y") does not match 'be a data.frame'. Actual value: "Error in test_check("mlr", filter = "base") : \n  Assertion on 'data' failed: Must be of type 'data.frame', not 'double'\n"
  
  2. Failure(@test_base_SupervisedTask.R#27): SupervisedTask ---------------------
  makeClassifTask(data = regr.df, target = regr.target) does not match 'be a factor'. Actual value: "Error in test_check("mlr", filter = "base") : \n  Assertion on 'medv' failed: Must be of type 'factor', not 'double'\n"
  
  3. Failure(@test_base_SupervisedTask.R#29): SupervisedTask ---------------------
  makeRegrTask(data = multiclass.df, target = multiclass.target) does not match 'be numeric'. Actual value: "Error in test_check("mlr", filter = "base") : \n  Assertion on 'Species' failed: Must be of type 'numeric', not 'factor'\n"
  
  4. Failure(@test_base_UnsupervisedTask.R#6): UnsupervisedTask ------------------
  makeClassifTask(data = 44) does not match 'Must be a data.frame'. Actual value: "Error in test_check("mlr", filter = "base") : \n  Assertion on 'data' failed: Must be of type 'data.frame', not 'double'\n"
  
  Error: Test failures
  Execution halted
```

## morse (1.0.2)
Maintainer: Philippe Ruiz <philippe.ruiz@univ-lyon1.fr>

```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘dclone’ ‘ggmcmc’ ‘ggplot2’ ‘gridExtra’ ‘lattice’ ‘rjags’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
.repro.DIC: no visible global function definition for ‘dic.samples’
.repro.fullsurvplot.gg: no visible global function definition for
  ‘ggplot’
.repro.fullsurvplot.gg: no visible global function definition for ‘aes’
.repro.fullsurvplot.gg: no visible global function definition for
  ‘geom_point’
.repro.fullsurvplot.gg: no visible global function definition for
  ‘geom_line’
.repro.fullsurvplot.gg: no visible global function definition for
  ‘labs’
.repro.fullsurvplot.gg: no visible global function definition for
  ‘facet_wrap’
.repro.fullsurvplot.gg: no visible global function definition for
  ‘scale_x_continuous’
.repro.fullsurvplot.gg: no visible global function definition for
  ‘scale_colour_hue’
.repro.fullsurvplot.gg: no visible global function definition for
  ‘theme’
.repro.fullsurvplot.l: no visible global function definition for
  ‘xyplot’
.repro.ggplotfit.legend: no visible global function definition for
  ‘ggplot_gtable’
.repro.ggplotfit.legend: no visible global function definition for
  ‘ggplot_build’
.repro.load.model: no visible global function definition for
  ‘jags.model’
.repro.load.model.par: no visible global function definition for
  ‘parJagsModel’
.repro.model.sampling.parameters: no visible global function definition
  for ‘coda.samples’
.repro.model.sampling.parameters: no visible global function definition
  for ‘raftery.diag’
.repro.model.sampling.parameters.par: no visible global function
  definition for ‘parCodaSamples’
.repro.model.sampling.parameters.par: no visible global function
  definition for ‘raftery.diag’
plot.repro.fit: no visible global function definition for ‘ggplot’
plot.repro.fit: no visible global function definition for ‘geom_point’
plot.repro.fit: no visible global function definition for ‘aes’
plot.repro.fit: no visible global function definition for
  ‘scale_color_manual’
plot.repro.fit: no visible global function definition for ‘geom_line’
plot.repro.fit: no visible global function definition for
  ‘scale_color_discrete’
plot.repro.fit: no visible global function definition for ‘labs’
plot.repro.fit: no visible global function definition for
  ‘scale_x_log10’
plot.repro.fit: no visible global function definition for
  ‘scale_x_continuous’
plot.repro.fit: no visible global function definition for
  ‘grid.arrange’
plot.repro.fit: no visible global function definition for ‘arrangeGrob’
repro.convergence: no visible global function definition for
  ‘gelman.diag’
repro.convergence: no visible global function definition for
  ‘autocorr.plot’
repro.convergence: no visible global function definition for ‘ggs’
repro.convergence: no visible global function definition for
  ‘ggs_traceplot’
repro.convergence: no visible global function definition for
  ‘ggs_density’
repro.convergence: no visible global function definition for
  ‘ggs_autocorrelation’
repro.convergence: no visible global function definition for
  ‘grid.rect’
repro.convergence: no visible global function definition for ‘gpar’
repro.convergence: no visible binding for global variable
  ‘grid.arrange’
repro.cumulplot: no visible global function definition for ‘ggplot’
repro.cumulplot: no visible global function definition for ‘aes’
repro.cumulplot: no visible global function definition for ‘geom_point’
repro.cumulplot: no visible global function definition for ‘labs’
repro.cumulplot: no visible global function definition for
  ‘scale_x_log10’
repro.cumulplot: no visible global function definition for
  ‘scale_colour_hue’
repro.cumulplot: no visible global function definition for ‘theme’
repro.cumulplot: no visible global function definition for
  ‘scale_x_continuous’
repro.fit: no visible global function definition for ‘coda.samples’
repro.parfit: no visible global function definition for
  ‘makePSOCKcluster’
repro.parfit: no visible global function definition for ‘jags.model’
repro.parfit: no visible global function definition for
  ‘parCodaSamples’
repro.parfit: no visible global function definition for ‘stopCluster’
repro.survplot: no visible global function definition for ‘ggplot’
repro.survplot: no visible global function definition for ‘aes’
repro.survplot: no visible global function definition for ‘stat_sum’
repro.survplot: no visible global function definition for ‘labs’
repro.survplot: no visible global function definition for
  ‘scale_x_log10’
repro.survplot: no visible global function definition for ‘theme’
repro.survplot: no visible global function definition for
  ‘element_blank’
repro.survplot: no visible global function definition for
  ‘scale_x_continuous’
```

## mosaic (0.9.2-2)
Maintainer: Randall Pruim <rpruim@calvin.edu>

```
checking package dependencies ... NOTE
Package which this enhances but not available for checking: ‘manipulate’
```
```
checking installed package size ... NOTE
  installed size is  9.4Mb
  sub-directories of 1Mb or more:
    R     1.8Mb
    doc   7.0Mb
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
geom_smooth: method="auto" and size of largest group is <1000, so using loess. Use 'method = x' to change the smoothing method.
geom_smooth: method="auto" and size of largest group is <1000, so using loess. Use 'method = x' to change the smoothing method.
geom_smooth: method="auto" and size of largest group is <1000, so using loess. Use 'method = x' to change the smoothing method.
geom_smooth: method="auto" and size of largest group is <1000, so using loess. Use 'method = x' to change the smoothing method.
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'mosaicresources.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## MplusAutomation (0.6-3)
Maintainer: Michael Hallquist <michael.hallquist@gmail.com>

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘rhdf5’
```
```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘relimp’ ‘rhdf5’ ‘tcltk’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
readModels: no visible global function definition for ‘h5dump’
showSummaryTable: no visible global function definition for ‘showData’
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'Vignette.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## mpoly (0.0.5)
Maintainer: David Kahle <david.kahle@gmail.com>

__OK__

## MRMR (0.1.3)
Maintainer: Brian A. Fannin <BFannin@RedwoodsGroup.com>

```
checking R code for possible problems ... NOTE
PlotResiduals: no visible global function definition for ‘.’
```

## multilevelPSA (1.2.2)
Maintainer: Jason Bryer <jason@bryer.org>  
Bug reports: https://github.com/jbryer/multilevelPSA/issues

```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘MASS’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```

## MVN (3.9)
Maintainer: Selcuk Korkmaz <selcuk.korkmaz@hacettepe.edu.tr>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'MVN.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## mvnfast (0.1.3)
Maintainer: Matteo Fasiolo <matteo.fasiolo@gmail.com>

```
checking package dependencies ... ERROR
Package required but not available: ‘RcppArmadillo’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## NAPPA (2.0.1)
Maintainer: Mark Wappett <m.a.wappett@googlemail.com>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: NAPPA
Loading required package: plyr
Loading required package: NanoStringNorm
Loading required package: gdata
gdata: read.xls support for 'XLS' (Excel 97-2004) files ENABLED.

gdata: read.xls support for 'XLSX' (Excel 2007+) files ENABLED.

Attaching package: ‘gdata’

The following object is masked from ‘package:stats’:

    nobs

The following object is masked from ‘package:utils’:

    object.size

Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'NAPPA.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## nat.nblast (1.5)
Maintainer: James Manton <ajd.manton@googlemail.com>

__OK__

## nat (1.6.4)
Maintainer: Greg Jefferis <jefferis@gmail.com>  
Bug reports: https://github.com/jefferis/nat/issues

__OK__

## networkD3 (0.1.2.1)
Maintainer: Christopher Gandrud <christopher.gandrud@gmail.com>

__OK__

## networkreporting (0.0.1)
Maintainer: Dennis Feehan <dfeehan@princeton.edu>

__OK__

## networkTomography (0.3)
Maintainer: Alexander W Blocker <ablocker@gmail.com>

```
checking package dependencies ... ERROR
Package required but not available: ‘Rglpk’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## ngramr (1.4.5)
Maintainer: Sean Carmody <seancarmody@gmail.com>

__OK__

## NlsyLinks (1.302)
Maintainer: Will Beasley <wibeasley@hotmail.com>

```
checking dependencies in R code ... NOTE
Namespace in Imports field not imported from: ‘methods’
  All declared Imports should be used.
```
```
checking R code for possible problems ... NOTE
ReadCsvNlsy79Gen1: no visible binding for global variable
  ‘SubjectDetails79’
ReadCsvNlsy79Gen2: no visible binding for global variable
  ‘SubjectDetails79’
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: NlsyLinks
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'Faq.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## npIntFactRep (1.2)
Maintainer: Jos Feys <jos.feys@faber.kuleuven.be>

__OK__

## npsm (0.5)
Maintainer: John Kloke <kloke@biostat.wisc.edu>

__OK__

## nullabor (0.3.1)
Maintainer: Di Cook <dicook@iastate.edu>

__OK__

## okmesonet (0.1.5)
Maintainer: Brady Allred <allredbw@gmail.com>

```
checking R code for possible problems ... NOTE
nearstn: no visible binding for global variable ‘okstations’
nearstn: no visible binding for global variable ‘Commissioned’
nearstn: no visible binding for global variable ‘Decommissioned’
okmts: no visible binding for global variable ‘okstations’
okmts: no visible binding for global variable ‘TIME’
totalprecip: no visible binding for global variable ‘TIME’
```

## openair (1.1-5)
Maintainer: David Carslaw <david.carslaw@kcl.ac.uk>

```
checking whether package ‘openair’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/RtmpaTGn9N/check_cran3da26de4b7c3/openair.Rcheck/00install.out’ for details.
```

## OpenRepGrid (0.1.9)
Maintainer: Mark Heckmann <heckmann@uni-bremen.de>

__OK__

## opentraj (1.0)
Maintainer: Thalles Silva <tsantossilva@algomau.ca>

```
checking package dependencies ... ERROR
Packages required but not available: ‘openair’ ‘rgdal’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## optiRum (0.35)
Maintainer: Stephanie Locke <stephanie.locke@optimumcredit.co.uk>  
Bug reports: https://github.com/stephlocke/optiRum/issues

```
checking tests ... ERROR
Running the tests in ‘tests/test-all.R’ failed.
Last 13 lines of output:
  2: eval(code, new_test_environment)
  3: eval(expr, envir, enclos)
  4: generatePDF(srcpath = basepath, srcname = "basic", destpath = testpath, destname = "basic", 
         DATED = FALSE, CLEANUP = FALSE) at test-generatePDF.R:151
  5: knitr::knit2pdf(input = src, output = dest, envir = envir, quiet = QUIET, clean = CLEANUP, 
         ...)
  6: tools::texi2pdf(basename(out), ...)
  7: texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet, texi2dvi = texi2dvi, 
         texinputs = texinputs, index = index)
  8: stop(msg, domain = NA)
  
  Error: Test failures
  Execution halted
```

## OutbreakTools (0.1-13)
Maintainer: Thibaut Jombart <t.jombart@imperial.ac.uk>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
  The following sequence IDs are not in the dataset: 311, 222
Warning in (if (out_format(c("latex", "sweave", "listings"))) sanitize_fn else str_c)(path,  :
  replaced special characters in figure filename "figs/OutbreakTools-out.width==".8\\textwidth"" -> "figs/OutbreakTools-out.width___.8\\textwidth_"
Warning in (if (out_format(c("latex", "sweave", "listings"))) sanitize_fn else str_c)(path,  :
  dots in figure paths replaced with _ ("figs/OutbreakTools-out_width____8//textwidth_")
Warning: The shape palette can deal with a maximum of 6 discrete values because
more than 6 becomes difficult to discriminate; you have 11. Consider
specifying shapes manually. if you must have them.
Warning in loop_apply(n, do.ply) :
  Removed 58 rows containing missing values (geom_point).
Warning: The shape palette can deal with a maximum of 6 discrete values because
more than 6 becomes difficult to discriminate; you have 11. Consider
specifying shapes manually. if you must have them.
Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=51.516439,-0.171146&zoom=14&size=640x640&scale=2&maptype=terrain&language=en-EN&sensor=false
Warning in loop_apply(n, do.ply) :
  Removed 4 rows containing missing values (geom_point).
Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=51.516029,-0.178545&zoom=15&size=640x640&scale=2&maptype=terrain&language=en-EN&sensor=false
Warning in loop_apply(n, do.ply) :
  Removed 120 rows containing missing values (geom_point).
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'OutbreakTools.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## paleobioDB (0.3)
Maintainer: Sara Varela <svarela@paleobiogeography.org>  
Bug reports: https://github.com/ropensci/paleobioDB/issues

__OK__

## paleofire (1.1.5)
Maintainer: Olivier Blarquez <blarquez@gmail.com>

```
checking package dependencies ... ERROR
Packages required but not available: ‘GCD’ ‘rgdal’

Packages suggested but not available for checking: ‘agricolae’ ‘Imap’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## parboost (0.1.3)
Maintainer: Ronert Obst <ronert.obst@gmail.com>

```
checking R code for possible problems ... NOTE
cv_subsample: no visible global function definition for ‘mstop’
parboost: no visible global function definition for ‘boost_control’
parboost_fit: no visible global function definition for ‘Gaussian’
parboost_fit: no visible global function definition for ‘Binomial’
parboost_fit: no visible global function definition for ‘Poisson’
```

## pathological (0.0-3)
Maintainer: Richard Cotton <richierocks@gmail.com>

__OK__

## pedometrics (0.4-1)
Maintainer: Alessandro Samuel-Rosa <alessandrosamuelrosa@gmail.com>

```
checking package dependencies ... ERROR
Package required but not available: ‘spsurvey’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## peptider (0.1.7)
Maintainer: Eric Hare <erichare@iastate.edu>

__OK__

## pitchRx (1.6)
Maintainer: Carson Sievert <sievert@iastate.edu>  
Bug reports: http://github.com/cpsievert/pitchRx/issues

__OK__

## planar (1.5.2)
Maintainer: Baptiste Auguie <baptiste.auguie@gmail.com>

```
checking package dependencies ... ERROR
Package required but not available: ‘RcppArmadillo’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## plotKML (0.5-0)
Maintainer: Tomislav Hengl <tom.hengl@wur.nl>

```
checking package dependencies ... ERROR
Packages required but not available:
  ‘rgdal’ ‘dismo’ ‘aqp’ ‘colorRamps’ ‘RSAGA’

Packages suggested but not available for checking:
  ‘adehabitat’ ‘fossil’ ‘spcosa’ ‘spatstat’ ‘rgbif’ ‘GSIF’ ‘gdalUtils’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## plotSEMM (2.0)
Maintainer: Phil Chalmers <rphilip.chalmers@gmail.com>

__OK__

## plumbr (0.6.9)
Maintainer: Michael Lawrence <michafla@gene.com>

__OK__

## plusser (0.4-0)
Maintainer: Christoph Waldhauser <chw@kdss.at>

__OK__

## PMA (1.0.9)
Maintainer: Daniela Witten <dwitten@u.washington.edu>

```
checking package dependencies ... ERROR
Package required but not available: ‘impute’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## pointRes (1.0.2)
Maintainer: Marieke van der Maaten-Theunissen <marieketheunissen@gmail.com>

__OK__

## pollstR (1.2.0)
Maintainer: Jeffrey B. Arnold <jeffrey.arnold@gmail.com>  
Bug reports: https://github.com/rOpenGov/pollstR/issues

__OK__

## PopGenReport (2.1)
Maintainer: Bernd Gruber <Bernd.Gruber@canberra.edu.au>

```
checking package dependencies ... ERROR
Packages required but not available:
  ‘adegenet’ ‘gap’ ‘calibrate’ ‘dismo’ ‘pegas’ ‘genetics’ ‘rgdal’
  ‘gdistance’ ‘mmod’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## pqantimalarials (0.2)
Maintainer: J. Patrick Renschler <patrick.renschler@gmail.com>

__OK__

## predictmeans (0.99)
Maintainer: Dongwen Luo <dongwen.luo@agresearch.co.nz>

__OK__

## primerTree (1.0.1)
Maintainer: Jim Hester <james.f.hester@gmail.com>

__OK__

## pROC (1.7.3)
Maintainer: Xavier Robin <robin@lindinglab.org>

```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘MASS’ ‘logcondens’ ‘microbenchmark’ ‘tcltk’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```

## profileR (0.2-1)
Maintainer: Christopher David Desjardins <cddesjardins@gmail.com>

__OK__

## profr (0.3.1)
Maintainer: Hadley Wickham <h.wickham@gmail.com>  
Bug reports: https://github.com/hadley/profr/issues

```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘ggplot2’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
ggplot.profr: no visible global function definition for ‘ggplot’
ggplot.profr: no visible global function definition for ‘geom_rect’
ggplot.profr: no visible global function definition for ‘aes’
ggplot.profr: no visible global function definition for ‘geom_text’
ggplot.profr: no visible global function definition for
  ‘scale_y_continuous’
ggplot.profr: no visible global function definition for
  ‘scale_x_continuous’
```

## ProjectTemplate (0.6)
Maintainer: Kirill Mueller <krlmlr+r@mailbox.org>  
Bug reports: https://github.com/johnmyleswhite/ProjectTemplate/issues

```
checking package dependencies ... NOTE
Packages suggested but not available for checking: ‘RODBC’ ‘RPostgreSQL’
```

## proteomics (0.2)
Maintainer: Thomas W. D. Möbius <kontakt@thomasmoebius.de>

__OK__

## psd (1.0-1)
Maintainer: Andrew J. Barbour <andy.barbour@gmail.com>  
Bug reports: https://github.com/abarbour/psd/issues

```
checking package dependencies ... ERROR
Package required but not available: ‘RcppArmadillo’

Package suggested but not available for checking: ‘fftw’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## psytabs (0.5)
Maintainer: Johannes Beller <johannesbeller@gmail.com>

```
checking package dependencies ... NOTE
Depends: includes the non-default packages:
  ‘psych’ ‘plyr’ ‘rtf’ ‘R2HTML’ ‘mokken’ ‘lavaan’ ‘semTools’
Adding so many packages to the search path is excessive and importing
selectively is preferable.
```
```
checking dependencies in R code ... NOTE
'library' or 'require' calls to packages already attached by Depends:
  ‘R2HTML’ ‘mokken’ ‘plyr’ ‘rtf’
  Please remove these calls from your code.
Packages in Depends field not imported from:
  ‘R2HTML’ ‘lavaan’ ‘mokken’ ‘plyr’ ‘psych’ ‘rtf’ ‘semTools’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
demographicTable: no visible global function definition for ‘colwise’
measurementInvarianceTable: no visible global function definition for
  ‘fitMeasures’
measurementInvarianceTable: no visible global function definition for
  ‘colwise’
mokkenTable: no visible global function definition for
  ‘check.monotonicity’
mokkenTable: no visible global function definition for ‘check.iio’
saveTable: no visible global function definition for ‘HTMLInitFile’
saveTable: no visible global function definition for ‘HTMLEndFile’
saveTable: no visible global function definition for ‘RTF’
saveTable: no visible global function definition for ‘addParagraph’
saveTable: no visible global function definition for ‘addTable’
saveTable: no visible global function definition for ‘done’
```
```
checking Rd line widths ... NOTE
Rd file 'measurementInvarianceTable.Rd':
  \examples lines wider than 100 characters:
     mi.strict.result <- measurementInvariance(HW.model, data=HolzingerSwineford1939, strict=TRUE, group="school")
     mi.robust.result <- measurementInvariance(HW.model, data=HolzingerSwineford1939, estimator="MLM", group="school")
     mi.robstrict.result <- measurementInvariance(HW.model, data=HolzingerSwineford1939, estimator="MLM", strict=TRUE, group="school")

Rd file 'normTable.Rd':
  \examples lines wider than 100 characters:
     tab.4 <- normTable(myData.sumscore, from = 0, to = 12, statistics=c("PR", "T"), group=myData$employment)
     tab.5 <- normTable(myData.sumscore, from = 0, to = 12, statistics=c("T"), group=list(myData$sex, myData$employment))
     list.5 <- normTable(myData.sumscore, from = 0, to = 12, statistics=c("PR", "T", "Z", "z"), group=list(myData$sex, myData$employment), a ... [TRUNCATED]

These lines will be truncated in the PDF manual.
```

## pxR (0.40.0)
Maintainer: Carlos J. Gil Bellosta <cgb@datanalytics.com>

```
checking R code for possible problems ... NOTE
read.px : get.attributes: no visible global function definition for
  ‘ldply’
read.px: no visible global function definition for ‘str_locate_all’
read.px: no visible global function definition for ‘str_sub’
read.px: no visible global function definition for ‘str_length’
```

## pxweb (0.5.5)
Maintainer: Mans Magnusson <mons.magnusson@gmail.com>  
Bug reports: https://github.com/rOpenGov/pxweb/issues

__OK__

## qgraph (1.3.1)
Maintainer: Sacha Epskamp <mail@sachaepskamp.com>

__OK__

## rAltmetric (0.6)
Maintainer: Karthik Ram <karthik.ram@gmail.com>  
Bug reports: https://github.com/ropensci/rAltmetric/issues/

__OK__

## RAM (1.2.0)
Maintainer: Wen Chen <Wen.Chen@agr.gc.ca>

```
checking package dependencies ... ERROR
Packages required but not available: ‘labdsv’ ‘VennDiagram’ ‘FD’

Packages suggested but not available for checking:
  ‘indicspecies’ ‘Heatplus’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## rapport (0.51)
Maintainer: Aleksandar Blagotić <alex@rapporter.net>  
Bug reports: https://github.com/rapporter/rapport/issues

```
checking dependencies in R code ... NOTE
Namespace in Imports field not imported from: ‘grDevices’
  All declared Imports should be used.
Packages in Depends field not imported from:
  ‘lattice’ ‘pander’ ‘plyr’ ‘yaml’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
Unexported objects imported by ':::' calls:
  ‘tools:::fetchRdDB’ ‘utils:::index.search’
  See the note in ?`:::` about the use of this operator.
```
```
checking R code for possible problems ... NOTE
as.character.rp.inputs: no visible global function definition for
  ‘as.yaml’
as.character.rp.meta: no visible global function definition for
  ‘as.yaml’
guess.input: no visible global function definition for ‘p’
htest: no visible global function definition for ‘is.formula’
htest: no visible global function definition for ‘each’
htest : <anonymous>: no visible global function definition for ‘each’
pct: no visible global function definition for ‘panderOptions’
print.rapport: no visible global function definition for
  ‘pandoc.header’
print.rapport: no visible global function definition for
  ‘redraw.recordedplot’
print.rapport: no visible global function definition for ‘evalsOptions’
print.rp.inputs : <anonymous>: no visible global function definition
  for ‘p’
rapport: no visible global function definition for ‘evalsOptions’
rapport: no visible global function definition for ‘p’
rapport : <anonymous>: no visible global function definition for ‘p’
rp.barplot: no visible global function definition for ‘barchart’
rp.boxplot: no visible global function definition for ‘bwplot’
rp.densityplot: no visible global function definition for ‘densityplot’
rp.desc: no visible global function definition for ‘each’
rp.dotplot: no visible global function definition for ‘dotplot’
rp.hist : panel: no visible global function definition for
  ‘panel.histogram’
rp.hist : panel: no visible global function definition for
  ‘panel.densityplot’
rp.hist: no visible global function definition for ‘histogram’
rp.lineplot: no visible global function definition for ‘xyplot’
rp.qqplot: no visible global function definition for ‘qqmath’
rp.scatterplot: no visible global function definition for ‘xyplot’
tpl.check: no visible global function definition for ‘p’
tpl.export: no visible global function definition for ‘pander.return’
tpl.export: no visible global function definition for ‘evalsOptions’
tpl.export: no visible binding for global variable ‘Pandoc’
tpl.export: no visible global function definition for
  ‘pandoc.header.return’
tpl.export : <anonymous>: no visible global function definition for
  ‘pandoc.header.return’
tpl.export : <anonymous>: no visible global function definition for
  ‘pander.return’
tpl.export: no visible global function definition for
  ‘pandoc.image.return’
tpl.inputs: no visible global function definition for ‘yaml.load’
tpl.inputs: no visible global function definition for ‘p’
tpl.meta: no visible global function definition for ‘yaml.load’
tpl.meta : <anonymous>: no visible global function definition for ‘p’
tpl.meta: no visible global function definition for ‘p’
tpl.renew: no visible global function definition for ‘as.yaml’
```
```
checking Rd line widths ... NOTE
Rd file 'get.tags.Rd':
  \usage lines wider than 90 characters:
       get.tags(tag.type = c("all", "header.open", "header.close", "comment.open", "comment.close"),

Rd file 'rp.desc.Rd':
  \examples lines wider than 100 characters:
     rp.desc("age", c("gender", "student"), c("Average" = mean, "Deviation" = sd), ius2008, remove.duplicate = FALSE)

Rd file 'rp.lineplot.Rd':
  \examples lines wider than 100 characters:
     rp.lineplot(partner, age, data = rp.desc('age', 'partner', fn = 'mean', data=ius2008)) ## TODO: fix....
     rp.lineplot(partner, age, gender, data = rp.desc('age', c('gender', 'partner'), fn = 'mean', data=ius2008))
     rp.lineplot(partner, age, groups = gender, data=rp.desc('age', c('gender', 'partner'), fn = 'mean', data = ius2008))

Rd file 'rp.qqplot.Rd':
  \examples lines wider than 100 characters:
     rp.qqplot(ius2008$age, panel = function(x) {panel.qqmath(x); panel.qqmathline(x, distribution = qnorm)} )

These lines will be truncated in the PDF manual.
```

## rapportools (1.0)
Maintainer: Gergely Daróczi <daroczig@rapporter.net>  
Bug reports: https://github.com/rapporter/rapportools/issues

```
checking dependencies in R code ... NOTE
Package in Depends field not imported from: ‘reshape’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
freq: no visible global function definition for ‘melt’
rp.desc: no visible global function definition for ‘melt.data.frame’
rp.desc: no visible global function definition for ‘cast’
rp.freq: no visible global function definition for ‘melt’
```

## rattle (3.4.1)
Maintainer: Graham Williams <Graham.Williams@togaware.com>

```
checking package dependencies ... NOTE
Packages suggested but not available for checking:
  ‘RGtk2’ ‘cairoDevice’ ‘graph’ ‘gWidgetsRGtk2’ ‘playwith’ ‘RBGL’
  ‘rggobi’ ‘RGtk2Extras’ ‘RODBC’ ‘pkgDepTools’ ‘Rgraphviz’
```
```
checking installed package size ... NOTE
  installed size is  6.9Mb
  sub-directories of 1Mb or more:
    data   2.1Mb
    etc    2.5Mb
    po     1.2Mb
```
```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘Hmisc’ ‘RBGL’ ‘RGtk2’ ‘RGtk2Extras’ ‘ROCR’ ‘RODBC’ ‘Rgraphviz’ ‘XML’
  ‘ada’ ‘arules’ ‘bitops’ ‘cairoDevice’ ‘colorspace’ ‘e1071’ ‘fBasics’
  ‘foreign’ ‘fpc’ ‘graph’ ‘grid’ ‘kernlab’ ‘methods’ ‘nnet’
  ‘pkgDepTools’ ‘pmml’ ‘randomForest’ ‘reshape’ ‘rggobi’ ‘rpart’
  ‘stats’ ‘survival’ ‘utils’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
Found an obsolete/platform-specific call in the following functions:
  ‘openMyDevice’ ‘printPlot’ ‘savePlotToFile’
Found the platform-specific devices:
  ‘win.metafile’ ‘win.print’
dev.new() is the preferred way to open a new device, in the unlikely
event one is needed.
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'rattle.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## rbefdata (0.3.5)
Maintainer: Claas-Thido Pfaff <claas-thido.pfaff@idiv-biodiversity.de>

```
checking R code for possible problems ... NOTE
bef.get.categories_for: no visible binding for global variable ‘id’
bef.portal.get.categories_for: no visible binding for global variable
  ‘id’
```

## rbhl (0.1.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/rbhl/issues

__OK__

## RbioRXN (1.5)
Maintainer: Byoungnam Min <mbnmbn00@gmail.com>

```
checking package dependencies ... ERROR
Packages required but not available: ‘fmcsR’ ‘ChemmineR’ ‘KEGGREST’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## rbison (0.4.5)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/rbison/issues

__OK__

## rcbalance (1.4)
Maintainer: Samuel D. Pimentel <spi@wharton.upenn.edu>

__OK__

## rclinicaltrials (1.4.1)
Maintainer: Michael C Sachs <sachsmc@gmail.com>

__OK__

## RcmdrPlugin.KMggplot2 (0.2-0)
Maintainer: Triad sou. <triadsou@gmail.com>

```
checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘ggplot2’ ‘grid’ ‘methods’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
Missing or unexported object: ‘ggplot2::digest.ggplot’
```
```
checking R code for possible problems ... NOTE
ggsaveKmg2: no visible global function definition for ‘last_plot’
theme_natrisk: no visible global function definition for ‘%+replace%’
theme_natrisk: no visible global function definition for
  ‘element_blank’
theme_natrisk: no visible global function definition for ‘element_rect’
theme_natrisk21: no visible global function definition for ‘%+replace%’
theme_natrisk21: no visible global function definition for
  ‘element_blank’
theme_natrisk21: no visible global function definition for
  ‘element_rect’
theme_natrisk21: no visible global function definition for ‘unit’
theme_natriskbg: no visible global function definition for ‘%+replace%’
theme_natriskbg: no visible global function definition for
  ‘element_blank’
theme_natriskbg: no visible global function definition for
  ‘element_rect’
theme_natriskbg: no visible global function definition for ‘unit’
theme_simple: no visible global function definition for ‘%+replace%’
theme_simple: no visible global function definition for ‘theme_bw’
theme_simple: no visible global function definition for ‘element_rect’
theme_simple: no visible global function definition for ‘element_blank’
```

## rcrossref (0.3.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/rcrossref/issues

__OK__

## rdryad (0.1.1)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/rdryad/issues

__OK__

## RDSTK (1.1)
Maintainer: Ryan Elmore <rtelmore@gmail.com>

__OK__

## rebird (0.1.1)
Maintainer: Rafael Maia <rm72@zips.uakron.edu>

__OK__

## REDCapR (0.7-1)
Maintainer: Will Beasley <wibeasley@hotmail.com>

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘RODBC’
```
```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘RODBC’ ‘testthat’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking tests ... ERROR
Running the tests in ‘tests/test-all.R’ failed.
Last 13 lines of output:
                 character()
             else names(CURLcodeValues)[i]
         }
         typeName = gsub("^CURLE_", "", typeName)
         fun = (if (asError) 
             stop
         else warning)
         fun(structure(list(message = msg, call = sys.call()), class = c(typeName, "GenericCurlError", 
             "error", "condition")))
     }(35L, "Unknown SSL protocol error in connection to bbmc.ouhsc.edu:-9800", TRUE)
  
  Error: Test failures
  Execution halted
```

## RefManageR (0.8.45)
Maintainer: Mathew W. McLean <mathew.w.mclean@gmail.com>

```
checking foreign function calls ... NOTE
Foreign function call to a different package:
  .External("do_read_bib", ..., PACKAGE = "bibtex")
See chapter ‘System and foreign language interfaces’ in the ‘Writing R
Extensions’ manual.
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Warning in grepl("mkbib", x) : input string 8 is invalid in this locale
Warning in grepl("\n", lines, fixed = TRUE) :
  input string 8 is invalid in this locale
Warning in grepl("mkbib", x) : input string 8 is invalid in this locale
Warning in grepl("\n", lines, fixed = TRUE) :
  input string 8 is invalid in this locale
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'manual.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## remix (2.1)
Maintainer: David Hajage <dhajage@gmail.com>

```
checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘plyr’ ‘survival’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
':::' call which should be '::': ‘Hmisc:::label.default’
  See the note in ?`:::` about the use of this operator.
```
```
checking R code for possible problems ... NOTE
cross: no visible binding for global variable ‘is.Surv’
is.numeric.and.not.surv: no visible global function definition for
  ‘is.Surv’
remix: no visible global function definition for ‘is.formula’
remix : <anonymous>: no visible global function definition for
  ‘is.Surv’
remix: no visible binding for global variable ‘is.Surv’
remix: no visible global function definition for ‘llply’
summarize.by: no visible global function definition for ‘dlply’
summarize.by: no visible global function definition for ‘.’
summarize.data.frame.by: no visible global function definition for
  ‘dlply’
survival: no visible global function definition for ‘survfit’
survival: no visible global function definition for ‘daply’
survival: no visible global function definition for ‘.’
test.survival.logrank: no visible global function definition for
  ‘survdiff’
```
```
checking Rd \usage sections ... NOTE
S3 methods shown with full name in documentation object 'as.data.frame.correlation':
  ‘as.data.frame.correlation’

S3 methods shown with full name in documentation object 'as.data.frame.freq':
  ‘as.data.frame.freq’

S3 methods shown with full name in documentation object 'as.data.frame.summarize':
  ‘as.data.frame.summarize’

S3 methods shown with full name in documentation object 'as.data.frame.summarize.by':
  ‘as.data.frame.summarize.by’

S3 methods shown with full name in documentation object 'as.data.frame.survival':
  ‘as.data.frame.survival’

S3 methods shown with full name in documentation object 'as.data.frame.tabular':
  ‘as.data.frame.tabular’

The \usage entries for S3 methods should use the \method markup and not
their full name.
See chapter ‘Writing R documentation files’ in the ‘Writing R
Extensions’ manual.
```

## repmis (0.4.2)
Maintainer: Christopher Gandrud <christopher.gandrud@gmail.com>  
Bug reports: https://github.com/christophergandrud/repmis/issues

__OK__

## reshape (0.8.5)
Maintainer: Hadley Wickham <h.wickham@gmail.com>

__OK__

## reshape2 (1.4.1)
Maintainer: Hadley Wickham <h.wickham@gmail.com>  
Bug reports: https://github.com/hadley/reshape/issues

__OK__

## reshapeGUI (0.1.0)
Maintainer: Jason Crowley <crowley.jason.s@gmail.com>

```
checking package dependencies ... ERROR
Package required but not available: ‘gWidgetsRGtk2’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## rfigshare (0.3.6)
Maintainer: Carl Boettiger <cboettig@gmail.com>  
Bug reports: https://github.com/ropensci/rfigshare/issues

__OK__

## RForcecom (0.7)
Maintainer: Takekatsu Hiramura <thira@plavox.info>

```
checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘RCurl’ ‘XML’ ‘plyr’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
rforcecom.create: no visible global function definition for
  ‘basicHeaderGatherer’
rforcecom.create: no visible global function definition for
  ‘basicTextGatherer’
rforcecom.create: no visible global function definition for
  ‘curlPerform’
rforcecom.create: no visible global function definition for ‘xmlRoot’
rforcecom.create: no visible global function definition for
  ‘xmlTreeParse’
rforcecom.create: no visible global function definition for ‘xmlValue’
rforcecom.create: no visible global function definition for
  ‘xmlToDataFrame’
rforcecom.create: no visible global function definition for
  ‘getNodeSet’
rforcecom.create: no visible global function definition for ‘xmlParse’
rforcecom.delete: no visible global function definition for
  ‘basicHeaderGatherer’
rforcecom.delete: no visible global function definition for
  ‘basicTextGatherer’
rforcecom.delete: no visible global function definition for
  ‘curlPerform’
rforcecom.delete: no visible global function definition for ‘xmlRoot’
rforcecom.delete: no visible global function definition for
  ‘xmlTreeParse’
rforcecom.delete: no visible global function definition for ‘xmlValue’
rforcecom.getObjectDescription: no visible global function definition
  for ‘basicHeaderGatherer’
rforcecom.getObjectDescription: no visible global function definition
  for ‘basicTextGatherer’
rforcecom.getObjectDescription: no visible global function definition
  for ‘curlPerform’
rforcecom.getObjectDescription: no visible global function definition
  for ‘xmlRoot’
rforcecom.getObjectDescription: no visible global function definition
  for ‘xmlTreeParse’
rforcecom.getObjectDescription: no visible global function definition
  for ‘xmlValue’
rforcecom.getObjectDescription: no visible global function definition
  for ‘getNodeSet’
rforcecom.getObjectDescription: no visible global function definition
  for ‘xmlParse’
rforcecom.getObjectDescription: no visible binding for global variable
  ‘xmlToList’
rforcecom.getObjectList: no visible global function definition for
  ‘basicHeaderGatherer’
rforcecom.getObjectList: no visible global function definition for
  ‘basicTextGatherer’
rforcecom.getObjectList: no visible global function definition for
  ‘curlPerform’
rforcecom.getObjectList: no visible global function definition for
  ‘xmlRoot’
rforcecom.getObjectList: no visible global function definition for
  ‘xmlTreeParse’
rforcecom.getObjectList: no visible global function definition for
  ‘xmlValue’
rforcecom.getObjectList: no visible global function definition for
  ‘xmlToDataFrame’
rforcecom.getObjectList: no visible global function definition for
  ‘getNodeSet’
rforcecom.getObjectList: no visible global function definition for
  ‘xmlParse’
rforcecom.getServerTimestamp: no visible global function definition for
  ‘basicHeaderGatherer’
rforcecom.getServerTimestamp: no visible global function definition for
  ‘basicTextGatherer’
rforcecom.getServerTimestamp: no visible global function definition for
  ‘curlPerform’
rforcecom.login: no visible global function definition for
  ‘basicHeaderGatherer’
rforcecom.login: no visible global function definition for
  ‘basicTextGatherer’
rforcecom.login: no visible global function definition for
  ‘curlPerform’
rforcecom.login: no visible global function definition for ‘xmlRoot’
rforcecom.login: no visible global function definition for
  ‘xmlTreeParse’
rforcecom.login: no visible global function definition for ‘xmlValue’
rforcecom.query: no visible global function definition for
  ‘basicHeaderGatherer’
rforcecom.query: no visible global function definition for
  ‘basicTextGatherer’
rforcecom.query: no visible global function definition for ‘curlEscape’
rforcecom.query: no visible global function definition for
  ‘curlPerform’
rforcecom.query: no visible global function definition for ‘xmlRoot’
rforcecom.query: no visible global function definition for
  ‘xmlTreeParse’
rforcecom.query: no visible global function definition for ‘xmlValue’
rforcecom.query: no visible global function definition for ‘getNodeSet’
rforcecom.query: no visible global function definition for ‘xmlParse’
rforcecom.query: no visible binding for global variable ‘xmlToList’
rforcecom.query: no visible global function definition for ‘rbind.fill’
rforcecom.queryMore: no visible global function definition for
  ‘basicHeaderGatherer’
rforcecom.queryMore: no visible global function definition for
  ‘basicTextGatherer’
rforcecom.queryMore: no visible global function definition for
  ‘curlPerform’
rforcecom.queryMore: no visible global function definition for
  ‘xmlRoot’
rforcecom.queryMore: no visible global function definition for
  ‘xmlTreeParse’
rforcecom.queryMore: no visible global function definition for
  ‘xmlValue’
rforcecom.queryMore: no visible global function definition for
  ‘getNodeSet’
rforcecom.queryMore: no visible global function definition for
  ‘xmlParse’
rforcecom.queryMore: no visible binding for global variable ‘xmlToList’
rforcecom.queryMore: no visible global function definition for
  ‘rbind.fill’
rforcecom.search: no visible global function definition for
  ‘basicHeaderGatherer’
rforcecom.search: no visible global function definition for
  ‘basicTextGatherer’
rforcecom.search: no visible global function definition for
  ‘curlEscape’
rforcecom.search: no visible global function definition for
  ‘curlPerform’
rforcecom.search: no visible global function definition for
  ‘getNodeSet’
rforcecom.search: no visible global function definition for ‘xmlParse’
rforcecom.search : <anonymous>: no visible global function definition
  for ‘xmlValue’
rforcecom.search : <anonymous>: no visible global function definition
  for ‘xmlGetAttr’
rforcecom.search: no visible global function definition for ‘xmlRoot’
rforcecom.search: no visible global function definition for
  ‘xmlTreeParse’
rforcecom.search: no visible global function definition for ‘xmlValue’
rforcecom.update: no visible global function definition for
  ‘basicHeaderGatherer’
rforcecom.update: no visible global function definition for
  ‘basicTextGatherer’
rforcecom.update: no visible global function definition for
  ‘curlPerform’
rforcecom.update: no visible global function definition for ‘xmlRoot’
rforcecom.update: no visible global function definition for
  ‘xmlTreeParse’
rforcecom.update: no visible global function definition for ‘xmlValue’
rforcecom.upsert: no visible global function definition for
  ‘basicHeaderGatherer’
rforcecom.upsert: no visible global function definition for
  ‘basicTextGatherer’
rforcecom.upsert: no visible global function definition for
  ‘curlPerform’
rforcecom.upsert: no visible global function definition for ‘xmlRoot’
rforcecom.upsert: no visible global function definition for
  ‘xmlTreeParse’
rforcecom.upsert: no visible global function definition for ‘xmlValue’
rforcecom.upsert: no visible global function definition for
  ‘xmlToDataFrame’
rforcecom.upsert: no visible global function definition for
  ‘getNodeSet’
rforcecom.upsert: no visible global function definition for ‘xmlParse’
```

## rgauges (0.2.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/rgauges/issues

__OK__

## rgbif (0.8.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/rgbif/issues

```
checking package dependencies ... ERROR
Package required but not available: ‘rgeos’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## RIGHT (0.2.0)
Maintainer: Jonghyun Bae <bnbbkr@gmail.com>  
Bug reports: https://groups.google.com/forum/?hl=en#!forum/right-user

__OK__

## rinat (0.1.4)
Maintainer: Edmund Hart <edmund.m.hart@gmail.com>

__OK__

## rLakeAnalyzer (1.4)
Maintainer: Luke Winslow <lawinslow@gmail.com>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'data.handling.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## Rmisc (1.5)
Maintainer: Ryan M. Hope <rmh3093@gmail.com>

__OK__

## rmongodb (1.8.0)
Maintainer: Dmitriy Selivanov <selivanov.dmitriy@gmail.com>  
Bug reports: https://github.com/mongosoup/rmongodb/issues

```
checking for GNU extensions in Makefiles ... NOTE
GNU make is a SystemRequirements.
```
```
checking compiled code ... NOTE
File ‘rmongodb/libs/rmongodb.so’:
  Found ‘_rand’, possibly from ‘rand’ (C)
    Objects: ‘libmongo/bson.o’, ‘libmongo/mongo.o’
  Found ‘_srand’, possibly from ‘srand’ (C)
    Object: ‘libmongo/bson.o’

Compiled code should not call entry points which might terminate R nor
write to stdout/stderr instead of to the console, nor the system RNG.

See ‘Writing portable packages’ in the ‘Writing R Extensions’ manual.
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
     'mongo.is.connected',
     'mongo.disconnect',
     'mongo.reconnect',
     'mongo.get.err',
     'mongo.get.primary',
     'mongo.get.hosts',
     'mongo.get.socket',
     'mongo.set.timeout',
     'mongo.get.timeout'.

_E_x_a_m_p_l_e_s:

     mongo <- mongo.create()
     ## Not run:
     
         mongo <- mongo.create("192.168.0.3")
     ## End(Not run)
     

Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'rmongodb_cheat_sheet.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## Rmonkey (0.2.11)
Maintainer: Thomas J. Leeper <thosjleeper@gmail.com>  
Bug reports: https://github.com/leeper/Rmonkey/issues

__OK__

## RNeXML (2.0.1)
Maintainer: Carl Boettiger <cboettig@gmail.com>  
Bug reports: https://github.com/ropensci/RNeXML/issues

```
checking package dependencies ... NOTE
Packages suggested but not available for checking: ‘rrdf’ ‘Sxslt’
```
```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘Sxslt’ ‘rfigshare’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```

## rnoaa (0.3.3)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: http://www.github.com/ropensci/rnoaa/issues

```
checking package dependencies ... ERROR
Packages required but not available: ‘rgdal’ ‘rgeos’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## robustvarComp (0.1-2)
Maintainer: Claudio Agostinelli <claudio@unive.it>

```
checking whether package ‘robustvarComp’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/RtmpaTGn9N/check_cran3da26de4b7c3/robustvarComp.Rcheck/00install.out’ for details.
```

## rplos (0.4.6)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/rplos/issues

__OK__

## RSA (0.9.8)
Maintainer: Felix Schönbrodt <felix@nicebread.de>

__OK__

## RSAGA (0.93-6)
Maintainer: Alexander Brenning <brenning@uwaterloo.ca>

```
checking dependencies in R code ... NOTE
'library' or 'require' calls to packages already attached by Depends:
  ‘gstat’ ‘plyr’ ‘shapefiles’
  Please remove these calls from your code.
Packages in Depends field not imported from:
  ‘gstat’ ‘plyr’ ‘shapefiles’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
pick.from.ascii.grid: no visible global function definition for ‘ddply’
pick.from.ascii.grid: no visible global function definition for ‘.’
pick.from.ascii.grid: no visible global function definition for ‘dlply’
pick.from.points: no visible global function definition for ‘vgm’
pick.from.points: no visible global function definition for ‘krige’
pick.from.shapefile: no visible global function definition for
  ‘read.shapefile’
pick.from.shapefile: no visible global function definition for ‘add.xy’
rsaga.get.modules: no visible global function definition for ‘llply’
```
```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘rgdal’
```

## rsdmx (0.4-5)
Maintainer: Emmanuel Blondel <emmanuel.blondel1@gmail.com>  
Bug reports: https://github.com/opensdmx/rsdmx/issues

__OK__

## RSiteCatalyst (1.4.3)
Maintainer: Randy Zwitch <rzwitch+rsitecatalyst@gmail.com>  
Bug reports: https://github.com/randyzwitch/RSiteCatalyst

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  4: expect_output(SCAuth(Sys.getenv("USER", ""), Sys.getenv("SECRET", "")), "Authentication Succeeded.") at test-scauth.R:6
  5: expect_that(object, prints_text(regexp, ...), info = info, label = label)
  6: condition(object)
  7: evaluate_promise(expr, print = TRUE)
  8: with_sink(temp, withCallingHandlers(withVisible(code), warning = wHandler, message = mHandler))
  9: withCallingHandlers(withVisible(code), warning = wHandler, message = mHandler)
  10: withVisible(code)
  11: SCAuth(Sys.getenv("USER", ""), Sys.getenv("SECRET", ""))
  12: stop("Authentication failed due to errors")
  
  Error: Test failures
  In addition: There were 50 or more warnings (use warnings() to see the first 50)
  Execution halted
```

## rsnps (0.1.6)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/rsnps/issues

__OK__

## rSPACE (1.1.0)
Maintainer: Martha Ellis <martha.ellis@gmail.com>  
Bug reports: http://github.com/mmellis/rSPACE/issues

__OK__

## rspear (0.1-2)
Maintainer: Eduard Szoecs <eduardszoecs@gmail.com>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: rspear
Loading required package: reshape2
trying URL 'http://www.systemecology.eu/rspear/traits.csv'
Content type 'text/csv' length 127504 bytes (124 KB)
opened URL
==================================================
downloaded 124 KB

Warning in spear(spear_example, taxa = names(spear_example)[1], abundance = names(spear_example)[2],  :
  There were unmatched species:
xxxxxxxxx
Set SPEAR to 0.
Warning in spear(spear_example, taxa = names(spear_example)[1], abundance = names(spear_example)[2],  :
  Non-direct taxon matches!
Check trait table if match is appropiate!!
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'rspear.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## RStorm (0.902)
Maintainer: Maurits Kaptein <maurits@mauritskaptein.com>

```
checking dependencies in R code ... NOTE
Package in Depends field not imported from: ‘plyr’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
RStorm: no visible global function definition for ‘alply’
```

## rsunlight (0.3.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropengov/rsunlight/issues

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘rCharts’
```

## rtematres (0.2)
Maintainer: Claas-Thido Pfaff <claas-thido.pfaff@idiv-biodiversity.de>

__OK__

## rvertnet (0.2.2)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/rvertnet/issues

__OK__

## rWBclimate (0.1.3)
Maintainer: Edmund Hart <edmund.m.hart@gmail.com>  
Bug reports: http://github.com/ropensci/rWBclimate/issues

```
checking package dependencies ... ERROR
Package required but not available: ‘rgdal’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## RXKCD (1.7-5)
Maintainer: Paolo Sonego <paolo.sonego@gmail.com>

```
checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘RJSONIO’ ‘jpeg’ ‘png’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
getXKCD: no visible global function definition for ‘fromJSON’
getXKCD: no visible global function definition for ‘readPNG’
getXKCD: no visible global function definition for ‘readJPEG’
getXKCD: no visible global function definition for ‘writePNG’
```

## rYoutheria (1.0.0)
Maintainer: Tom August <tomaug@ceh.ac.uk>  
Bug reports: 
        https://github.com/biologicalrecordscentre/rYoutheria/issues

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'vignette.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## scales (0.2.4)
Maintainer: Hadley Wickham <h.wickham@gmail.com>  
Bug reports: https://github.com/hadley/scales/issues

```
checking dependencies in R code ... NOTE
Namespace in Imports field not imported from: ‘methods’
  All declared Imports should be used.
```

## scholar (0.1.2)
Maintainer: James Keirstead <j.keirstead@imperial.ac.uk>

__OK__

## semPlot (1.0.1)
Maintainer: Sacha Epskamp <mail@sachaepskamp.com>

```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘MplusAutomation’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
semPlotModel.mplus.model: no visible global function definition for
  ‘readModels’
```

## SensusR (1.0)
Maintainer: Matthew S. Gerber <gerber.matthew@gmail.com>

__OK__

## SeqFeatR (0.1.7)
Maintainer: Bettina Budeus <bettina.budeus@stud.uni-due.de>

```
checking package dependencies ... ERROR
Packages required but not available:
  ‘Biostrings’ ‘qvalue’ ‘widgetTools’ ‘calibrate’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## SGP (1.2-0.0)
Maintainer: Damian W. Betebenner <dbetebenner@nciea.org>  
Bug reports: https://github.com/CenterForAssessment/SGP/issues

```
checking package namespace information ... NOTE
  Namespace with empty importFrom: ‘reshape2’
```
```
checking installed package size ... NOTE
  installed size is  7.8Mb
  sub-directories of 1Mb or more:
    data   6.9Mb
```
```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘SGPdata’ ‘parallel’ ‘randomNames’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
abcSGP: no visible binding for global variable ‘SGPstateData’
analyzeSGP: no visible binding for global variable ‘SGPstateData’
analyzeSGP: no visible global function definition for ‘clusterApplyLB’
analyzeSGP: no visible global function definition for ‘mclapply’
analyzeSGP : <anonymous>: no visible binding for global variable
  ‘SGPstateData’
baselineSGP: no visible binding for global variable ‘SGPstateData’
bubblePlot_Styles: no visible binding for global variable
  ‘SGPstateData’
bubblePlot_Styles : get.my.cutscore.year: no visible binding for global
  variable ‘SGPstateData’
checkSGP: no visible binding for global variable ‘SGPstateData’
checksplineMatrix: no visible binding for global variable
  ‘SGPstateData’
combineSGP: no visible binding for global variable ‘SGPstateData’
combineSGP : get.target.arguments: no visible binding for global
  variable ‘SGPstateData’
csemScoreSimulator: no visible binding for global variable
  ‘SGPstateData’
getAchievementLevel : get.cutscore.label: no visible binding for global
  variable ‘SGPstateData’
getAchievementLevel : getAchievementLevel_INTERNAL: no visible binding
  for global variable ‘SGPstateData’
getKnotsBoundaries: no visible binding for global variable
  ‘SGPstateData’
getKnotsBoundaries : <anonymous>: no visible binding for global
  variable ‘SGPstateData’
getMaxOrderForProgression: no visible binding for global variable
  ‘SGPstateData’
getPercentileTableNames: no visible binding for global variable
  ‘SGPstateData’
getPreferredSGP: no visible binding for global variable ‘SGPstateData’
getTargetInitialStatus: no visible binding for global variable
  ‘SGPstateData’
getTargetSGP: no visible binding for global variable ‘SGPstateData’
getTargetSGPContentArea: no visible binding for global variable
  ‘SGPstateData’
getTargetScaleScore: no visible binding for global variable
  ‘SGPstateData’
getTargetScaleScore: no visible global function definition for
  ‘clusterApplyLB’
getTargetScaleScore : <anonymous>: no visible binding for global
  variable ‘SGPstateData’
getTargetScaleScore: no visible global function definition for
  ‘mclapply’
getYearsContentAreasGrades: no visible binding for global variable
  ‘SGPstateData’
gofSGP : .goodness.of.fit: no visible binding for global variable
  ‘SGPstateData’
growthAchievementPlot: no visible binding for global variable
  ‘SGPstateData’
growthAchievementPlot : get.my.label: no visible binding for global
  variable ‘SGPstateData’
growthAchievementPlot : create.long.cutscores: no visible binding for
  global variable ‘SGPstateData’
growthAchievementPlot : piecewise.transform: no visible binding for
  global variable ‘SGPstateData’
growthAchievementPlot : smoothPercentileTrajectory: no visible binding
  for global variable ‘SGPstateData’
outputSGP : get.my.label: no visible binding for global variable
  ‘SGPstateData’
outputSGP : piecewise.transform: no visible binding for global variable
  ‘SGPstateData’
outputSGP: no visible global function definition for ‘randomNames’
prepareSGP: no visible binding for global variable ‘sgpData_LONG’
sqliteSGP: no visible binding for global variable ‘SGPstateData’
sqliteSGP : get.grade: no visible binding for global variable
  ‘SGPstateData’
sqliteSGP : get.year: no visible binding for global variable
  ‘SGPstateData’
startParallel: no visible global function definition for ‘clusterEvalQ’
startParallel: no visible global function definition for
  ‘clusterExport’
startParallel: no visible global function definition for ‘makeCluster’
stopParallel: no visible global function definition for ‘stopCluster’
studentGrowthPercentiles : .create.coefficient.matrices: no visible
  global function definition for ‘mclapply’
studentGrowthPercentiles : .create.coefficient.matrices: no visible
  global function definition for ‘parLapplyLB’
studentGrowthPercentiles : .simex.sgp: no visible binding for global
  variable ‘SGPstateData’
studentGrowthPercentiles : .simex.sgp: no visible global function
  definition for ‘mclapply’
studentGrowthPercentiles : .simex.sgp: no visible global function
  definition for ‘parLapply’
studentGrowthPercentiles: no visible binding for global variable
  ‘SGPstateData’
studentGrowthPlot: no visible binding for global variable
  ‘SGPstateData’
studentGrowthPlot : get.my.cutscore.year: no visible binding for global
  variable ‘SGPstateData’
studentGrowthPlot_Styles : create.long.cutscores.sgPlot: no visible
  binding for global variable ‘SGPstateData’
studentGrowthPlot_Styles: no visible binding for global variable
  ‘SGPstateData’
studentGrowthProjections : .get.trajectories.and.cuts: no visible
  binding for global variable ‘SGPstateData’
studentGrowthProjections: no visible binding for global variable
  ‘SGPstateData’
summarizeSGP: no visible binding for global variable ‘SGPstateData’
summarizeSGP : summarizeSGP.config: no visible binding for global
  variable ‘SGPstateData’
summarizeSGP : summarizeSGP_INTERNAL: no visible global function
  definition for ‘parLapply’
summarizeSGP : summarizeSGP_INTERNAL: no visible global function
  definition for ‘mclapply’
testSGP: no visible global function definition for ‘detectCores’
visualizeSGP : get.max.order.for.progression: no visible binding for
  global variable ‘SGPstateData’
visualizeSGP : get.gaPlot.iter: no visible binding for global variable
  ‘SGPstateData’
visualizeSGP: no visible binding for global variable ‘SGPstateData’
visualizeSGP: no visible global function definition for
  ‘clusterApplyLB’
visualizeSGP: no visible global function definition for ‘mclapply’
visualizeSGP : get.next.grade: no visible binding for global variable
  ‘SGPstateData’
visualizeSGP : get.my.label: no visible binding for global variable
  ‘SGPstateData’
visualizeSGP : piecewise.transform: no visible binding for global
  variable ‘SGPstateData’
visualizeSGP: no visible global function definition for ‘randomNames’
```

## sharpshootR (0.7-2)
Maintainer: Dylan Beaudette <dylan.beaudette@ca.usda.gov>

```
checking package dependencies ... ERROR
Packages required but not available: ‘aqp’ ‘soilDB’

Packages suggested but not available for checking: ‘rgdal’ ‘spdep’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## simTool (1.0.3)
Maintainer: Marsel Scheer <scheer@freescience.de>

__OK__

## smatr (3.4-3)
Maintainer: Remko Duursma <remkoduursma@gmail.com>

```
checking dependencies in R code ... NOTE
Package in Depends field not imported from: ‘plyr’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
fitted.sma: no visible global function definition for ‘join’
```

## snht (1.0.2)
Maintainer: Josh Browning <jbrownin@mines.edu>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: gridExtra
Loading required package: grid
Warning in loop_apply(n, do.ply) :
  Removed 60 rows containing missing values (geom_path).
Warning in loop_apply(n, do.ply) :
  Removed 60 rows containing missing values (geom_path).
Warning in loop_apply(n, do.ply) :
  Removed 120 rows containing missing values (geom_path).
Warning in loop_apply(n, do.ply) :
  Removed 400 rows containing missing values (geom_path).
Warning in loop_apply(n, do.ply) :
  Removed 400 rows containing missing values (geom_path).
Warning in robustSNHTunequal(data = data, period = period, time = time,  :
  Only integer values of time are used!  Rounding down.
Warning in loop_apply(n, do.ply) :
  Removed 6 rows containing missing values (geom_path).
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'snht.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## soil.spec (2.1.4)
Maintainer: Andrew Sila <a.sila@cgiar.org>

```
checking package dependencies ... ERROR
Package required but not available: ‘GSIF’

Packages suggested but not available for checking:
  ‘plotKML’ ‘spatstat’ ‘date’ ‘rgdal’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## soilDB (1.5-2)
Maintainer: D.E. Beaudette <dylan.beaudette@ca.usda.gov>

```
checking package dependencies ... ERROR
Package required but not available: ‘aqp’

Packages suggested but not available for checking:
  ‘XMLSchema’ ‘SSOAP’ ‘dismo’ ‘rgdal’ ‘RODBC’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## solr (0.1.4)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: http://www.github.com/ropensci/solr/issues

__OK__

## sorvi (0.7.20)
Maintainer: Leo Lahti <louhos@googlegroups.com>  
Bug reports: https://github.com/ropengov/sorvi/issues

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading http://data.okf.fi/ropengov/avoindata//louhos/translations.rda
Loading http://data.okf.fi/ropengov/avoindata/mml/rdata/Yleiskartta-1000/HallintoAlue_DataFrame.RData. (C) MML 2013. Converted to RData shape object by Louhos. For more information, see https://github.com/avoindata/mml/
Downloading data from http://fi.wikipedia.org/wiki/Luettelo_Suomen_postinumeroista_kunnittain
Loading http://data.okf.fi/ropengov/avoindata/mml/rdata/Yleiskartta-1000/HallintoAlue_DataFrame.RData. (C) MML 2013. Converted to RData shape object by Louhos. For more information, see https://github.com/avoindata/mml/
Loading http://data.okf.fi/ropengov/avoindata/mml/rdata/Yleiskartta-1000/HallintoAlue_DataFrame.RData. (C) MML 2013. Converted to RData shape object by Louhos. For more information, see https://github.com/avoindata/mml/
Loading http://data.okf.fi/ropengov/avoindata/mml/rdata/Yleiskartta-1000/HallintoAlue_DataFrame.RData. (C) MML 2013. Converted to RData shape object by Louhos. For more information, see https://github.com/avoindata/mml/
Loading http://data.okf.fi/ropengov/avoindata/mml/rdata/Yleiskartta-1000/HallintoAlue_DataFrame.RData. (C) MML 2013. Converted to RData shape object by Louhos. For more information, see https://github.com/avoindata/mml/
Loading http://data.okf.fi/ropengov/avoindata/mml/rdata/Yleiskartta-1000/HallintoAlue_DataFrame.RData. (C) MML 2013. Converted to RData shape object by Louhos. For more information, see https://github.com/avoindata/mml/

Attaching package: 'plyr'

The following objects are masked from 'package:reshape':

    rename, round_any

Computing boostrapped smoothers ...
convert bootstrapped spaghettis to long format
Computing density estimates for each vertical cut ...
Build ggplot figure ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'sorvi.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## spanr (1.0)
Maintainer: Roger Marshall <rj.marshall@auckland.ac.nz>

```
checking whether package ‘spanr’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/RtmpaTGn9N/check_cran3da26de4b7c3/spanr.Rcheck/00install.out’ for details.
```

## sparseMVN (0.2.0)
Maintainer: Michael Braun <braunm@smu.edu>

__OK__

## spiders (1.0)
Maintainer: Edward A. Roualdes <edward.roualdes@uky.edu>

__OK__

## srd (1.0)
Maintainer: Roger Marshall <rj.marshall@auckland.ac.nz>

```
checking whether package ‘srd’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/RtmpaTGn9N/check_cran3da26de4b7c3/srd.Rcheck/00install.out’ for details.
```

## ss3sim (0.8.2)
Maintainer: Sean Anderson <sean@seananderson.ca>

```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘foreach’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
run_ss3sim: no visible global function definition for ‘%dopar%’
run_ss3sim: no visible global function definition for ‘foreach’
setup_parallel: no visible global function definition for
  ‘getDoParWorkers’
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'ss3sim-vignette.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## SSrat (1.0)
Maintainer: Hans Landsheer <j.a.landsheer@uu.nl>

__OK__

## sss (0.0-11)
Maintainer: Andrie de Vries <apdevries@gmail.com>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
The sss package is in early stages of development and still considered experimental.
Read 3 items
Reading SSS metadata
Reading SSS data
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'sss.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## Stack (2.0-1)
Maintainer: Mike Malecki <Mike.Malecki@yougov.com>

__OK__

## statcheck (1.0.1)
Maintainer: Michele B. Nuijten <m.b.nuijten@uvt.nl>

__OK__

## StatRank (0.0.4)
Maintainer: William Chen <williamzc@gmail.com>

```
checking R code for possible problems ... NOTE
Visualization.Empirical: no visible global function definition for
  ‘ggplot’
Visualization.Empirical: no visible global function definition for
  ‘aes’
Visualization.Empirical: no visible global function definition for
  ‘geom_bar’
Visualization.Empirical: no visible global function definition for
  ‘scale_x_reverse’
Visualization.Empirical: no visible global function definition for
  ‘ggtitle’
Visualization.Empirical: no visible global function definition for
  ‘labs’
Visualization.Empirical: no visible global function definition for
  ‘scale_y_continuous’
Visualization.Empirical: no visible binding for global variable
  ‘grid.arrange’
Visualization.MultiType: no visible global function definition for
  ‘ggplot’
Visualization.MultiType: no visible global function definition for
  ‘aes’
Visualization.MultiType: no visible global function definition for
  ‘geom_line’
Visualization.MultiType: no visible global function definition for
  ‘labs’
Visualization.MultiType: no visible global function definition for
  ‘geom_vline’
Visualization.MultiType: no visible global function definition for
  ‘scale_color_manual’
Visualization.MultiType: no visible global function definition for
  ‘scale_linetype_manual’
Visualization.MultiType: no visible global function definition for
  ‘theme’
Visualization.MultiType: no visible binding for global variable
  ‘grid.arrange’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘ggplot’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘aes’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘geom_tile’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘geom_text’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘scale_fill_gradient’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘labs’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘scale_x_discrete’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘scale_y_reverse’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘theme_bw’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘theme’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘element_blank’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘element_text’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘coord_fixed’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘guides’
Visualization.Pairwise.Probabilities : Generate.Pairwise.Matrix.Plot:
  no visible global function definition for ‘guide_legend’
Visualization.Pairwise.Probabilities: no visible global function
  definition for ‘grid.arrange’
Visualization.Pairwise.Probabilities: no visible global function
  definition for ‘textGrob’
Visualization.Pairwise.Probabilities: no visible global function
  definition for ‘gpar’
Visualization.RUMplots.Exponential : <anonymous>: no visible global
  function definition for ‘qplot’
Visualization.RUMplots.Exponential : <anonymous>: no visible global
  function definition for ‘labs’
Visualization.RUMplots.Exponential : <anonymous>: no visible global
  function definition for ‘geom_vline’
Visualization.RUMplots.Exponential: no visible binding for global
  variable ‘grid.arrange’
Visualization.RUMplots.Gumbel : <anonymous>: no visible global function
  definition for ‘qplot’
Visualization.RUMplots.Gumbel : <anonymous>: no visible global function
  definition for ‘labs’
Visualization.RUMplots.Gumbel : <anonymous>: no visible global function
  definition for ‘geom_vline’
Visualization.RUMplots.Gumbel: no visible binding for global variable
  ‘grid.arrange’
Visualization.RUMplots.Nonparametric : <anonymous>: no visible global
  function definition for ‘qplot’
Visualization.RUMplots.Nonparametric : <anonymous>: no visible global
  function definition for ‘labs’
Visualization.RUMplots.Nonparametric : <anonymous>: no visible global
  function definition for ‘scale_y_continuous’
Visualization.RUMplots.Nonparametric: no visible binding for global
  variable ‘grid.arrange’
Visualization.Surfaceplots : makewireframe: no visible global function
  definition for ‘wireframe’
Visualization.Surfaceplots: no visible global function definition for
  ‘grid.arrange’
```

## strvalidator (1.4.0)
Maintainer: Oskar Hansson <oskar.hansson@fhi.no>  
Bug reports: https://github.com/OskarHansson/strvalidator/issues

```
checking package dependencies ... ERROR
Packages required but not available: ‘gWidgetsRGtk2’ ‘RGtk2’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## surveydata (0.1-14)
Maintainer: Andrie de Vries <apdevries@gmail.com>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'surveydata.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## synthpop (1.1-0)
Maintainer: Beata Nowok <beata.nowok@gmail.com>

```
checking dependencies in R code ... NOTE
Unexported object imported by a ':::' call: ‘coefplot:::position_dodgev’
  See the note in ?`:::` about the use of this operator.
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: lattice
Loading required package: MASS
Loading required package: nnet
Loading required package: ggplot2
Loading required package: coefplot
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'synthpop.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## taRifx (1.0.6)
Maintainer: Ari B. Friedman <abfriedman@gmail.com>

```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘gdata’ ‘ggplot2’ ‘grid’ ‘lattice’ ‘xtable’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
autoplot.microbenchmark: no visible global function definition for
  ‘ggplot’
autoplot.microbenchmark: no visible global function definition for
  ‘aes’
autoplot.microbenchmark: no visible global function definition for
  ‘coord_cartesian’
autoplot.microbenchmark: no visible global function definition for
  ‘stat_summary’
autoplot.microbenchmark: no visible global function definition for
  ‘opts’
autoplot.microbenchmark: no visible global function definition for
  ‘theme_text’
compareplot: no visible global function definition for ‘grid.newpage’
compareplot: no visible global function definition for
  ‘latticeParseFormula’
compareplot: no visible global function definition for ‘pushViewport’
compareplot: no visible global function definition for ‘viewport’
compareplot: no visible global function definition for ‘grid.layout’
compareplot: no visible global function definition for ‘unit’
compareplot: no visible global function definition for ‘seekViewport’
compareplot: no visible global function definition for ‘grid.rect’
compareplot : makeNat: no visible global function definition for
  ‘convertUnit’
compareplot: no visible global function definition for ‘grid.text’
compareplot: no visible global function definition for ‘gpar’
compareplot: no visible global function definition for ‘grid.lines’
compareplot: no visible global function definition for ‘grid.points’
compareplot: no visible global function definition for ‘grid.polyline’
compareplot: no visible global function definition for ‘upViewport’
compareplot: no visible global function definition for ‘convertUnit’
compareplot: no visible global function definition for ‘popViewport’
hist_horiz: no visible global function definition for
  ‘latticeParseFormula’
latex.table.by: no visible global function definition for ‘xtable’
panel.densityplot.enhanced: no visible global function definition for
  ‘panel.densityplot’
panel.densityplot.enhanced: no visible global function definition for
  ‘unit’
panel.densityplot.enhanced: no visible global function definition for
  ‘grid.text’
panel.densityplot.enhanced: no visible global function definition for
  ‘gpar’
panel.ecdf: no visible global function definition for ‘panel.xyplot’
panel.ecdf: no visible global function definition for ‘panel.lines’
panel.xyplot_rug: no visible global function definition for
  ‘panel.xyplot’
panel.xyplot_rug: no visible global function definition for
  ‘grid.segments’
panel.xyplot_rug: no visible global function definition for ‘unit’
panel.xyplot_rug: no visible global function definition for ‘gpar’
searchPattern: no visible global function definition for ‘interleave’
xtable.CrossTable: no visible global function definition for
  ‘caption<-’
xtable.CrossTable: no visible global function definition for ‘label<-’
xtable.CrossTable: no visible global function definition for ‘align<-’
xtable.CrossTable: no visible global function definition for ‘digits<-’
xtable.CrossTable: no visible global function definition for
  ‘display<-’
xtable.summary.lme: no visible global function definition for
  ‘caption<-’
xtable.summary.lme: no visible global function definition for ‘label<-’
xtable.summary.lme: no visible global function definition for ‘align<-’
xtable.summary.lme: no visible global function definition for
  ‘digits<-’
xtable.summary.lme: no visible global function definition for
  ‘display<-’
xtablelm: no visible global function definition for ‘xtable’
```

## taxize (0.5.2)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/taxize/issues

__OK__

## TH.data (1.0-6)
Maintainer: Torsten Hothorn <Torsten.Hothorn@R-project.org>

```
checking installed package size ... NOTE
  installed size is  5.2Mb
  sub-directories of 1Mb or more:
    data   1.1Mb
    rda    3.8Mb
```

## timeordered (0.9.8)
Maintainer: Benjamin Blonder <bblonder@gmail.com>

__OK__

## TimeProjection (0.2.0)
Maintainer: Jeffrey Wong <jeff.ct.wong@gmail.com>

```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘ggplot2’ ‘plyr’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
Packages in Depends field not imported from:
  ‘Matrix’ ‘lubridate’ ‘timeDate’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
is.Bizday: no visible global function definition for ‘isWeekday’
plotCalendarHeatmap: no visible global function definition for ‘ddply’
plotCalendarHeatmap: no visible global function definition for ‘.’
plotCalendarHeatmap: no visible binding for global variable ‘year’
plotCalendarHeatmap: no visible binding for global variable ‘month’
plotCalendarHeatmap: no visible binding for global variable ‘week’
plotCalendarHeatmap: no visible global function definition for ‘ggplot’
plotCalendarHeatmap: no visible global function definition for ‘aes’
plotCalendarHeatmap: no visible binding for global variable ‘monthweek’
plotCalendarHeatmap: no visible binding for global variable ‘weekday’
plotCalendarHeatmap: no visible global function definition for
  ‘geom_tile’
plotCalendarHeatmap: no visible global function definition for
  ‘facet_grid’
plotCalendarHeatmap: no visible global function definition for
  ‘scale_fill_gradientn’
projectDate: no visible global function definition for ‘holidayNYSE’
projectDate: no visible global function definition for
  ‘sparse.model.matrix’
```

## TR8 (0.9.13)
Maintainer: Gionata Bocci <boccigionata@gmail.com>  
Bug reports: https://github.com/GioBo/TR8/issues

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'Expanding_TR8.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## trapezoid (2.0-0)
Maintainer: Jeremy Thoms Hetzel <jthetzel@gmail.com>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: trapezoid
Loading required package: plyr
Loading required package: ggplot2
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'trapezoid.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## treeclim (1.0.11)
Maintainer: Christian Zang <christian.zang@wzw.tum.de>

```
checking package dependencies ... ERROR
Package required but not available: ‘RcppArmadillo’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## treecm (1.2.1)
Maintainer: Marco Bascietto <marco.bascietto@cnr.it>

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Error : Mapping a variable to y and also using stat="bin".
  With stat="bin", it will attempt to set the y value to the count of cases in each group.
  This can result in unexpected behavior and will not be allowed in a future version of ggplot2.
  If you want y to represent counts of cases, use stat="bin" and don't map a variable to y.
  If you want y to represent values in the data, use stat="identity".
  See ?geom_bar for examples. (Defunct; last used in version 0.9.2)
Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'treecm.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## TripleR (1.4)
Maintainer: Felix Schönbrodt <felix.schoenbrodt@psy.lmu.de>

__OK__

## unmarked (0.10-6)
Maintainer: Richard Chandler <rbchan@uga.edu>

```
checking package dependencies ... ERROR
Package required but not available: ‘RcppArmadillo’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## useful (1.1.8)
Maintainer: Jared P. Lander <packages@jaredlander.com>

__OK__

## userfriendlyscience (0.2-1)
Maintainer: Gjalt-Jorn Peters <gjalt-jorn@userfriendlyscience.com>

__OK__

## ustyc (1.0.0)
Maintainer: Matt Barry <mrb@softisms.com>  
Bug reports: https://github.com/mrbcuda/ustyc/issues

__OK__

## vardpoor (0.2.8)
Maintainer: Juris Breidaks <Juris.Breidaks@csb.gov.lv>  
Bug reports: https://github.com/CSBLatvia/vardpoor/issues/

__OK__

## vcdExtra (0.6-5)
Maintainer: Michael Friendly <friendly@yorku.ca>

```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘rgl’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘alr3’
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Loading required package: vcd
Loading required package: grid
Loading required package: gnm
The following objects are masked _by_ .GlobalEnv:

    A, B, C

Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
  Running 'texi2dvi' on 'vcd-tutorial.tex' failed.
Messages:
sh: /usr/local/bin/texi2dvi: No such file or directory
Calls: buildVignettes -> texi2pdf -> texi2dvi
Execution halted

```

## vdmR (0.1.0)
Maintainer: Tomokazu Fujino <fujino@fwu.ac.jp>

```
checking package dependencies ... ERROR
Packages required but not available: ‘gridSVG’ ‘Rook’

Package suggested but not available for checking: ‘rgeos’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## vetools (1.3-28)
Maintainer: Andrew Sajo-Castelli <asajo@usb.ve>  
Bug reports: https://github.com/talassio/vetools/issues

__OK__

## Wats (0.2-16)
Maintainer: Will Beasley <wibeasley@hotmail.com>

__OK__

## WCE (1.0)
Maintainer: Marie-Pierre Sylvestre <marie-pierre.sylvestre@umontreal.ca>

__OK__

## weatherData (0.4.1)
Maintainer: Ram Narasimhan <ramnarasimhan@gmail.com>

```
checking R code for possible problems ... NOTE
getStationCode: no visible binding for global variable
  ‘USAirportWeatherStations’
getStationCode: no visible binding for global variable ‘IntlWxStations’
```

## wordmatch (1.0)
Maintainer: Amit Singh Rathore <amitplatinum@gmail.com>

```
checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘plyr’ ‘reshape2’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
```
```
checking R code for possible problems ... NOTE
wordmatch: no visible global function definition for ‘llply’
wordmatch : <anonymous>: no visible global function definition for
  ‘llply’
wordmatch: no visible global function definition for ‘melt’
wordmatch: no visible global function definition for ‘count’
```

## wppExplorer (1.5-0)
Maintainer: Hana Sevcikova <hanas@uw.edu>

__OK__

## WRS2 (0.3-1)
Maintainer: Patrick Mair <mair@fas.harvard.edu>

__OK__

## XML2R (0.0.6)
Maintainer: Carson Sievert <sievert@iastate.edu>  
Bug reports: http://github.com/cpsievert/XML2R/issues

__OK__

## yhatr (0.13.4)
Maintainer: Greg Lamp <greg@yhathq.com>

__OK__

## ykmeans (1.0)
Maintainer: Yohei Sato <yohei0511@gmail.com>

__OK__


library(RUnit)
library(plyr)

testSuite <- defineTestSuite(
  dirs=system.file("tests", package = "plyr"),
  name=paste("plyr unit tests"),
  testFileRegexp = "\\.runit$",
  testFuncRegexp = "^test"
)

tests <- runTestSuite(testSuite)
printTextProtocol(tests, showDetails=TRUE)

tmp <- getErrors(tests)
if(tmp$nFail > 0 | tmp$nErr > 0) {
  stop(paste("\n\nUnit testing failed (#test failures: ", tmp$nFail,
             ", #R errors: ",  tmp$nErr, ")\n\n", sep=""))
}

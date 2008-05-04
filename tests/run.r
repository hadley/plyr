testSuite <- defineTestSuite(
  name=paste("reshape unit tests"),
  testFileRegexp = "\\.runit$",
  dirs=path
)
tests <- runTestSuite(testSuite)
printTextProtocol(tests, showDetails=TRUE)

tmp <- getErrors(tests)
if(tmp$nFail > 0 | tmp$nErr > 0) {
  stop(paste("\n\nUnit testing failed (#test failures: ", tmp$nFail,
             ", #R errors: ",  tmp$nErr, ")\n\n", sep=""))
}

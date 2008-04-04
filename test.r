library(RUnit)
FILE <- (function() {
  attr(body(sys.function()), "srcfile")
})()$filename
PATH <- dirname(FILE)
source(file.path(PATH, "load.r"))

testSuite <- defineTestSuite(
  dirs=file.path(PATH, "test"),
  name=paste("plyr unit tests"),
  testFileRegexp = "\\.runit$",
  testFuncRegexp = "^test"
)
capture.output(tests <- runTestSuite(testSuite))
printTextProtocol(tests, showDetails=FALSE)

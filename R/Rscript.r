#R script to calculate the different correlation values using the input data from Qlikview.
#Initialize output Variables with NA
		vMeanCorrel <- NA
		vMeanLnCorrel <- NA
		vProdWeightCorrel <- NA
		vLnProdWeightCorrel <- NA
		vRealizedCorrelStk <- NA
		vStkVolatality <- NA
		vLnStkVolatality <-NA
		vIdxStkCorrelmean <- NA
		vIdxStkLnCorrelmean <- NA
		vIdxStkProdWeightCorrel <- NA
		vIdxStkLnProdWeightCorrel <-NA
		vMeanSecCorrel <- NA
		vMeanSecLnCorrel <- NA 
		vSecProdWeightCorrel <- NA
		vSecLnProdWeightCorrel <- NA
		vRealizedCorrelSec <- NA
		vSecVolatality <- NA
		vLnSecVolatality <- NA
		vIdxSecCorrelmean <- NA
		vIdxSecLnCorrelmean <- NA
		vIdxSecProdWeightCorrel <- NA
		vIdxSecLnProdWeightCorrel <- NA
		vCommonStkCount <- NA
		vCommonSecCount <- NA
		vObservationCount <- NA
		vIdxStkDispersion <- NA
		vIdxSecDispersion <- NA
#try is used across the code to skip steps in case of any errors and to make sure that a file is always created at the end of the script 
#try starts here and silent mode is enabled
	options(digits=15) 
	#read the arguments(output file names and frequency) passed from Qlikview
		vArgPassedFromQv <- commandArgs(TRUE)
		vUnlistArg <- unlist(strsplit(vArgPassedFromQv, ","))
		vOCorrelFileName <- vUnlistArg[1]
		vIStkReturnsFileName <- vUnlistArg[2]
		vIIdxReturnsFileName <- vUnlistArg[3]
		vIStkWeightsFileName <- vUnlistArg[4]
		vISecReturnsFileName <- vUnlistArg[5]
		vISecWeightsFileName <- vUnlistArg[6]
	#function declaration
	#Read CSV function
		fnReadCSV <- function(vFileName) 
			{
				read.csv(vFileName,header = FALSE, sep = ",",dec = ".", fill = TRUE, skip=1,comment.char = "")
			}
	
		fnModifyWeightsCSV <- function(vFileData) 
			{
				return(as.matrix(vFileData[1,-1:-2]))
			}
		fnModifyReturnsCSV <- function(vFileData) 
			{
				return(as.matrix(vFileData[,-1:-2]))
			}
	#Calculate Normalized weighted
		fnNormalizedWeight <- function(vReadWeights) 
			{	
				return((vReadWeights)/sum(vReadWeights))
				
			}
	#Calculate Normalized weighted matrix
		fnNormalizedWeightMatrix <- function(vReadWeights) 
			{	
				return(as.matrix(vReadWeights))
			}
	#Calculate Correlation
		fnCorrel <- function(vReadReturns,vReadReturns2) 
			{	
				return(cor(vReadReturns,vReadReturns2))
			}
	#calculate Mean Correlation
		fnMeanCorrelation <- function(vCorreltemp) 
			{
				diag(vCorreltemp) <- NA
				return(mean(vCorreltemp, na.rm=TRUE))
			}
	#calculate Product weighted Correlation
		fnPWCorrelation <- function(vCorreltemp,vWeights,vWeightsMatrix) 
			{
				diag(vCorreltemp) <- 0
				vWeightsProd <- 1-sum(vWeights^2)
				vCorrelMatrix <- as.matrix(vCorreltemp)
				vWeightCorrel <- vWeightsMatrix%*%vCorrelMatrix%*%t(vWeightsMatrix)
				return(vWeightCorrel/vWeightsProd)
			}
	#Calculate Realized Correlation value
	fnRealizedCorrelation <- function(vLnReturns,vIdxLnReturns,vWeights,vWeightsMatrix) 
			{	
				vReturns <- sqrt(colSums(vLnReturns^2))
				vIdxReturns <- sum(vIdxLnReturns^2)
				vWeights_temp <- vWeights^2
				vReturnsMatrix <- as.matrix(vReturns)
				vWeightsMatrix_temp <- as.matrix(vWeights_temp)
				vnumerator <- vIdxReturns - ((vWeightsMatrix_temp)%*%((vReturnsMatrix)^2))
				vdenominator_stg <- (t(vWeightsMatrix)%*%vWeightsMatrix) *((vReturnsMatrix)%*%t(vReturnsMatrix))
				diag(vdenominator_stg) <-0
				vdenominator <-sum(vdenominator_stg)
				return(vnumerator/vdenominator)
			}
	#Calculate Weighted Volatility
	fnWeightedVolatality <- function(vReadReturns,vWeightsMatrix) 
			{	
				vVolReturnMatrix <- as.matrix(vReadReturns)
				return(vWeightsMatrix%*%apply(vVolReturnMatrix,2,sd)*sqrt(252))
			}
	#Calculate Index Level Correlation
	fnIndexCorrelation <- function(vIdxCorrel) 
			{	
				return(mean(vIdxCorrel))			
			}
	#Calculate Product weighted Index Level Correlation
	fnPWIndexCorrelation <- function(vIdxCorrel,vWeightsMatrix) 
			{	
				vIdxStkCorrelMatrix <- as.matrix(vIdxCorrel)
				return(vWeightsMatrix%*%vIdxStkCorrelMatrix)
			}
	#Calculate Dispersion
	fnDispersion <- function(vReadReturns,vWeightsMatrix,vReadIdxRet) 
			{	
			is.na(vReadReturns) <-0
			vReadReturns <- (apply(vReadReturns+1,2,prod))-1	
			return(sqrt(vWeightsMatrix%*%((vReadReturns-vReadIdxRet)^2)))	
			}
try({
	#read the input files 
		vReadStkReturns <- fnReadCSV(vIStkReturnsFileName)
		vReadStkWeights <- fnReadCSV(vIStkWeightsFileName)
		vReadIdxReturns <- fnReadCSV(vIIdxReturnsFileName)
		vReadSecReturns <- fnReadCSV(vISecReturnsFileName)
		vReadSecWeights <- fnReadCSV(vISecWeightsFileName)
	#Index level
		vReadIdxReturns <- fnModifyReturnsCSV(vReadIdxReturns)
	#Stock Level
		vReadStkWeights <- fnModifyWeightsCSV(vReadStkWeights)
		vReadStkReturns <- fnModifyReturnsCSV(vReadStkReturns)
	#Sector Level	
		vReadSecWeights <- fnModifyWeightsCSV(vReadSecWeights)
		vReadSecReturns <- fnModifyReturnsCSV(vReadSecReturns)	
	#Calculate Index Return over a  period for Dispersion 
		is.na(vReadIdxReturns) <-0
		vIndexRet <- (apply(vReadIdxReturns+1,2,prod))-1	
	#Check if rows and column counts are as expected
		if((nrow(vReadStkReturns) == nrow(vReadIdxReturns)) && (nrow(vReadSecReturns) == nrow(vReadIdxReturns)) && (ncol(vReadStkReturns) == ncol(vReadStkWeights)) && (ncol(vReadSecReturns) == ncol(vReadSecWeights)) &&  (nrow(vReadSecWeights)== 1) && (nrow(vReadStkWeights)== 1)) 
		{
	#Get the counts 
		vCommonStkCount <- ncol(vReadStkReturns)
		vCommonSecCount <- ncol(vReadSecReturns)
		vObservationCount <- nrow(vReadIdxReturns)
	#Trim unwanted columns
		vReadLogStkReturns <- log(vReadStkReturns+1)
		vReadLogSecReturns <- log(vReadSecReturns+1)
		vReadLogIdxReturns <- log(vReadIdxReturns+1)
	#Calculate Correlation
		vStkCorrel <- fnCorrel(vReadStkReturns,vReadStkReturns)
		vSecCorrel <- fnCorrel(vReadSecReturns,vReadSecReturns)
		vLogStkCorrel <- fnCorrel(vReadLogStkReturns,vReadLogStkReturns)
		vLogSecCorrel <- fnCorrel(vReadLogSecReturns,vReadLogSecReturns)
		vIdxStkCorrel <- fnCorrel(vReadStkReturns,vReadIdxReturns)
		vLogIdxStkCorrel <- fnCorrel(vReadLogStkReturns,vReadLogIdxReturns)
		vIdxSecCorrel <- fnCorrel(vReadSecReturns,vReadIdxReturns)
		vLogIdxSecCorrel <- fnCorrel(vReadLogSecReturns,vReadLogIdxReturns)
	#Calculate Normalized Weight matrix
		vStkWeights <- fnNormalizedWeight(vReadStkWeights)
		vSecWeights <- fnNormalizedWeight(vReadSecWeights)
		vStkWeightsMatrix <- fnNormalizedWeightMatrix(vStkWeights)
		vSecWeightsMatrix <- fnNormalizedWeightMatrix(vSecWeights)
	#Stock Level Mean Correlation
		vMeanCorrel <- fnMeanCorrelation(vStkCorrel)
		vMeanLnCorrel <- fnMeanCorrelation(vLogStkCorrel)
	#Sector Level Mean Correlation
		vMeanSecCorrel <- fnMeanCorrelation(vSecCorrel)
		vMeanSecLnCorrel <- fnMeanCorrelation(vLogSecCorrel)
	#Stock Level product of weight correlation calculation with log returns and without log returns
		vProdWeightCorrel <- fnPWCorrelation(vStkCorrel,vStkWeights,vStkWeightsMatrix)
		vLnProdWeightCorrel <- fnPWCorrelation(vLogStkCorrel,vStkWeights,vStkWeightsMatrix)
	#Sector Level product of weight correlation calculation with log returns and without log returns		
		vSecProdWeightCorrel <- fnPWCorrelation(vSecCorrel,vSecWeights,vSecWeightsMatrix)
		vSecLnProdWeightCorrel <- fnPWCorrelation(vLogSecCorrel,vSecWeights,vSecWeightsMatrix)
	#Calculate Realized Correlation value
		vRealizedCorrelStk <- fnRealizedCorrelation(vReadLogStkReturns,vReadLogIdxReturns,vStkWeights,vStkWeightsMatrix)
	#Sector Level Realized Correlation value
		vRealizedCorrelSec <- fnRealizedCorrelation(vReadLogSecReturns,vReadLogIdxReturns,vSecWeights,vSecWeightsMatrix)
	#Calculate Weighted Volatility
		vStkVolatality <- fnWeightedVolatality(vReadStkReturns,vStkWeightsMatrix)
		vLnStkVolatality <- fnWeightedVolatality(vReadLogStkReturns,vStkWeightsMatrix)
	#Sector Level Weighted Volatility
		vSecVolatality <- fnWeightedVolatality(vReadSecReturns,vSecWeightsMatrix)
		vLnSecVolatality <- fnWeightedVolatality(vReadLogSecReturns,vSecWeightsMatrix)
	#Calculate Index Stock Mean Correlation
		vIdxStkCorrelmean <- fnIndexCorrelation(vIdxStkCorrel)
		vIdxStkLnCorrelmean <- fnIndexCorrelation(vLogIdxStkCorrel)
	#Calculate Index Sector Mean Correlation
		vIdxSecCorrelmean <- fnIndexCorrelation(vIdxSecCorrel)
		vIdxSecLnCorrelmean <- fnIndexCorrelation(vLogIdxSecCorrel)
	#Calculate Index Stock PW Correlation
		vIdxStkProdWeightCorrel <- fnPWIndexCorrelation(vIdxStkCorrel,vStkWeightsMatrix)
		vIdxStkLnProdWeightCorrel <- fnPWIndexCorrelation(vLogIdxStkCorrel,vStkWeightsMatrix)
	#Calculate Index Sector PW Correlation
		vIdxSecProdWeightCorrel <- fnPWIndexCorrelation(vIdxSecCorrel,vSecWeightsMatrix)
		vIdxSecLnProdWeightCorrel <- fnPWIndexCorrelation(vLogIdxSecCorrel,vSecWeightsMatrix)
	#Calculate Stock and Sector Level Dispersion
		vIdxStkDispersion <- fnDispersion(vReadStkReturns,vStkWeightsMatrix,vIndexRet)
		vIdxSecDispersion <- fnDispersion(vReadSecReturns,vSecWeightsMatrix,vIndexRet)
		}
}
,silent=TRUE)
#try ends here
#Write the Correlation and Log Correlation values to corresponding output files 
#concatenate output string
		vOutput <- paste(vMeanCorrel,vMeanLnCorrel,vProdWeightCorrel,vLnProdWeightCorrel,vRealizedCorrelStk,vStkVolatality,vLnStkVolatality,vIdxStkCorrelmean,vIdxStkLnCorrelmean,vIdxStkProdWeightCorrel,vIdxStkLnProdWeightCorrel,vMeanSecCorrel,vMeanSecLnCorrel,vSecProdWeightCorrel,vSecLnProdWeightCorrel,vRealizedCorrelSec,vSecVolatality,vLnSecVolatality,vIdxSecCorrelmean,vIdxSecLnCorrelmean,vIdxSecProdWeightCorrel,vIdxSecLnProdWeightCorrel,vCommonStkCount,vCommonSecCount,vObservationCount,vIdxStkDispersion,vIdxSecDispersion,sep=',')
		write(vOutput, vOCorrelFileName, append = FALSE)

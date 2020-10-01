## ---- echo = FALSE------------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## -----------------------------------------------------------------------------
# load all packages need
# set seed for reproducibility 
library('microclustr')
set.seed(123)

## -----------------------------------------------------------------------------
# true partition to generate simulated data
# 50 clusters of each size, max cluster size is 4
truePartition <- c(50,50,50,50)
# number of fields
numberFields <- 5
# number of categories per field
numberCategories <- rep(10,5)
# distortion probability for the fields
trueBeta <- 0.01
# generate simulated data
simulatedData <- SimData(true_L = truePartition, nfields = numberFields, ncat = numberCategories, true_beta = trueBeta)
# dimension of data set
dim(simulatedData)

## ---- eval=TRUE---------------------------------------------------------------
# example of drawing from the posterior with the ESCD prior 
posteriorESCD <- SampleCluster(data=simulatedData, Prior="ESCD", burn=5, nsamples=10)

## ---- eval=TRUE---------------------------------------------------------------
dim(posteriorESCD$Z)
posteriorESCD$Z[1:5,1:10]

## -----------------------------------------------------------------------------
head(posteriorESCD$Params)

## ---- eval=FALSE--------------------------------------------------------------
#  posteriorDP <- SampleCluster(simulatedData, "DP", 5, 10)
#  posteriorPY <- SampleCluster(simulatedData, "PY", 5, 10)
#  posteriorESCNB <- SampleCluster(simulatedData, "ESCNB", 5, 10)

## ---- eval=TRUE---------------------------------------------------------------
maxPartitionSize<- length(truePartition)
uniqueNumberRecords <- sum(truePartition)

#true_M <- length(truePartition)
#true_K <- sum(truePartition)
# true cluster assignments

id <- rep(1:uniqueNumberRecords, times=rep(1:maxPartitionSize, times=truePartition))
# average fnr
mean_fnr(posteriorESCD$Z,id)
# average fdr
mean_fdr(posteriorESCD$Z,id)


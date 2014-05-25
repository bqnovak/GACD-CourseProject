## Author: bqnovak
## Naming convention based on: https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
## Requires plyr package to use join() function

## **************************
## FUNCTIONS FOR EXTERNAL USE
## **************************

## FUNCTION 1: Returns the average value for mean and standard deviation measurement columns
## Key to identify rows are the following columns: Subject, Activity and GroupPartition

GetTidyHARData <- function(){

	## Gets HAR dataset with key (Subject, Activity and GroupPartition), mean and std columns
	temp.dataset <- HARMeanAndStdData()

	## Calculates average for mean and std columns grouped by key columns
	tidy.dataset <- aggregate(. ~ Subject+Activity+GroupPartition, data = temp.dataset, mean)
	tidy.dataset
}

## FUNCTION 2: Write dataset into a new .txt file named a filename variable passed as parameter.
## New file is written into the working directory.

WriteTableToTxt <- function(filename,dataset){
	write.table(dataset,file=paste0(filename,".txt"),row.names=F,sep="\t",quote=F)
	message(paste0("New file ",filename,".txt has been created in your working directory"))
}

## **************************
## FUNCTIONS FOR INTERNAL USE
## **************************

## Returns the dataset acoording to the setname ("test" or "train") passed as parameter to the function
## Key to identify rows are the following columns: Subject, Activity and GroupPartition

HARDataBySetname <- function(setname)
{
	directory <- ".\\UCI HAR Dataset\\"

	## ******
	## PART 1
	## ******

	## Reading subject entries from txt into subject
	subject <- read.table(paste0(directory,setname,"\\subject_",setname,".txt"))

	## Reading activity entries from txt into activity
	activity <- read.table(paste0(directory,setname,"\\y_",setname,".txt"))

	## Consolidating subject and activity into temp.data1
	temp.data1 <- cbind(subject,activity)
	colnames(temp.data1) <- c("Subject","ActivityID")

	## Reading activity label entries from txt into activity.label
	activity.label <- read.table(paste0(directory,"activity_labels.txt"))
	colnames(activity.label) <- c("ActivityID","Activity")

	## Join temp.data1 and activity.label into temp.data2 and dropping ActivityID column
	library(plyr) ## to use join() function
	temp.data2 <- join(temp.data1,activity.label,by="ActivityID")
	temp.data2 <- temp.data2[c("Subject","Activity")]

	## Adding new GroupPartition column to differenciate datasets (test and train)
	temp.data2[,"GroupPartition"] <- sample(toupper(setname),nrow(temp.data2),replace=TRUE)

	## ******
	## PART 2
	## ******

	## Reading feature label entries from txt into a vector
	feature <- read.table(paste0(directory,"features.txt"))
	feature <- feature["V2"]
	feature <- as.vector(t(feature))

	## Reading x data entries from txt into x.data and naming it as features
	x.data <- read.table(paste0(directory,setname,"\\x_",setname,".txt"))
	colnames(x.data) <- feature

	## ******
	## PART 3
	## ******

	## Consolidating temp.data2 and x.test.data into result.data
	result.data <- cbind(temp.data2,x.data)
	result.data
}

## Returns full test and train datasets
## Key to identify rows are the following columns: Subject, Activity and GroupPartition

HARFullData <- function(){
	## Loading test and train datasets
	test <- HARDataBySetname("test")
	train <- HARDataBySetname("train")

	result.data <- rbind(test,train)
	result.data
}

## Returns only mean and standard deviation measurement columns
## Key to identify rows are the following columns: Subject, Activity and GroupPartition

HARMeanAndStdData <- function(){

	## Gets the full Human Activity Recognition (HAR) dataset
	HAR <- HARFullData()

	## Getting key columns: Subject, Activity and GroupPartition
	key.data <- HAR[,c("Subject","Activity","GroupPartition")]

	## Getting mean columns (this doesn't include meanFreq columns)
	mean.data <- HAR[,grep("mean",names(HAR))]
	mean.data <- mean.data[,-grep("meanFreq",names(mean.data))]

	## Getting standard deviation columns
	std.data <- HAR[,grep("std",names(HAR))]

	result.data <- cbind(key.data,mean.data,std.data)
	result.data
}
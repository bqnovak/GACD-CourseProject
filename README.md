## GETTING AND CLEANING DATA - COURSE PROJECT

====================================================================

Author: bqnovaq (Brian Koo Labrin) | bkoo99@hotmail.com

Company: Kaits Consulting Group

Date: May 25, 2014

====================================================================

### Summary

This is the README document wich describes the work done in the Getting and Cleaning Data Course Project for Coursera. The script work have followed the coding stardands based on: https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml

If you need to have more information about the original data used for this project course see the README file contained in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

### Scripts

In the run_analysis.R file are contained all the scripts made for this course project. There are two groups of script functions:

* FOR EXTERNAL USE: These are the final scripts R programmers can use to obtain Human Activity Recognition tidy data set and write results to a .txt file.

* FOR INTERNAL USE: These are the base scripts used by functions for external use. This is an intent to make more readable the script work for an R programmer who tries to understand them.

### Functions For External Use

* GetTidyHARData(): Returns the final tidy data set containing the average value for mean and standard deviation measures fields. The data set contains three extra columns to identify the records: Subject, Activity and Group Partition. Group Partition is used to describe if the record belongs to a test data set or train data set. This function uses the internal function named HARMeanAndStdData wich returns a data frame with detail data (not average data) of the same columns() we have in final tidy data set.

* WriteTableToTxt(): This function writes a dataset into a new .txt file. This function has two parameters: (a) filename, name of the .txt file to write in working directory, (b) dataset: data set to be written into .txt file.

### Functions For Internal Use

* HARDataBySetname(): This function returns a data frame with data was obtained from getdata-projectfiles-UCI HAR Dataset.zip according to the setname passed as parameter ("train" or "test"). This function requires 'plyr' package to be run.

* HARFullData(): This function returns a full data set containing data for test and train experiments. Uses the HARDataBySetname() function described previously. This function has no parameters.

* HARMeanAndStdData(): This function returns only mean and standard deviation column fields obtained from HARFullData() function. This data set has the record for test and train data. This function has no parameters.

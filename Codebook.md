## GETTING AND CLEANING DATA - COURSE PROJECT CODEBOOK

====================================================================

Author: bqnovaq (Brian Koo Labrin) | bkoo99@hotmail.com

Company: Kaits Consulting Group

Date: May 25, 2014

====================================================================

### Summary

This document describes the variables, the data, and any transformations or work performed to clean up the data for the Getting and Cleaning Data Course Project for Coursera.

This script work have followed the coding stardands based on: https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml

If you need to have more information about the original data used for this project course see the README file contained in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. [1]

### Description Of The Original Data Set (taken from README file of original data set)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

#### For each record it is provided (some part is taken from README file of original data set):

* An identifier of the subject who carried out the experiment.
* A activity label describing the performed activity.
* A group partition label describing if the record belongs to test or train dataset.
* 66 fields with average mean and average standard deviation measurements.

### Scripts

In the run_analysis.R file are contained all the scripts made for this course project. There are two groups of script functions:

* FOR EXTERNAL USE: These are the final scripts R programmers can use to obtain Human Activity Recognition tidy data set and write results to a .txt file.

* FOR INTERNAL USE: These are the base scripts used by functions for external use. This is an intent to make more readable the script work for an R programmer who tries to understand them.

### Functions For External Use - Transformation details are included

* GetTidyHARData(): Returns the final tidy data set containing the average value for mean and standard deviation measures fields. The data set contains three extra columns to identify the records: Subject, Activity and Group Partition. Group Partition is used to describe if the record belongs to a test data set or train data set. This function uses the internal function named HARMeanAndStdData wich returns a data frame with detail data (not average data) of the same columns() we have in final tidy data set. The steps done are next:

** Gets HAR dataset with key (Subject, Activity and GroupPartition), mean and std columns.
** Calculates average for mean and std columns grouped by key columns: Subject, Activity and GroupPartition.

* WriteTableToTxt(): This function writes a dataset into a new .txt file. This function has two parameters: (a) filename, name of the .txt file to write in working directory, (b) dataset: data set to be written into .txt file.

### Functions For Internal Use - Transformation details are included

* HARDataBySetname(): This function returns a data frame with data was obtained from getdata-projectfiles-UCI HAR Dataset.zip according to the setname passed as parameter ("train" or "test"). This function requires 'plyr' package to be run. The steps done are next:

** Reading subject entries from txt into subject variable.
** Reading activity entries from txt into activity variable.
** Consolidating subject and activity into temp.data1 variable.
** Reading activity label entries from txt into activity.label variable.
** Join temp.data1 and activity.label into temp.data2 and dropping ActivityID column.
** Adding new GroupPartition column to differenciate datasets (test and train).
** Reading feature label entries from txt into a vector variable.
** Reading x data entries from txt into x.data variable and naming it as features.
** Consolidating temp.data2 and x.test.data into result.data variable.

* HARFullData(): This function returns a full data set containing data for test and train experiments. Uses the HARDataBySetname() function described previously. This function has no parameters. The steps done are next:

** Loading test and train datasets.
** Row binding for test and train datasets into result.data data frame variable.

* HARMeanAndStdData(): This function returns only mean and standard deviation column fields obtained from HARFullData() function. This data set has the record for test and train data. This function has no parameters. The steps done are next:

** Gets the full Human Activity Recognition (HAR) dataset.
** Getting key columns from dataset: Subject, Activity and GroupPartition.
** Getting mean measure columns (this doesn't include meanFreq columns).
** Getting standard deviation measure columns.
** Column binding for key columns, mean measure columns and standard deviation measure columns.

#### License:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
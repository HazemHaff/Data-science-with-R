This repository contains the R script `run_analysis.R`, which is used for cleaning and preparing a tidy data set from the Human Activity Recognition Using smartphones dataset

You need to download the data from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


##Repository Contents
- `run_analysis.R`: script for transforming raw data into a tidy dataset
- `CodeBook.md`: describes the variables, the data, and the transformations
- `tidy_data.txt`: the final tidy dataset generated by the script

##Script Workflow
The `run_analysis.R` script performs the following steps to clean the data:

1 Loads the data from the raw files
2 Merges the training and test sets to create one combined dataset
3 Extracts only the measurements on the mean and standard deviation
4 Applies descriptive activity names to name the activities in the data set
5 Labels the data set with descriptive variable names
6 From the data set in step 5, creates a tidy data set with the average of each variable for each activity and each subject
7. Writes the tidy data set to a text file named `tidy_data.txt`

##Running the Script
To run the script, you must have the data extracted in your working directory under the folder `UCI HAR Dataset`. Set your working directory to the parent folder of `UCI HAR Dataset` and source the script:

setwd("path to UCI HAR Dataset(Extracted)")
source("run_analysis.R")
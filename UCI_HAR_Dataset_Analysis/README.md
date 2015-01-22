Data Analysis on the UCI HAR Dataset
====================================

The purpose of this repo is to demonstrate how to create a tidy data set from the UCI HAR Dataset that can be used for further analysis.

The analysis was done for the purpose of the "Getting and Cleaning Data" course which is part of the "Data Science" specialization track on [Coursera](http://www.coursera.org).

The repo contains:
* run_analysis.R: R script that performs the data transformations;
* measurementAverages.csv: the outout of the script;
* CodeBook.md: the code book for the analysis;
* Readme.md: this file.

## The script
The transformation of the data set has been implemented in R. The implementation is available in the [run_analysis.R](./run_analysis.R) script. 

The script performs the following steps:

1. Checks if the data set exists, otherwise it downloads and extracts;
3. Load both test and train data for the measurements;
4. Loads the features file;
5. Extract the mean and standard deviation column names and data;
6. Loads the activity and subject data and merges them with the measurements into one data set;
7. Replaces the activity ID's with the descriptive activity labels;
8. Adds descriptive variable names the the data set;
10. Creates a tidy data set with the measurement means per subject and activity;
11. Saves the data set into the [measurementAverages.cvs](./measurementAverages.csv) file on the file system.

The script can be loaded into the R workspace and run by the following commands:

```` 
    source("run_analysis.R")
    run()
````


## Code Book
The variables, data and more details on the transformations are described the [codebook](./CodeBook.md).

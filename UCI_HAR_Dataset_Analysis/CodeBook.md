Code Book
=========
Analysis on the UCI HAR Dataset
-------------------------------

This CodeBook describes the analysis conducted on the UCI HAR Dataset. The original data has been tidied and summarized through several transformations. The transformations have been implemented in the [run_analysis.R]() script. The result is saved in the [measurementAverages.csv]() file. 

##The original data set
The original data set has been the University of California Irvine's (UCI's) dataset for Human Activity Recognition (HAR). It is a public domain dataset built from the recordings of subjects performing activities of daily living while carrying a waist-mounted smartphone with embedded inertial sensor.

The data set can be downloaded from this website:  

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

As the above website explains, the experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

For each record it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
 
**Note**:
Features are normalized and bounded within [-1,1].

## Transformations on the original data
The original dataset, which consisted of 563 measurement features, has been filtered for including only the mean and standard deviation of each measurements, yielding 66 variables. Averages for these variables have been calculated over the subjects (volunteers) and activities.

The transformation on the original data has been:

* Merged subject, activity and measurements data into one data set;
* Merged train and test data;
* Selected averages and standard deviation measurements and filtered out the others;
* Calculated measurement means for per subject and per activity;
* Added descriptive names to the activities and the columns in the data set.

After the transformations described above the script generates the result set and saves it to the file system on .csv format.

##The Result Set
The resulting data set is a tidy data set saved in the [measurementAverages.csv](./measurementAverages.csv) file, which contains the summary of the original data. It is a 180x68 data table (181 with column name), with the following columns:

1. **Subject**: column 1; contains the subject ID's of the 30 volunteers in the study;
2. **Activity**: column 2; activity names ('*laying*', '*sitting*', '*standing*', '*walking*', '*walking_downstairs*' or '*walking_upstairs*');
3. **Measurement means**: column 3..68; the averages for the 66 attributes included in the transformation. The averages are calculated per subject and activity. See the next section for the list of 66 measurements.

There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.

### Measurements included in the summary
The following measurement features from the original data set have been included in transformation:

```
tBodyAcc-mean-X
tBodyAcc-mean-Y
tBodyAcc-mean-Z
tBodyAcc-std-X
tBodyAcc-std-Y
tBodyAcc-std-Z
tGravityAcc-mean-X
tGravityAcc-mean-Y
tGravityAcc-mean-Z
tGravityAcc-std-X
tGravityAcc-std-Y
tGravityAcc-std-Z
tBodyAccJerk-mean-X
tBodyAccJerk-mean-Y
tBodyAccJerk-mean-Z
tBodyAccJerk-std-X
tBodyAccJerk-std-Y
tBodyAccJerk-std-Z
tBodyGyro-mean-X
tBodyGyro-mean-Y
tBodyGyro-mean-Z
tBodyGyro-std-X
tBodyGyro-std-Y
tBodyGyro-std-Z
tBodyGyroJerk-mean-X
tBodyGyroJerk-mean-Y
tBodyGyroJerk-mean-Z
tBodyGyroJerk-std-X
tBodyGyroJerk-std-Y
tBodyGyroJerk-std-Z
tBodyAccMag-mean
tBodyAccMag-std
tGravityAccMag-mean
tGravityAccMag-std
tBodyAccJerkMag-mean
tBodyAccJerkMag-std
tBodyGyroMag-mean
tBodyGyroMag-std
tBodyGyroJerkMag-mean
tBodyGyroJerkMag-std
fBodyAcc-mean-X
fBodyAcc-mean-Y
fBodyAcc-mean-Z
fBodyAcc-std-X
fBodyAcc-std-Y
fBodyAcc-std-Z
fBodyAccJerk-mean-X
fBodyAccJerk-mean-Y
fBodyAccJerk-mean-Z
fBodyAccJerk-std-X
fBodyAccJerk-std-Y
fBodyAccJerk-std-Z
fBodyGyro-mean-X
fBodyGyro-mean-Y
fBodyGyro-mean-Z
fBodyGyro-std-X
fBodyGyro-std-Y
fBodyGyro-std-Z
fBodyAccMag-mean
fBodyAccMag-std
fBodyBodyAccJerkMag-mean
fBodyBodyAccJerkMag-std
fBodyBodyGyroMag-mean
fBodyBodyGyroMag-std
fBodyBodyGyroJerkMag-mean
fBodyBodyGyroJerkMag-std
```
 
## Instructions for running the transformations
The transformation of the data set is available in the [run_analysis.R](./run_analysis.R) script. 

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

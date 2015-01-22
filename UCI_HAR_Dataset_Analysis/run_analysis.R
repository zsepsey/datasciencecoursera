run <- function() {
  ## Download data set
  URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
  zipFile <- "./getdata-projectfiles-UCI-HAR-Dataset.zip"
  
  # Download data set if not yet exist
  if (file.exists(zipFile) == FALSE) {
    download.file(URL, destfile = zipFile, method="curl")
  }
  
  # Uncompress zip file
  if (file.exists("./UCI HAR Dataset") == FALSE) {
    unzip(zipFile)
  }
  
  ## Merges the training and the test sets to create one data set.
  # Read and merge measurements data (x_train, x_test)
  dataSet <- getMeasurementData()
  
  ## Extracts only the measurements on the mean and standard deviation for each measurement. 
  features <- read.table("./UCI HAR Dataset/features.txt")
  dataSet <- selectMeanStdFeatures(dataSet, features)
  
  ## Uses descriptive activity names to name the activities in the data set
  # Merge train and test set for the other files (y, subjct) and merge them with the measurements data
  dataSet <- mergeAllFiles(dataSet)

  # Add activity labels
  dataSet <- addActivityLabels(dataSet)
  
  ## Appropriately labels the data set with descriptive variable names. 
  dataSet <- addVariableNames(dataSet, features)
  
  ## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  measurementAverages <- calcAverages(dataSet)
  
  # Save txt file on file system
  write.csv(measurementAverages, "measurementAverages.csv")
  
  measurementAverages
}

# Reads train and test data with measurements from the file system and returns the merged data.
getMeasurementData <- function() {
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
  rbind(x_train, x_test)
}

# Reads activity and subjects data from the file system and merges with the measurements data
mergeAllFiles <- function(measurements) {
  # Read train and test data into memory
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
  
  # Merge train and test data
  y <- rbind(y_train, y_test)
  subject <- rbind(subject_train, subject_test)
  
  # Merge x, y and subject
  cbind(subject, y, measurements)  
}

# Selects mean or standard deviation measurements data
selectMeanStdFeatures <- function(data, features) {
  featuresBool <- grepl("-(std|mean)\\(\\)$", features[,2])
  data[, featuresBool]
}

# Selects feature names that denote a mean or standard deviation of measurements
meanStdFeatureNames <- function(allFeatures) {
  featureNames <- subset(allFeatures, grepl("-(std|mean)\\(\\)$", allFeatures[,2]))
  gsub("(\\(|\\))", "", featureNames[,2])
}

# Replaces adctivity ID's with their labels
addActivityLabels <-function(data) {
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  data[, 2] <- activity_labels[data[, 2], 2]
  data
}

# Adds appropriate names to variables of the data set
addVariableNames <- function(data, features) {
  features <- meanStdFeatureNames(features)
  names(data) <- c("Subject", "Activity", features)
  data
}

# Calculates means across subjects and activities
calcAverages <- function(data) {
  measurementAverages <- aggregate(data[, 3:ncol(data)], 
                         by=list(data$Subject, data$Activity), 
                         FUN=mean) 
  names(measurementAverages) <- names(data)
  measurementAverages
}
## Data Science Specialisation: Getting and Cleaning Data
## Course Project

## Obtain and clean Samsung Galaxy S acceleramotor data

## Pre-a) Load required packages
library(data.table)
library(reshape2)

## Pre-b) Set and get the working directory
setwd("C:/Data/Coursera/Getting and Cleaning Data/Course Project/Data")
path <- getwd()


## 1-a) Download the required dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "gcdData.zip"
download.file(url, file.path(path, fileName))

## 1-b) Unzip the data
executable <- file.path("C:", "Program Files", "7-Zip", "7z.exe")
parameters <- "x"
cmd <- paste(paste0("\"", executable, "\""), parameters, paste0("\"", file.path(path, fileName), "\""))
system(cmd)

## 1-c) Set the path to be the newly extracted UCI folder
pathIn <- file.path(path, "UCI HAR Dataset")


## 2-a) Read the subject files
subjectTrain <- fread(file.path(pathIn, "train", "subject_train.txt"))
subjectTest  <- fread(file.path(pathIn, "test" , "subject_test.txt" ))

## 2-b) Read the activity files
activityTrain <- fread(file.path(pathIn, "train", "Y_train.txt"))
activityTest  <- fread(file.path(pathIn, "test" , "Y_test.txt" ))

## 2-c) Read the data
training <- read.table(file.path(pathIn, "train", "X_train.txt"))
training <- data.table(training)
test <- read.table(file.path(pathIn, "test", "X_test.txt"))
test <- data.table(test)


## 3-a) Merge the tables
subject <- rbind(subjectTrain, subjectTest)
setnames(subject, "V1", "subject")
activity <- rbind(activityTrain, activityTest)
setnames(activity, "V1", "activityNumber")
data <- rbind(training, test)

## 3-b) Merge the columns and set the key for the dataset
subject <- cbind(subject, activity)
data <- cbind(subject, data)
setkey(data, subject, activityNumber)


## 4-a) Read the features file
features <- fread(file.path(pathIn, "features.txt"))
setnames(features, names(features), c("featureNumber", "featureName"))

## 4-b) Subset all features containing the mean and the standard deviation
features <- features[grepl("mean\\(\\)|std\\(\\)", featureName)]

## 4-c) Adds a column that corresponds the features to the column headers in teh data set
features$featureDataCode <- features[, paste0("V", featureNumber)]

## 4-d) Subset these variables using variable names.
select <- c(key(data), features$featureDataCode)
data <- data[, select, with=FALSE]


## 5-a) Read activity labels that provide descriptive names for each different activity
activityNames <- fread(file.path(pathIn, "activity_labels.txt"))
setnames(activityNames, names(activityNames), c("activityNumber", "activityName"))

## 5-b) Merge the data and activity names and set the key
data <- merge(data, activityNames, by="activityNumber", all.x=TRUE)
setkey(data, subject, activityNumber, activityName)

## 5-c) The melt function allows each row to be narrower as each measurement now has its own row
data <- data.table(melt(data, key(data), variable.name="featureDataCode"))
data <- merge(data, features[, list(featureNumber, featureDataCode, featureName)], by="featureDataCode", all.x=TRUE)

## 5-d) 
dt$activity <- factor(dt$activityName)
dt$feature <- factor(dt$featureName)
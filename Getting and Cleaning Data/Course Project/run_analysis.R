## Getting and Cleaning Data
## Course Project
## Daniel Bell

## Obtain and clean Samsung Galaxy S acceleramotor data

## Pre-a) Load required packages
library(data.table)
library(reshape2)
library(knitr)


## Pre-b) Set and get the working directory
setwd("C:/Data/Coursera/Getting and Cleaning Data/Course Project")
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


## 3-a) Merge the training and test data for subject, activity & data
subject <- rbind(subjectTrain, subjectTest)
setnames(subject, "V1", "subject")
activity <- rbind(activityTrain, activityTest)
setnames(activity, "V1", "activityNumber")
data <- rbind(training, test)

## 3-b) Merge the data, subject & activity columns and set the key for the dataset
subjectActivity <- cbind(subject, activity)
data <- cbind(subjectActivity, data)
setkey(data, subject, activityNumber)


## 4-a) Read the features file and set the column names
features <- fread(file.path(pathIn, "features.txt"))
setnames(features, names(features), c("featureNumber", "featureName"))

## 4-b) Subset all features containing the mean and the standard deviation
features <- features[grepl("mean\\(\\)|std\\(\\)", featureName)]

## 4-c) Add a column that corresponds the features to the column headers in the data set
features$featureDataCode <- features[, paste0("V", featureNumber)]

## 4-d) Subset these variables using feature names and the existing tables keys (subject & activityNumber)
##      The data table now only contains the mean and std data
select <- c(key(data), features$featureDataCode)
data <- data[, select, with=FALSE]


## 5-a) Read activity labels that provide descriptive names for each different activity and set the column names
activityNames <- fread(file.path(pathIn, "activity_labels.txt"))
setnames(activityNames, names(activityNames), c("activityNumber", "activityName"))

## 5-b) Merge the data and activity names and set the key to include the activity name also
data <- merge(data, activityNames, by="activityNumber", all.x=TRUE)
setkey(data, subject, activityNumber, activityName)

## 5-c) The melt function allows each row to be narrower as each measurement of a feature now has its own row
data <- data.table(melt(data, key(data), variable.name="featureDataCode"))

## 5-d) Merge the data and features tables to provide a description of the feature measured
data <- merge(data, features[, list(featureNumber, featureDataCode, featureName)], by="featureDataCode", all.x=TRUE)

## 5-e) Set the activityName and featureName variables as type factor
data$activity <- factor(data$activityName)
data$feature <- factor(data$featureName)

## 5-f) Seperate all of the features in the feature name variable
  ## Features with 1 category
data$featJerk <- factor(grepl("Jerk", data$feature), labels=c(NA, "Jerk"))
data$featMagnitude <- factor(grepl("Mag", data$feature), labels=c(NA, "Magnitude"))

  ## Features with 2 categories
n <- 2
y <- matrix(seq(1, n), nrow=n)

x <- matrix(c(grepl("^t", data$feature), grepl("^f", data$feature)), ncol=nrow(y))
data$featDomain <- factor(x %*% y, labels=c("Time", "Freq"))

x <- matrix(c(grepl("Acc", data$feature), grepl("Gyro", data$feature)), ncol=nrow(y))
data$featInstrument <- factor(x %*% y, labels=c("Accelerometer", "Gyroscope"))

x <- matrix(c(grepl("BodyAcc", data$feature), grepl("GravityAcc", data$feature)), ncol=nrow(y))
data$featAcceleration <- factor(x %*% y, labels=c(NA, "Body", "Gravity"))

x <- matrix(c(grepl("mean()", data$feature), grepl("std()", data$feature)), ncol=nrow(y))
data$featVariable <- factor(x %*% y, labels=c("Mean", "SD"))

  ## Features with 3 categories
n <- 3
y <- matrix(seq(1, n), nrow=n)

x <- matrix(c(grepl("-X", data$feature), grepl("-Y", data$feature), grepl("-Z", data$feature)), ncol=nrow(y))
data$featAxis <- factor(x %*% y, labels=c(NA, "X", "Y", "Z"))


## 6-a) Set the keys for the tidy dataset and generate it
setkey(data, subject, activity, featDomain, featAcceleration, featInstrument, featJerk, featMagnitude, featVariable, featAxis)
dataTidy <- data[, list(count = .N, average = mean(value)), by=key(data)]

## 6-b) Save the tidy dataset in a new file
dataFile <- file.path(path, "SamsungTidyDataset.txt")
write.table(dataTidy, dataFile, quote=FALSE, sep="\t", row.names=FALSE)

## 6-c) Create the codebook for upload (must go up one directory for the required r markdown file)
library(markdown)
setwd("C:/Users/IBM_ADMIN/Git/data-science-coursera/Getting and Cleaning Data/Course Project/")
knit("codeBookTemplate.rmd", output="codebook.md", encoding="ISO8859-1", quiet=TRUE)
markdownToHTML("codebook.md", "codebook.html")

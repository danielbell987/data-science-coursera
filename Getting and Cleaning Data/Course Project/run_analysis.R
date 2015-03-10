## An R script to tidy data collected from the accelerometers from the Samsung Galaxy S smartphone


## Load the data into R
headers <- read.table(file = "UCI HAR Dataset/features.txt")
training <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
test <- read.table(file = "UCI HAR Dataset/test/X_test.txt")

## Merges the training and the test sets to create one data set.
dataset <- rbind(training, test)
names(dataset) <- headers[,2]

## Extracts only the measurements on the mean and standard deviation for each measurement. 


## Uses descriptive activity names to name the activities in the data set


## Appropriately labels the data set with descriptive variable names. 


## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


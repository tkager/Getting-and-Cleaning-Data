# run.analysis.r
# Course: Getting and Cleaning Data 
# Author: Thomas Kager
# Date: 6-19-2014


# script can be run from a different directory from where the data resided by changing the working directory
# to the directory in which the Samsung data resides.
# setwd("c:/temp/UCI HAR Dataset")

# - features.txt contains the names of the (561) columns in the data sets.
# - Activity_labels.txt contains the names of the activities. This is used as lookup, from data contained 
#   in y.test.txt. 
# - While operations can be combined,  I find it cleaner, though slightly more memory intensive, to create
#   a col_names data set, and use that as an argument when reading in the data sets. 
# - Activity names are matched during the data set merge.

column_names <- read.table("./features.txt")
activity_names <- read.table("./activity_labels.txt")

# Read in data and combine data from test users, with the descriptive column names.
test <- read.table("./test/X_test.txt", col.names = column_names[,2])
# create data frame to hold subjects corresponding to each measurement.
testSubject <- read.table("./test/subject_test.txt", col.names = "subject")
# create data frame to hold activity number corresponding to each measurement.
test_testLabel <- read.table("./test/y_test.txt", col.names = "testLabel")
# Combine all data frames.
test_combined <- cbind(testSubject,test_testLabel,test)
# Lookup and add descriptive name to each activity.
test_combined$activity <- activity_names[test_combined$testLabel,2]

# Perform similar transformations for train data.
train <- read.table("./train/x_train.txt", col.names = column_names[,2])
trainSubject <- read.table("./train/subject_train.txt", col.names = "subject")
train_testLabel <- read.table("./train/y_train.txt", col.names = "testLabel")
train_combined <- cbind(trainSubject,train_testLabel,train)
train_combined$activity <- activity_names[train_combined$testLabel,2]

# Create a master data frame (combining both sets of data)
master <- rbind(test_combined, train_combined)

library(reshape2)
# Create molten data set, with single observation per row, filtering out unnecessary fields.
long_skinny <- melt(master, id=c("subject", "activity"), measure.vars=c("tBodyAcc.mean...X",
    "tBodyAcc.mean...Y", "tBodyAcc.mean...Z", "tBodyAcc.std...X", "tBodyAcc.std...Y", "tBodyAcc.std...Z", 
    "tGravityAcc.mean...X", "tGravityAcc.mean...Y", "tGravityAcc.mean...Z", "tGravityAcc.std...X", 
    "tGravityAcc.std...Y", "tGravityAcc.std...Z"))

# Create wide representation with the values averaged
wide <- dcast(long_skinny, activity + subject ~ variable, mean)

# Further document data
names(wide) <- c("Activity", "Test_Subject", "Avg_TimeBodyAccelerationMean_XAxis", 
    "Avg_TimeBodyAccelerationMean_YAxis", "Avg_TimeBodyAccelerationMean_ZAxis", 
    "Avg_TimeBodyAccelerationStdDev_XAxis", "Avg_TimeBodyAccelerationStdDev_YAxis", 
    "Avg_TimeBodyAccelerationStdDev_ZAxis", "Avg_TimeGravityAccelerationMean_XAxis", 
    "Avg_TimeGravityAccelerationMean_YAxis", "Avg_TimeGravityAccelerationMean_ZAxis", 
    "Avg_TimeGravityAccelerationStdDev_XAxis", "Avg_TimeGravityAccelerationStdDev_YAxis", 
    "Avg_TimeGravityAccelerationStdDev_ZAxis")

# Save tidy data to tabe delimited text file
write.table(wide, "./wide.txt", sep="\t")

# As file is tab delimited, it can be read into data frame by specifying the tab delimiter.
# readit <- read.table("wide.txt", sep="\t")

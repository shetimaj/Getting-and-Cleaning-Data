
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# First checks working directory for zipfile containing data
if(!file.exists("smartphone_activity.zip")) { download.file(fileUrl, "smartphone_activity.zip") }

# unzips downloaded data if not in working directory
if(!file.exists("UCI HAR Dataset")) { unzip("smartphone_activity.zip") }

# Reads training Data
trainingData <- read.table("UCI HAR Dataset/train/X_train.txt")

# Reads training labels associated with the data
trainingLabels <- read.table("UCI HAR Dataset/train/y_train.txt", col.names=c('Activity'))

# Reads training subjects
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names=c('Subject'))

# Reads test Data
testData <- read.table("UCI HAR Dataset/test/X_test.txt")

# Reads test labels associated with the data
testLabels <- read.table("UCI HAR Dataset/test/y_test.txt", col.names=c('Activity'))

# Reads test subjects
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names=c('Subject'))

# Read names of each unlabeled column in the training and test data
features <- read.table("UCI HAR Dataset/features.txt", col.names=c('colNumber', 'colLabel'))

# join all the subjects into one object
combineSubjects <- rbind(trainingSubjects,testSubjects)

# join the training and test data together
combineData <- rbind(trainingData,testData)

# join the training and test labels 
combineLabels <- rbind(trainingLabels,testLabels)

# Label all the columns in the activityData with the labels from the features object
names(combineData) <- features[,'colLabel']

# Use grep function to identify columns with mean and standard deviation
SelectedCols <- grep("(mean|std)\\(\\)", names(combineData))

# select only columns from the data with mean and standard deviation
combSelectedCols <- combineData[,SelectedCols]

#dim(combSelectedCOls)
# Add subjects and activity to the test and training data 
combSelectedCols[,67:68] <- c(combineSubjects,combineLabels)

# tidy column names to be more descriptive
names(combSelectedCols) <- gsub("-mean\\(\\)", "Mean ", names(combSelectedCols))
names(combSelectedCols) <- gsub("-std\\(\\)", "StdDev ", names(combSelectedCols))
names(combSelectedCols) <- gsub("-", "", names(combSelectedCols))
names(combSelectedCols) <- gsub("Acc", "Acceleration ", names(combSelectedCols))
names(combSelectedCols) <- gsub("Mag", "Magnitude ", names(combSelectedCols))
names(combSelectedCols) <- gsub("Freq", "Frequency ", names(combSelectedCols))


# Replace the values in the activity columns with the descriptions from the activity labels file
combSelectedCols$Activity[combSelectedCols$Activity=='1'] <- 'WALKING'
combSelectedCols$Activity[combSelectedCols$Activity=='2'] <- 'WALKING_UPSTAIRS'
combSelectedCols$Activity[combSelectedCols$Activity=='3'] <- 'WALKING_DOWNSTAIRS'
combSelectedCols$Activity[combSelectedCols$Activity=='4'] <- 'SITTING'
combSelectedCols$Activity[combSelectedCols$Activity=='5'] <- 'STANDING'
combSelectedCols$Activity[combSelectedCols$Activity=='6'] <- 'LAYING'

# Load plyr library to calculate the averages of all the columns
library(plyr)

# Use ddply function and colMeans
activity_average <- ddply(combSelectedCols, .(Subject, Activity), function(x) colMeans(x[, 1:66]))

write.table(activity_average , "activity_average.txt")



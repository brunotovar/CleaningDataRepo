# Script run_analysis.R

# You should set the working directory to the same path where the "run_analysis.R" and the Samsung directory are located
# You should also install the "reshape2" package in order to this script work properly

# Get column names to be used on Training and Test data sets
ColumnNamesLocation = "./SamsungData/features.txt"
ColumnNames <- read.table (ColumnNamesLocation, col.names=c("index","VariableName"),colClasses=c("NULL","character"))

# Prepare Training set data frame

## Read the file
TrainingSetLocation = "./SamsungData/train/X_train.txt"
TrainingDataSet <- read.table (TrainingSetLocation, col.names=ColumnNames[,1])

## Add a variable to identify where the data came from
TrainingDataSet$OriginalDataSet <- rep("training",nrow(TrainingDataSet))

## Add the subject who performed the activity
SubjectTrainingLocation ="./SamsungData/train/subject_train.txt"
SubjectTraining <- read.table (SubjectTrainingLocation)
TrainingDataSet$Subject <- SubjectTraining[,1]

## Add its activity label
LabelTrainingLocation ="./SamsungData/train/y_train.txt"
LabelTraining <- read.table (LabelTrainingLocation)
TrainingDataSet$ActivityLabel <- LabelTraining[,1]


# Prepare Test set data frame

## Read the file
TestSetLocation = "./SamsungData/test/X_test.txt"
TestDataSet <- read.table (TestSetLocation, col.names=ColumnNames[,1])

## Add a variable to identify the data
TestDataSet$OriginalDataSet <- rep("test",nrow(TestDataSet))
           
## Add the subject who performed the activity
SubjectTestLocation ="./SamsungData/test/subject_test.txt"
SubjectTest <- read.table (SubjectTestLocation)
TestDataSet$Subject <- SubjectTest[,1]

## Add its activity label
LabelTestLocation ="./SamsungData/test/y_test.txt"
LabelTest <- read.table (LabelTestLocation)
TestDataSet$ActivityLabel <- LabelTest[,1]

# 1. Merges the training and the test sets to create one data set
MergedDataSet <- merge(TrainingDataSet,TestDataSet,all=TRUE)

## Remove obsolete objects to free memory
rm(TrainingDataSet)
rm(TestDataSet)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
ReducedDataSet <- MergedDataSet[, grep("mean|std",names(MergedDataSet), ignore.case=TRUE)]

## Include more information on the reduced data set
ReducedDataSet$OriginalDataSet <- MergedDataSet$OriginalDataSet
ReducedDataSet$Subject <- MergedDataSet$Subject
ReducedDataSet$ActivityLabel <- MergedDataSet$ActivityLabel

## Remove obsolete objects to free memory
rm(MergedDataSet)

# 3. Uses descriptive activity names to name the activities in the data set                      

## Read file containing the activity names
ActivityFileLocation = "./SamsungData/activity_labels.txt"
ActivityNames <- read.table (ActivityFileLocation, col.names=c("index","ActivityNames"),colClasses=c("NULL","character"))

## Create a factor using the activity names 
ReducedDataSet$ActivityLabel <- factor(ReducedDataSet$ActivityLabel,levels = 1:nrow(ActivityNames),labels = ActivityNames[,1])


# 4. Appropriately labels the data set with descriptive variable names.

# done while preparing both Training and Test data set on on steps above


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Create a tidy data set
library(reshape2)
idVar <- c("Subject","ActivityLabel")
measureVar <- names(ReducedDataSet[,grep("mean|std",names(ReducedDataSet), ignore.case=TRUE)])
TidyDataSet <- melt(ReducedDataSet,id=idVar, measure.vars=measureVar)

## Calculate the average of each variable for each activity and each subject
DataSetMean <- dcast(TidyDataSet, ActivityLabel + Subject ~ variable, fun.aggregate = mean, na.rm = TRUE)

## Create the second tiny data set with only the average values for each activity an each subject
TidyDataSet_2nd <- melt(DataSetMean,id=idVar, measure.vars=measureVar)

## Remove obsolete objects to free memory
rm(ReducedDataSet)

print("Your tidy data set created in step 5 is called TidyDataSet_2nd")

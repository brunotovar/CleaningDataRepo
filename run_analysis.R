# First of all, you should install the "reshape2" and set the working directory to
# the same directory where this script and the subdirectory SamsungData,
# that contained all the data, are located.


# Part A - Preparing the data set

# A.1 Get column names to be used on Training and Test data sets
ColumnNamesLocation = "./SamsungData/features.txt"
ColumnNames <- read.table (ColumnNamesLocation, col.names=c("index","VariableName"),colClasses=c("NULL","character"))

# A.2 - Build Training data frame

## A.2.1 - Read the file
TrainingSetLocation = "./SamsungData/train/X_train.txt"
TrainingDataSet <- read.table (TrainingSetLocation, col.names=ColumnNames[,1])

## A.2.2 - Add a variable to identify where the data came from
TrainingDataSet$OriginalDataSet <- rep("training",nrow(TrainingDataSet))

## A.2.3 - Add the subject who performed the activity
SubjectTrainingLocation ="./SamsungData/train/subject_train.txt"
SubjectTraining <- read.table (SubjectTrainingLocation)
TrainingDataSet$Subject <- SubjectTraining[,1]

## A.2.4 - Add its activity label
LabelTrainingLocation ="./SamsungData/train/y_train.txt"
LabelTraining <- read.table (LabelTrainingLocation)
TrainingDataSet$ActivityLabel <- LabelTraining[,1]


# A.3 - Build Test data frame

## A.3.1 - Read the file
TestSetLocation = "./SamsungData/test/X_test.txt"
TestDataSet <- read.table (TestSetLocation, col.names=ColumnNames[,1])

## A.3.2 - Add a variable to identify the data
TestDataSet$OriginalDataSet <- rep("test",nrow(TestDataSet))
           
## A.3.3 - Add the subject who performed the activity
SubjectTestLocation ="./SamsungData/test/subject_test.txt"
SubjectTest <- read.table (SubjectTestLocation)
TestDataSet$Subject <- SubjectTest[,1]

## A.3.4 - Add its activity label
LabelTestLocation ="./SamsungData/test/y_test.txt"
LabelTest <- read.table (LabelTestLocation)
TestDataSet$ActivityLabel <- LabelTest[,1]


# Part B - Merge and build a tidy data set

# B.1 - Merges the training and the test sets to create one data set
MergedDataSet <- merge(TrainingDataSet,TestDataSet,all=TRUE)

## B.1.1 - Remove obsolete objects to free memory
rm(TrainingDataSet)
rm(TestDataSet)

# B.2 - Extracts only the measurements on the mean and standard deviation for each measurement
ReducedDataSet <- MergedDataSet[, grep("mean|std",names(MergedDataSet), ignore.case=TRUE)]

## B.2.1 - Include more information on the reduced data set
ReducedDataSet$OriginalDataSet <- MergedDataSet$OriginalDataSet
ReducedDataSet$Subject <- MergedDataSet$Subject
ReducedDataSet$ActivityLabel <- MergedDataSet$ActivityLabel

## B.2.2 - Remove obsolete objects to free memory
rm(MergedDataSet)

# B.3 - Uses descriptive activity names to name the activities in the data set                      

## B.3.1 - Read file containing the activity names
ActivityFileLocation = "./SamsungData/activity_labels.txt"
ActivityNames <- read.table (ActivityFileLocation, col.names=c("index","ActivityNames"),colClasses=c("NULL","character"))

## B.3.2 - Create a factor using the activity names 
ReducedDataSet$ActivityLabel <- factor(ReducedDataSet$ActivityLabel,levels = 1:nrow(ActivityNames),labels = ActivityNames[,1])


## B.3.3 - Note that the proper labels with descriptive variable names were already used on part A


# Part C - Creates a second and independent tidy data set with the average of each variable for each activity and each subject.

## C.1 - Reshape the tidy data set in order to calcule the averages
library(reshape2)
idVar <- c("Subject","ActivityLabel")
measureVar <- names(ReducedDataSet[,grep("mean|std",names(ReducedDataSet), ignore.case=TRUE)])
TidyDataSet <- melt(ReducedDataSet,id=idVar, measure.vars=measureVar)

## C.2 - Calculate the average of each variable for each activity and each subject
DataSetMean <- dcast(TidyDataSet, ActivityLabel + Subject ~ variable, fun.aggregate = mean, na.rm = TRUE)

## C.3 - Create the second tiny data set with only the average values for each activity an each subject
TidyDataSet_2nd <- melt(DataSetMean,id=idVar, measure.vars=measureVar)

## C.3.1 - Remove obsolete objects to free memory
rm(ReducedDataSet)

print("Your tidy data set created in step 5 is called TidyDataSet_2nd")

# Code Book of the script run_analysis.R
This code book is a description of the variables and main transformations used on the script run_analysis.R

The data used to build this script was download from this link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

And a full description of how this data was collected can be obtained on this website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## List of variables

### Location variables

* ColumnNamesLocation - define the file that contains the column names, in other word, the list of available variables.
* TrainingSetLocation - define the file that contains the Training data set.
* TestSetLocation - define the file that contains the Test data set.
* SubjectTrainingLocation - define the file that contains informations of the Training subject.
* SubjectTestLocation - define the file that contains information of the Test subject.
* LabelTrainingLocation - define the file that contains information of the Training activity label.
* LabelTestLocation - define the file that contains information of the Test activity label.
* ActivityFileLocation - define the file that contains the activity names.

### Data frames
* TrainingDataSet - data frame build from the Training data set information. (this is a temporary data frame that is removed during the process)
* TestDataSet - data frame build from the Test data set information. (this is a temporary data frame that is removed during the process)
* MergedDataSet - data frame build from the merge of the data frames TrainingDataSet and TestDataSet. (this is a temporary data frame that is removed during the process)
* ReducedDataSet - a smaller data frame build from the based MergedDataSet data frame containing only the information of the mean and standart deviation variable. (this is a temporary data frame that is removed during the process)
* TidyDataSet - a tidy data frame build from the ReducedDataSet data frame.
* TidyDataSet_2nd - a second tidy data frame build from TidyDataSet data frame containing only the average values for each activity an each subject

### New variables created
* OriginalDataSet - this variable was created in order to markdown where the information came from.
* Subject - this variable was introduced due to the necessity to know the subject.
* ActivityLabel - this variable was introduced due to the necessity to know the activity label.

### Temporary Variables used only to simplify the script
* ColumnNames
* LabelTraining
* SubjectTraining
* SubjectTest
* LabelTest
* idVar
* measureVar

## Main transformations
* the script transform the "activity label" variable into a factor variable. The numbers 1, 2, 3 ,4 ,5 and 6 are respectivily associated to the labels "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING" and "LAYING".
* the first tidy data frame was created using the "melt" command from the package "reshape2" where the "ids" were the "subject" and "ActivityLabel" variables and the measure variables were all others.
* the script calcule the mean of each variable for each activity and each subject using the "dcast" command from the package "reshape2".
* the second and last tiny data set created were also created using the "melt" command from the package "reshape2" where the "ids" were the same "subject" and "ActivityLabel" variables and the measure variables were, again, all others.

## Main Units
* all variables corresponding to acceleration signal, the ones containing "acc", are measured in standard gravity units 'g'.
* all variables corresponding to angular velocity vector measured by the gyroscope, the ones containing "gyro", are measured in radians/second. 
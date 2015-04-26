# README of the script run_analysis.R

## Backgroud
This script will take data from a subdirectory called SamsungData and perform some tasks due to obtain a tidy data set with the average of each variable for each activity and each subject.

The data used to build this script was download from this link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

And a full description of how this data was collected can be obtained on this website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## How this script work
This scrip were built in three parts.

### Part A
On this part, the script will create two data frames. One for the Training data and another for the Test data. In more details, it will:
* read and use the column predefined names on both data frames.
* read both data files.
* create a new variable that specifies its origin, in another words, if the data came from the Training or Test file.
* add a new variable that is used to specifies the subject who performed the activity.
* add a new variable that specifies the activity label.

### Part B
On this part, the scrip will merge the Training and Test data frames created above, in order to create a new data frame. In more details, it will:
* merge the two data frames.
* extract only the measurements on the mean and standard deviation for each measurement.
* complete the new data set with more information, like its origen, subject and activity label.
* use descriptive activity names to name the activities in the data set                      .
* remove obsoletes objects to free memory.

### Part C
On this final part, the script will creates a second and independent tidy data set with the average of each variable for each activity and each subject. In more details, it will:
* use the "reshape2" package to melt the data frame created on part B into a new tidy data set.
* use the "dcast" function to calculate the average os each variable for each activity and each subject.
* create the second tiny data set with only the average values for each activity an each subject.
* remove obsolete objects to free memory.

## Important Note
In order to this script work properly, you should:
* install the "reshape2" package.
* download the file from the same link described above.
* put all the content from the unzip directory "UCI HAR Dataset" into a new directory called SamsungData.
* set the working directory to the same directory where this script and the new subdirectory SamsungData are located.
* do not change any file name or directory structure.
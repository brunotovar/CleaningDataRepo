explains how all of the scripts work and how they are connected.  


I was able to follow the README in the directory that explained what the analysis files did. 


# Script run_analysis.R

# Backgroud

This script will take data on a subdirectory named SamsungData and perform some tasks due to obtain a tidy data set with the average of each variable for each activity and each subject.

The data used to build this script was download from this link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

And a full description of how this data was collected can be obtained on this website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# How this script work

This scrip were buil in three parts.

## Part A




# Important Note

In order to this script work properly, you should:
* install the "reshape2" package.
* download the file from the same link described above.
* put all the content from the unzip directory "UCI HAR Dataset" into a new directory called SamsungData.
* set the working directory to the same directory where this script and the new subdirectory SamsungData are located.
* do not change any file name or directory structure.
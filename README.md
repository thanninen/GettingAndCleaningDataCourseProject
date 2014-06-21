-------------------
run_analysis.R
Version 1.0
-------------------
Troy Hanninen
-------------------

SUMMARY
-------------------
This script creates an independent tidy data set in 5 defined steps
from the larger 'Human Activity Recognition Using Smartphones Dataset'
from UCI Machine Learning Repository.

First, the script merges the training and test sets to create one data
set.  Second, it extracts only the measurements on the mean and standard
deviation for each measurement. Third, the activies in the data set
are given descriptive activity names.  Fourth, the labels of the data set
are cleaned up to be clear and accurate.  And last, a second independent
tidy data set is created with the average of each variable for each 
activity and each subject.

NOTES
-------------------
Due to different PCs, Operating Systems, and subfolders, it's assumed that
the reader will download and unzip the original file (link below).  Unzip
the file into the working directory prior to running this script.  The
unzipped folder should be: "[working directory]/UCI HAR Dataset"

For more details regarding the process, variables, naming conventions, and for further
clarification of what the script does, please read CodeBook.md.

More info about the original dataset can be found here:
"http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"

The data can be downloaded from here:
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

The Package reshape2 is required to run this script.

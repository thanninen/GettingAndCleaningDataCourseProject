-------------------
run_analysis.R
Version 1.0
-------------------
Troy Hanninen
-------------------

INTRO
-------------------
The process of creating an independent tidy data from the original
source (Human Activity Recognition Using Smartphones Dataset) is
done in 5 steps.  The important information regarding
those steps is detailed below and the starting point of each step
is labeled in the actual script run_analysis.R.

-------------------
Step01 - Merge the training and test sets to create one data set
  a. Assign variables and read files
        Generic variables were assigned to the following files and subsequently,
        those files were read using read.csv().  The argument sep="" must be used
        in the read.csv() function:
          subject_test.txt
          x_test.txt
          y_text.txt
          subject_train.txt
          x_train.txt
          y_train.txt
          activity_labels.txt
          features.txt
        Data in the 'Inertial Data' folders was not considered relevant.
        
  b. A visual audit of the features in the features.txt file showed inconsistencies
  in some of the names when compared to the features_info.txt file.  Some of the 
  features contained 'BodyBody' within the name instead of 'Body'. gsub() was used
  to correct this.
  
  c. Column names were added to x_trainTXT and x_textTXT from features.txt using
  names() function
  
  d. The three 'test' files were joined with cbind() into a single data frame 'testTXT'
  and the three 'train' files were joined with cbind() into a single data frame 'trainTXT'.
  cbind() was used so that all of the independent columns remained after the merge
        
  e. testTXT and trainTXT were then merged together using rbind() because they both
  contained identical columns.  The combined file was entitled 'DataSet01'.

-------------------
Step02 - Extract only the measurements on the mean and standard deviation for each measurement
  a. Aside from the "subject" and "activity" columns, the only other columns extracted
  were those with measurements on the mean or standard deviation for each measurement.
  For consistentcy, only those columns with either "mean()" or "std()" in the column
  name were extracted.  This resulted in 68 total columns.
  
-------------------
Step03 - Use descriptive activity names to name the activities in the data set
  a. The activity_labels.txt file contains descriptive activity names for use in this
  step.  A column called 'activity_Desc' was added to the data frame that
  contains the proper descriptive variable. The integers in DataSet01$activity
  were matched with the integers in activity_labelsTXT$V2 to get the final result. The
  original 'activity' column, with integers only, was then removed.
  
-------------------
Step04 - Appropriately label the data set with descriptive variable names.
  a. Column names were changed into more understandable and structurally correct names.
  Each column name contained up to seven components.  Those components were:
    1. domain (time or frequency):  t, f
    2. sensor signal components:  Body, Gravity
    3. sensor signal (accelerometer, gyroscope) : Acc, Gyro
    4. Jerk signal obtained: 'Jerk' in name if yes
    5. Magnitude of signals calculated: 'Mag' in name if yes
    6. Statistic calculated (mean or standard deviation): -mean(), -std()
    7. Three Axis': -X, -Y, -Z
  For example, the name 'tBodyAccJerkMag-mean()-X' contained all 7 components but
  is not structurally sound or easily understandable.  The foundational layout
  of the names will not change, but unneccesary punctuation such as '()-' will be
  removed and names will be made more clear and consistent.  Though there is
  some debate about the use of underscores in naming conventions, they
  are used in this data frame to separate words for easy reading.
  
  Changes:
    1. domain: time_, freq_
    2. sensor signal components:  body_, grav_
    3. sensor signal: accelerometer_, gyroscope_
    4. Jerk signal obtained: 'jerk_' in name if yes
    5. Magnitude of signals calculated: 'magnitude_' in name if yes
    6. Statistic calculated (mean or standard deviation): mean_, stdev_
    7.  Three Axis': _x, _y, _z
  For example, the name 'tBodyAccJerkMag-mean()-X' will change to
  'time_body_accelerometer_jerk_magnitude_mean_x'
  Though many different methods could have produced the same result, several
  lines of gsub() code were used to make these changes appear independent,
  understandable, and reproducable.

-------------------
Step05 - Create a second independent tidy data set with the average of each
variable for each activity and each subject. 
  a. The Package (reshape2) was used for this step.  The melt() function, based on
  the 'activity_desc' and 'subject' variables, reshaped the data and prepared it for
  the dcast() function. And dcast(), used with all three variables in the formula
  and mean for the calculation, created the second and final dataset (DAtaSet02)
  with 180 observations and 68 variables.


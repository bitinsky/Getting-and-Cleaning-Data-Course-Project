# Codebook

This is the codebook related to the R script **run_analysis.R**.
It describes the output called **tidy file.csv**

## Background Information
The goal of this script is to prepare tidy data from a larger dataset of 
accelerometer and gyroscope information from several Galaxy S smartphones.

A full description of the raw data is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Raw Data Summary
30 subjects performed six different activities (walking, walking up stairs, 
walking down stairs, sitting, standing, and laying) while wearing their Samsung smartphone. The resulting accelerometer and gyrospcope data was then processed 
into 561 different time and frequency domain calculations. As of this project there were 10299 observations.

## Script Output
We are only interested in the _mean_ and _standard deviation_ variables from the raw data. 

The output of this script returns the _mean of each of the below variables_ for each activity and each subject.  i.e., these are the mean of the mean, or mean of the standard deviation of several variables for each subject and activity.

## Variable description
The resulting variables are formatted as such:

1. **subject** - the first variable is the subject's number - no names are used, this is a unique identifier
2. **activity** - this variable is the activity the subject was performing at the time of the observation
3. The remaining variables are signals from:
 * _Accelerometers_ tracking 3-axial linear acceleration (in the x, y, and z directions) measured in "G's" (gravity of earth ->  9.80665 m/s^2)
 * _Gyroscopes_ tracking 3-axial angular velocity (in the x, y, and z directions)
measured in rad/s
4. Every signal has a measured and calculated variable
 * every signal has a _time domain_ component 
 * A Fast Fourier Transform(FFT) provides a _frequency domain_ calculation for some of the signals.
5. **Body** or **Gravity** indicates the nature of the movement (personal motion or motion induced by gravity)
6. **X**, **Y**, and **Z** indicate the cartesian direction of the variable.
7. **jerk** is the rate of change of acceleration
8. **magnitude** is the magnitude of the movement

The Format of the variables is:
Time/Frequency - Body/Gravity - Accelerometer/Gyroscope - measure - Mean/StandardDev - direction

## Transformations
1. Combine the TEST and TRAIN dataframes - of the true data. Called _data_
2. Combine the TEST and TRAIN dataframes - of the activities performed. 
  Called _activity_
3. Combine the TEST and TRAIN dataframes - of the subjects being monitored. 
  Called _subjects_
4. Read in the names of the features. Called _features_
5. Read in the names of the activities. Called _activity_labels_
6. Move the _features_ to be the variable names in _data_
7. Combine the _data_ with the _subjects_ and _activity_. This is now a single         dataframe.
8. Select only the mean and standard deviation measurements by grep'ing for 
  mean() OR std()
9. Change the activities from a code to a description by merging the 
  _activity_lables_ into the _data_ by using the **activity_code** as the 
  primary key.
10. Update all of the variables so that they are human readible.
 * Add spaces.
 * Expand on the shortened terms or acronymns
 * Change the leading character to:
   * t = Time domain
   * f = Fast Fourier Transform (frequency domain)

## Summary Data
Melt and recast the dataframe so that the average of each variable for each 
activity and each subject is calculated.

Create a text file with this data using write.table(), using row.name=FALSE, 
called  _tidy_file.txt_


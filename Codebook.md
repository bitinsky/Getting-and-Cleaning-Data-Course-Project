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
5. * **Body** or **Gravity** indicates the nature of the movement (personal motion or motion induced by gravity)
6. **X**, **Y**, and **Z** indicate the cartesian direction of the variable.
7. **jerk** is the rate of change of acceleration
8. **magnitude** is the magnitude of the movement

The Format of the variables is:
Time/Frequency - Body/Gravity - Accelerometer/Gyroscope - measure - Mean/StandardDev - direction

## Summary Data
The resulting data file is a summary of providing the average of each variable for each activity and each subject.


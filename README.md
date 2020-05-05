## Setup
This script (run_analysis.R) is self-contained and can be run from anywhere. 
However, you can download and unzip the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
to the /data subfolder where this script (run_analysis.R) is run.

## Function and Output of Script
Running the script will:

1. merge two datasets (TEST and TRAIN) 
2. extract data for only the variables related to mean and standard deviation
3. modifies the data to display the actual activities (not a non-descript code)
4. modifies the variable names to make them slightly more readable
   * a dataframe called tidy_data remains in memory
5. creates a new data frame for the with the average of each variable for each activity and each subject
   * This step creates the actual output. It writes the text file "tidy_file.csv"
   
## Codebook.md
The codebook provides a description of the methodology used and description of 
the variables.

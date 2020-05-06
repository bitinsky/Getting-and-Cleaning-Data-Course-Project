## Setup
This script (run_analysis.R) is self-contained and can be run from anywhere. That is, the script will download and unzip the data if the data does not exist in the ./data subfolder.

However, you can also manually download and unzip the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
to the /data subfolder where this script is run.

## Function and Output of Script
Running the script will:

1. Download and extract the data files
2. merge two datasets (TEST and TRAIN) 
3. extract data for only the variables related to mean and standard deviation
4. modifies the data to display the actual activities (not a non-descript code)
5. modifies the variable names to make them slightly more readable
   * a dataframe called tidy_data remains in memory
6. creates a new data frame for the with the average of each variable for each activity and each subject
   * This step creates the actual output. It writes the text file "tidy_summary_output.txt.txt"
   
## Codebook.md
The codebook (https://github.com/bitinsky/Getting-and-Cleaning-Data-Course-Project/blob/master/Codebook.md) provides a detailed description of the methodology used and description of the variables.

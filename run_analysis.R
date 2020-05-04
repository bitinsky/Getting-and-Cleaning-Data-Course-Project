#------------------------------------------------------------------------------
# Getting and Cleaning Data Course Project
# Kevin Bitinsky 2014-12-09, updated 2020-05-03
#------------------------------------------------------------------------------

if (!require("data.table")) {
  install.packages("data.table")
}
library("data.table")

ifelse(!dir.exists(file.path("data")), dir.create(file.path("data")), "Folder already exists")

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile="./data/Dataset.zip" 
 
if (!file.exists(destfile)) {
  download.file(url ,destfile,method="auto") 
  unzip(destfile,exdir="./data")
}

dir <- "./data/UCI HAR Dataset"
test_dir <- "./data/UCI HAR Dataset/test"
train_dir <- "./data/UCI HAR Dataset/train"


###############################################################################
#  #1 - Merge the training and the test sets to create one data set.

#- 'features.txt': List of all features (varable names).
features <- fread(paste(dir, "features.txt", sep="/"),
                       col.names = c("feature_code","feature_name"))

#- 'activity_labels.txt': Links the class labels with their activity name.
activity_labels <- fread(paste(dir, "activity_labels.txt", sep ="/"), 
                              col.names=c("activity_code","activity"))

#- 'XXX/subject_XXX.txt': (where XXX = TEST or TRAIN).
# Each row identifies the subject who performed the activity for each 
# window sample. Its range is from 1 to 30.
subjects <- rbind(
  fread(paste(test_dir,"subject_test.txt", sep="/"),col.names="subject"),
  fread(paste(train_dir,"subject_train.txt", sep="/"),col.names="subject"))

#- 'XXX/y_XXX.txt': (where XXX = TEST or TRAIN). Training labels.
# These are codes associated with the activity_labels
activities <- rbind(
  fread(paste(test_dir,"y_test.txt", sep="/"),col.names="activity_code"),
  fread(paste(train_dir,"y_train.txt", sep="/"),col.names="activity_code"))

# This is the actual data, without variable names
data <- rbind(
  fread(paste(test_dir,"X_test.txt", sep="/")),
  fread(paste(train_dir,"X_train.txt", sep="/")))

dim(data) #confirm that the data has 561 variables and 10299 observations, as 
          # per the website:
          # http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

# replace the data column numbers with the provided variable names (features)
names(data) <- as.character(features$feature_name)

# Add activities and subjects to the data to create the merged data
data <- cbind(subjects, activities, data)
 
# cleanup the environment
rm(features, subjects, activities, destfile, dir, test_dir, train_dir, url, destfile)


##############################################################################
# #2 - Extract only the measurements on the mean and standard deviation 
#       for each measurement.
important_feature_indices <- grep("mean\\()|std\\()", colnames(data))
# add subject and activity
important_feature_indices <- c(1,2,important_feature_indices) 
data <- data[,.SD,.SDcols=important_feature_indices]



##############################################################################
# #3 - Use descriptive activity names to name the activities in the data set
# 
# Do this using the activity code data read in earlier

data <- merge(data, activity_labels,
           by.x = "activity_code", by.y = "activity_code", sort=FALSE)
data <- data[,-1] #remove the now superfluous 'activity_code' variable
data <- data[,c(1, 68, 2:67)] # Move activity back to the second column


##############################################################################
# #4 - Appropriately label the data set with descriptive variable names.
#

names(data)<-gsub("-mean\\(\\)", "- Mean ", names(data))
names(data)<-gsub("-std\\(\\)", "- StandardDeviation ", names(data))
names(data)<-gsub("^t", "TimeDomain - ", names(data))
names(data)<-gsub("^f", "FrequencyDomain - ", names(data))
names(data)<-gsub("Acc", "Accelerometer ", names(data))
names(data)<-gsub("Gyro", "Gyroscope ", names(data))
names(data)<-gsub("Mag", "Magnitude ", names(data))
names(data)<-gsub("BodyBody", "Body", names(data)) #not sure what this is...
names(data)<-gsub("Body", "Body ", names(data))
names(data)<-gsub("Gravity", "Gravity ", names(data))
names(data)<-gsub("Jerk", "Jerk ", names(data))


###############################################################################
# #5 - Create a second, independent tidy data set with the average of each 
# variable for each activity and each subject

tidy_means <- dcast(melt(data, id = c("subject","activity")), 
                    subject + activity ~ variable, fun.aggregate = mean)

write.csv(tidy_means, "tidy_file.csv", row.names = FALSE)

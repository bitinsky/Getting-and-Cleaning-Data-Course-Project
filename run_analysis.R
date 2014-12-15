#------------------------------------------------------------------------------
# Getting and Cleaning Data Course Project
# Kevin Bitinsky 2014-12-09
# Currently not the most efficient method, but follows the instructions by step
#------------------------------------------------------------------------------
require("reshape2")

#assume that the relevant data set exists in working directory ./UCI HAR Dataset
#set the location paramters for the different datasets
dir <- "./UCI HAR Dataset"
test_dir <- paste(dir, "test", sep= "/")
train_dir <- paste(dir, "train", sep= "/")


# **** #1 - Merge the training and the test sets to create one data set.
subjects <- rbind(read.table(paste(test_dir,"subject_test.txt", sep="/")),
                  read.table(paste(train_dir,"subject_train.txt", sep="/")))
activities <- rbind(read.table(paste(test_dir,"y_test.txt", sep="/")),
                    read.table(paste(train_dir,"y_train.txt", sep="/")))
data <- rbind(read.table(paste(test_dir,"X_test.txt", sep="/")),
                 read.table(paste(train_dir,"X_train.txt", sep="/")))
#subjects <- read.table(paste(test_dir,"subject_test.txt", sep="/"))
#activities <- read.table(paste(test_dir,"y_test.txt", sep="/"))
#data <- read.table(paste(test_dir,"X_test.txt", sep="/"))

# **** #2 - Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table(paste(dir, "features.txt", sep="/"))
important_feature_indices <- grep("mean\\(|std\\(", features[,2], ignore.case = TRUE, value = FALSE)
slimdata <- data[, important_feature_indices]

# **** #3 - Use descriptive activity names to name the activities in the data set
activity_labels <- read.table(paste(dir, "activity_labels.txt", sep ="/"), 
                              col.names=c("code","activity"))
names(activities) <- "code"
activities <- merge(activities, activity_labels,by.x="code",by.y="code", sort=FALSE)
activities <- activities[,-1] #remove superfluous 'code' variable

# **** #4 - Appropriately labels the data set with descriptive variable names.
names(subjects) <- "subject"
names(slimdata) <- features[important_feature_indices, 2]
names(slimdata) <- gsub("\\(|\\)", "", names(slimdata)) #remove the () in the variables
names(slimdata) <- gsub("-", " ", names(slimdata)) #remove the - in the variables
#names(slimdata) <- tolower(names(slimdata)) #to make it 'easier to work with' for rehape
tidy_data <- cbind(subjects, activities, slimdata)

# **** #5 - Create a second, independent tidy data set with the average of each 
# variable for each activity and each subject
tidy_means <- dcast(melt(tidy_data, id = c("subject","activities")), subject + activities ~ variable, mean)
write.table(tidy_means, file = "./tidy dataset of variable means.txt", row.name = FALSE)


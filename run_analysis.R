###load dplyr
library(dplyr)

#0 download data from  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
# to local folder and unzip

# ********************************************************************************
#1 Merge the training and the test sets to create one data set.
# ********************************************************************************

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

### put data together

x_tot <- rbind(x_train, x_test)
y_tot <- rbind(y_train, y_test)

subject_tot <- rbind(subject_train, subject_test)

all_data <- cbind(subject_tot, y_tot, x_tot)


# ********************************************************************************
#2 Extract only the measurements on the mean and standard deviation for each measurement. 
# ********************************************************************************

filtered_data <- select(all_data, subject, code, contains("mean"), contains("std"))

### find activites by code
activities[filtered_data$code, 2]

### replace code number by code name
filtered_data$code <- activities[filtered_data$code, 2]

# ********************************************************************************
# 4 Appropriately label the data set with descriptive variable names. 
# ********************************************************************************

# update column 2 to activity
names(filtered_data)[2] = "activity"

### gsub(pattern, replacement, x, ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
names(filtered_data)<-gsub("Acc", "Accelerometer", names(filtered_data))
names(filtered_data)<-gsub("Gyro", "Gyroscope", names(filtered_data))
names(filtered_data)<-gsub("BodyBody", "Body", names(filtered_data))
names(filtered_data)<-gsub("Mag", "Magnitude", names(filtered_data))
names(filtered_data)<-gsub("^t", "Time", names(filtered_data))
names(filtered_data)<-gsub("^f", "Frequency", names(filtered_data))
names(filtered_data)<-gsub("tBody", "TimeBody", names(filtered_data))
names(filtered_data)<-gsub("-mean()", "Mean", names(filtered_data), ignore.case = TRUE)
names(filtered_data)<-gsub("-std()", "STD", names(filtered_data), ignore.case = TRUE)
names(filtered_data)<-gsub("-freq()", "Frequency", names(filtered_data), ignore.case = TRUE)
names(filtered_data)<-gsub("angle", "Angle", names(filtered_data))
names(filtered_data)<-gsub("gravity", "Gravity", names(filtered_data))

# ********************************************************************************
# 5, From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each
# activity and each subject.
# ********************************************************************************

final_tidy_data_set <- filtered_data %>% group_by(subject, activity) %>% summarise_all(funs(mean)) 




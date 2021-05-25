The codebook should "indicate all the variables and summaries calculated, along with units, and any other relevant information."

# Variables (imported from the input files)
features - List of all features (The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.)

activities - Links the class labels with their activity name.

x_test - Test set.

y_test - Test labels.

x_train - Training set.

y_train - Training labels.

subject_train,subject_test - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


# Merged data variables (using rbind, cbind)

x_tot <- rbind(x_train, x_test)

y_tot <- rbind(y_train, y_test)

subject_tot <- rbind(subject_train, subject_test)

all_data <- cbind(subject_tot, y_tot, x_tot)

# Extract only the measurements on the mean and standard deviation for each measurement (using select)
filtered_data

# Appropriately label the data set with descriptive variable names (using gsub)
names updated in variable filtered_data 

# Create a second, independent tidy data set with the average of each variable for each activity and each subject (using group_by and summarise_all functions)
final_tidy_data_set

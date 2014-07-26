# Begin Script.  You MUST already have the packages installed and loaded, and have your WD set for this script to run
#----------------------------------------------------------------------------------------------------------------------
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Load labels - note: this file does NOT have a header row so the script supplies it.
lblMeasures <- read.table('.\\features.txt', col.names = c("MeasureID", "MeasureName"))
lblActivity <- read.table('.\\activity_labels.txt', col.names=c("ActivityID", "ActivityName"))
lblStats <- grep(".*mean\\(\\)|.*std\\(\\)", lblMeasures$MeasureName)


# Load the training data 
dataSubject_train <- read.table('.\\train\\subject_train.txt', col.names="SubjectID")
dataX_train <- read.table('.\\train\\X_train.txt', col.names=lblMeasures$MeasureName)
dataY_train <- read.table('.\\train\\y_train.txt', col.names="ActivityID")


# Load the testing data
dataSubject_test <- read.table('.\\test\\subject_test.txt', col.names="SubjectID")
dataX_test <- read.table('.\\test\\X_test.txt', col.names=lblMeasures$MeasureName)
dataY_test <- read.table('.\\test\\y_test.txt', col.names="ActivityID")


# Keep only the required columns
dataX_train_req <- dataX_train[, lblStats]
dataX_test_req <- dataX_test[, lblStats]


# Merge all of the training data
data_train <- cbind(dataSubject_train, dataX_train_req, dataY_train)


# Merge all the data types for the testing data
data_test <- cbind(dataSubject_test, dataX_test_req, dataY_test)


# Merge the training and testing data into one dataset (Finishes Item #1)
data_final <- rbind(data_train, data_test)


# Add an activity name for each record
data <- join(data_final, lblActivity, by='ActivityID')


# Create the new columns (Creates #4)
cols_Activity <- c("SubjectID", "ActivityID", "ActivityName")
cols_Measures <- setdiff(colnames(data), cols_Activity)


# Create the molten and stats datasets
data_Molten <- melt(data, id= cols_Activity, measure.vars = cols_Measures)
data_Stats <- dcast(data_Molten, ActivityName + SubjectID ~ variable, mean) 

# This will generate a codebook of the variable names
#cols_Stats <- names(data_Stats)
#write.csv(cols_Stats, 'cookbook.md')

# Create the tidy dataset, and save it locally
write.csv(data_Stats, 'tidy_dataset.txt')

#Display final output
print("Tidy dataset created")

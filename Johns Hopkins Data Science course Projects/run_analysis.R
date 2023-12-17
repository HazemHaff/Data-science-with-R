if (!require(dplyr) || packageVersion("dplyr") < "1.0.0") {
  install.packages("dplyr")
  library(dplyr)
}

#Set the working directory to the location of the files
setwd("C:/Users/hhaff/Downloads/UCI HAR Dataset")

#Read activity labels and features
activity_labels <- read.table("activity_labels.txt", col.names = c("label", "activity"))
features <- read.table("features.txt", col.names = c("n","feature"))

#Read test and training sets
X_test <- read.table("test/X_test.txt")
X_train <- read.table("train/X_train.txt")

#Read subject files
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
subject_train <- read.table("train/subject_train.txt", col.names = "subject")

#Read activity files
y_test <- read.table("test/y_test.txt", col.names = "activity")
y_train <- read.table("train/y_train.txt", col.names = "activity")

#Merge the datasets
X_data <- rbind(X_train, X_test)
subject_data <- rbind(subject_train, subject_test)
y_data <- rbind(y_train, y_test)

#Extract measurements on the mean and standard deviation
features_wanted <- grep("mean\\(\\)|std\\(\\)", features$feature)
X_data <- X_data[, features_wanted]

#Name the activities in the data set
y_data$activity <- activity_labels$activity[y_data$activity]

#Appropriately label the data set with descriptive variable names
names(X_data) <- features$feature[features_wanted]
names(X_data) <- gsub("^t", "Time", names(X_data))
names(X_data) <- gsub("^f", "Frequency", names(X_data))
names(X_data) <- gsub("Acc", "Accelerometer", names(X_data))
names(X_data) <- gsub("Gyro", "Gyroscope", names(X_data))
names(X_data) <- gsub("Mag", "Magnitude", names(X_data))
names(X_data) <- gsub("BodyBody", "Body", names(X_data))

#Create tidy data set with the average of each variable for each activity and each subject using across
tidy_data <- cbind(subject_data, y_data, X_data)
tidy_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = 'drop')

#Write tidy data set to a text file
write.table(tidy_data, "tidy_data.txt", row.name = FALSE)
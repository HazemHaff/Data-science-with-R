##Study Design
The data for this project was collected from the accelerometers of the Samsung Galaxy S smartphone. A group of 30 volunteers withn an age bracket of 19-48 years performed six activities (walking, walking upstairs, walking downstairs, sitting, standing, laying) wearing a smartphone on the waist. The objective is to prepare a tidy dataset that can be used for later analysis.

##CodeBook Description
This Code Book describes the variables, the data, and any transformations performed to clean up the data

###Variables
- `subject`: Identifier of the volunteer who carried out the experiment
- `activity`: Activity performed by the volunteer
- Each of the remaining variables represents a feature measured by the smartphone's accelerometer and gyroscope during the experiment. These features are normalized and bounded within [-1,1]

###Data Transformation Steps
The raw data was transformed using the folowing steps:

1 The training and test sets were merged to create one data set.
2 Only the measurements on the mean and standard deviation for each measurement were extracted.
3 Descriptive activity names were used to name the activities in the data set.
4 The data set was labeled with discriptive variable names.
5 A second, independent tidy data set was created with the average of each variable for each activity and each subject.

###Tidy Dataset
The resulting `tidy_data.txt` file contains the average of each variable for each activity and each subject.
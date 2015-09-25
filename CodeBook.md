The script "run_analysis.R" is used to get the tidy data set of averages of each mean and standard deviation variables in Human Activity Recognition Dataset for each activity and each subject. This script will work as long as the UCI HAR Dataset folder exists in the working directory.

Here is the algorithm of the script run_analysis.R:
1.	Reads the features list from "features.txt"
2.	Reads the test data set from "X_test.txt"
3.	Reads the activity label from "y_test.txt"
4.	Reads the subject label from "subject_test.txt"
5.	Rename test data set columns with features list
6. 	Merge the activity and subject label columns with test data set
7. 	Repeat steps 2 through 6 for train data set
8. 	Merge test data set and train data set using rbind
9.	Get the columns: activity, subject, and every column containing "mean" or "std" in its name
10.	Replace activity label with the descriptive activity names taken from "activity_labels.txt"
11.	Calculate the mean of each variables for each activity and each subject
12. Write the resulting data into file "tidy_HAR_data.txt"

The resulting data in tidy_HAR_data.txt includes the following variables:

"activity"
	Activity name
		WALKING
		WALKING_UPSTAIRS
		WALKING_DOWNSTAIRS
		SITTING
		STANDING
		LAYING
		
"subject"
	Identifies the subject who performed the activity.
	Its range is from 1 to 30.

The remaining 79 variables contain the average of the same variable name in the original Human Activity Recognition Dataset for each activity and each subject.
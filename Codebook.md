## Overview

# HUMAN ACITIVITY RECOGNITION USING SMARTPHONES DATA SET

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.


We have:

	-30 volunteers (subject variable)
	-6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
	-Recorded data with a smartphone (Samsung Galaxy S II)
	-2 datasets: 
				-Training Data (70% volunteers)
				-Test Data (30% volunteers)

So for each dataset:

	-X_(dataset): file contains dataset. This file contains the 561 variables recorded for each activity
	-y_(dataset): file contains label of activity
	-subject_(dataset): file contains subject who performed the activity
	-Inertial Signals: files contains subdivision of variables in acceleration and angular velocity in window samples.

Global files for both datasets:

	-features.txt list of 561 variables of each feature vector
	-activity_labels.txt with name of 6 activities


Task

Join X_(dataset), y_(dataset) and subject_(dataset), and obtain from joined data, measurements on the mean and standard deviation for each measurement. Using this subset of global dataset, create a tidy dataset with the average of each variable for each activity and each subject.

	1->For this assignment, we joined each dataset with same prefix (join X datasets, joine y datasets and join subject datasets), and the output is a global pull of 3 files (X, y and subject) for all the registrations.
	2->Join X, y and subject global sets to have relation between values of each measurement and corresponding activity/subject.
	3->Extract only mean and std variables from above global set
	4->Creates a final dataset with average of each variable for each activity and each subject using "dplyr" functions.

## Project for Getting and Cleaning Data Course
############################## Environment Preparation ##############################
# Load necessary packages
library("data.table")
library("dplyr")
# First, create directory to contain data, and fix relative work environment
if(!file.exists("Datazip")){
    dir.create("Datazip")
}
setwd("Datazip")


############################## Data Loading Tasks ##############################

# Now, we download the zip file
download.file(url, destfile = "Dataset.zip", method = "curl")
datedownloaded <- date()
# To avoid a directory with blanks, we use junkpaths = TRUE
unzip("Dataset.zip", junkpaths = TRUE)


## First, load from disk the values from Data (subject, y, X) files
subject_test <- read.table("subject_test.txt", quote="\"")
subject_train <- read.table("subject_train.txt", quote="\"")
y_test <- read.table("y_test.txt", quote="\"")
y_train <- read.table("y_train.txt", quote="\"")
X_test <- read.table("X_test.txt", quote="\"")
X_train <- read.table("X_train.txt", quote="\"")
# Features.txt has the names for the 561 variables. We can use this names to clarify info in "X" datasets.
features <- read.table("features.txt", quote="\"")
features <- as.character(features$V2)
# We use a vector with name of activities
activity_labels <- read.table("activity_labels.txt", quote="\"")
activities <- activity_labels$V2



############################## Data Manipulation Tasks ##############################


#1====> Join and put meaningful name to variable in "subject" datasets
subject<-rbind(subject_test, subject_train)
names(subject) <- "subject"



#2====> Join and put meaningful name to variable in "y" datasets
activity<-rbind(y_test, y_train)
names(activity) <- "activity"
#Uses descriptive activity names to name the activities in the data set
activity$activity <- as.factor(as.character(activity$activity))
levels(activity$activity) <- activities



#3====>Join and put meaningful names to variables in "X" datasets as is indicated in
#      point 5: Appropriately labels the data set with descriptive variable names.
names(X_test) <- features
names(X_train) <- features
X_test <- X_test[, !duplicated(colnames(X_test))] # Eliminate duplicates
X_train <- X_train[, !duplicated(colnames(X_train))] # Eliminate duplicates
# Finaly, we can join both X tables because we have meaningfull names into variables
X_t <- rbind(X_test, X_train)



#4====>In this situation, we can extract only the measurements
#      on the mean and standard deviation for each measurement.
std_meanX <- select(X_t, contains("mean()"), contains("std()"))
# Now, we have tidy data in X, subject and activity. We construct the joined data previous to final tidy data.
tidy1<-cbind(subject,activity,std_meanX)



############################## Final Tidy Data ##############################


#5====>From the data set in step 4, creates a second, independent tidy data set with the average of each
#      variable for each activity and each subject
tidy <- tidy1 %>%
    group_by(subject, activity) %>%
    summarise_each(funs(mean))

write.table(tidy, "tidy.txt", row.name=FALSE)


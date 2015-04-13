## Project for Getting and Cleaning Data Course
## We have to merge two datasets into one
# Load necessary packages
library("data.table")
library("dplyr")
# First, create directory to contain data, and fix relative work environment
if(!file.exists("Datazip")){
    dir.create("Datazip")
}
setwd("Datazip")
# Now, we download the zip file
download.file(url, destfile = "Dataset.zip", method = "curl")
datedownloaded <- date()
# To avoid a directory with blanks, we use junkpaths = TRUE
unzip("Dataset.zip", junkpaths = TRUE)
## Firstable, load from disk the values from Data (subject, y, X) files
subject_test <- read.table("subject_test.txt", quote="\"")
subject_train <- read.table("subject_train.txt", quote="\"")
y_test <- read.table("y_test.txt", quote="\"")
y_train <- read.table("y_train.txt", quote="\"")
X_test <- read.table("X_test.txt", quote="\"")
X_train <- read.table("X_train.txt", quote="\"")
# Put meaningful name to variable in "y" datasets
names(y_test) <- "activity"
names(y_train) <- "activity"
# Change values into "y" datasets to activity names...
activities <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
y_test$activity <- as.factor(as.character(y_test$activity))
y_train$activity <- as.factor(as.character(y_train$activity))
levels(y_test$activity) <- activities
levels(y_train$activity) <- activities
# Put meaningful name to variable in "subject" datasets
names(subject_test) <- "subject"
names(subject_train) <- "subject"
# Features.txt has the names for the 561 variables. We can use this names
# to clarify info in "X" datasets.
features <- read.table("features.txt", quote="\"")
# now, we pass the names of features to a variable
features <- features$V2
# now, we pass to character this vector
features <- as.character(features)
# finaly, we use this vector as names for table X_test
names(X_test) <- features
names(X_train) <- features
X_testu <- X_test[, !duplicated(colnames(X_test))]
X_trainu <- X_train[, !duplicated(colnames(X_train))]
X_testu <- mutate(X_testu, origin = "test")
X_trainu <- mutate(X_trainu, origin = "train")
finalX <- rbind(X_testu, X_trainu)
std_meanX <- select(finalX, contains("mean()"), contains("std()"), contains("origin"))
subject<-rbind(subject_test, subject_train)
activity<-rbind(y_test, y_train)
stdmeanX <-cbind(origin = std_meanX[,67], std_meanX[,-67])
tidy<-cbind(subject,activity,stdmeanX)
tidy2 <- tidy %>%
    group_by(subject, activity) %>%
    summarise_each(funs(mean))
tidy3 <- cbind( origin = tidy3$origin, tidy3[,1:2], tidy3[,-(1:3)])
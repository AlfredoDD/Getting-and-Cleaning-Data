## Project for Getting and Cleaning Data Course
## We have to merge two datasets into one
# Load necessary packages
library("data.table")
library("dplyr")
library("tidyr")
# First, create directory to contain data, and fix relative work environment
if(!file.exists("Datazip")){
    dir.create("Datazip")
}
setwd("Datazip")
getwd()
# Now, we download the zip file
download.file(url, destfile = "Dataset.zip", method = "curl")
list.files(".")
datedownloaded <- date()
# To avoid a directory with blanks, we use junkpaths = TRUE
unzip("Dataset.zip", junkpaths = TRUE)
list.files(".")
## Firstable, load from disk the values from test Data
subject_test <- read.table("subject_test.txt", quote="\"")
subject_train <- read.table("subject_train.txt", quote="\"")
y_test <- read.table("y_test.txt", quote="\"")
y_train <- read.table("y_train.txt", quote="\"")
X_test <- read.table("X_test.txt", quote="\"")
X_train <- read.table("X_train.txt", quote="\"")
# Put meaningful name to variable in "y" datasets
names(y_test) <- "activity"
names(y_train) <- "activity"
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
# In this moment, we can cbind the 3 tables to have all information in 1 table.
table_test <- cbind(subject_test, y_test, X_test)
table_train <- cbind(subject_train, y_train, X_train)
##So we have rhe 2 tables, but we want tidy data, so we have to take off
## duplicated columns if exists...the same tables ended with "u": unics..
table_testu <- table_test[, !duplicated(colnames(table_test))]
table_trainu <- table_train[, !duplicated(colnames(table_train))]
# We want to follow in any future transformation the origin of data, so we'll
# put a new colum in both tables with information on origin = test or train
# for this, we use the dplyr package
table_testu <- mutate(table_testu, origin = "test")
table_trainu <- mutate(table_trainu, origin = "train")
# Before to do an rbind, we have to be sure that the names of variables
# in both structures are the same.
names(table_testu) == names(table_trainu)
final_table <- rbind(table_testu, table_trainu)
#Now, we can create a new table with only the variables on mean and std.
std_mean <- select(final_table, contains("mean()"), contains("std()"), contains("origin"), contains("subject"), contains("activity"))
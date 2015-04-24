# Getting-and-Cleaning-Data
Project to clean and work a data set, extracting information from a subset.
This repo has a script that collect information from [Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
and extract all files in.

We work with this dataset to do our analysis. We'll use the <b>run_analysis.R</b> script to do all tasks. This script does the nexts tasks:

*	<b>First</b> "Data Load Acitivities": fix relative environment and download to a relative directory the dataset. Then , unzipp this file, and extract to data frames the files that we need.
*	<b>Second</b> "Basic Manipulations": we join subject files, activity files and data files, creates a subset with only desired variables and finaly, do a cbind of desired data.
*	<b>Third</b> "Final tidy Data": creates output file using compact notation from dplyr package.

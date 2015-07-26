# Getting and Cleaning Data - Human Activity Recognition Using Smartphones Dataset
The data used is available at [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

This folder contains two files which takes a raw dataset of Human Activity data recorded using a Samsung Galaxy S II. 
* The run_analysis.R file takes the url of the dataset provided in the assignment outline and downloads it into the working directory if not currently present. 
* It is then tidied by adding the activity and descriptive column names to improve readability of the dataset.
* The run_analysis script then selects the columns which contain Mean and Standard Deviation and disregards the remaining data. 
* The next step of the script takes the tidy data set and returns the average of all the columns excluding the Subject and Activity columns which are not measurement but category data.
* The final step creates a table of the average values of the Mean and Standard Deviation columns.


gcd-smartphone-data
===================

Course project for 'Getting and Cleaning Data' taken on Coursera during August 2014.  
This project is based off data collected from accelerometers from Samsung Galaxy S2 smartphones being worn by test subjects. The purpose of the project is to clean the data so that it is ready for further analysis. Documenting this cleaning process is another essential step which makes up the CodeBook.md file in this repository.

*The run_analysis.R script assumes that the dataset's root is the current working directory.*

Steps taken to produce the tidy dataset:  
	1. Merged the training and the test sets to create one data set.
	2. Extracted only the measurements on the mean and standard deviation for each measurement. 
	3. Used descriptive activity names to name the activities in the data set
	4. Appropriately labelled the data set with their respective variable names. 
	5. Created an independent tidy data set (tidy_data.txt) with the average of each variable for each activity and each subject.  
	

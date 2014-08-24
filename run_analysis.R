#GCD Project
#The analysis to be run can be executed via this script

#1: Merges the training and the test sets to create one data set.
  #assuming the dataset's root is the current working directory
  #read in all the files
subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")

subject_train <- read.table("./train/subject_train.txt")
Y_train <- read.table("./train/Y_train.txt")
X_train <- read.table("./train/X_train.txt")

features <- read.table(".//features.txt", stringsAsFactors = FALSE)
features <- features[, -1]
activity <- read.table(".//activity_labels.txt", stringsAsFactors = FALSE)

#combine the train and test datasets
X <- rbind(X_train, X_test)
Y <- rbind(Y_train, Y_test)
subject <- rbind(subject_train, subject_test)

  #combine the dataset with the subject and activity column
dataset <- cbind(X, subject, Y)
#===========================================
#4: Appropriately labels the data set with descriptive variable names

  #give the columns their names, as per the features file
names(dataset) <- c(features, "subject", "activity")
names(activity) <- c("activity", "activity_desc")

#===========================================

#2: Extracts only the measurements on the mean and standard deviation for each measurement

  #select the standard deviation and mean values
ds_std <- dataset[, grep("std\\()", names(dataset))]
ds_mean <- dataset[, grep("mean\\()", names(dataset))]
  #combine the above with the final two columns (subject and activity)
ds1 <- cbind(ds_mean, ds_std, dataset[, c("subject", "activity")])
#============================================

#3: Uses descriptive activity names to name the activities in the data set

  #merge the activity labels into the dataset
md <- merge(ds1, activity, sort = FALSE)
write.table(md, ".//cleaned_data.txt")
#=============================================
  
#5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject

library(reshape2)
  #remove the first column: activity number, the labels are already in the last column
md <- md[, -1]

  #melt the data frame into a long skinny df, for reshaping later
mdMelt <- melt(md, id.vars = c("subject", "activity_desc"))
  #reshape the melted df into one that has the subject and activity description as X, rest are means of Ys
mdc <- dcast(mdMelt, subject + activity_desc ~ variable, mean)

  #write data frame to file
write.table(mdc, ".//tidy_data.txt")
#==============================================
  #free up memory
rm(list = ls())
  #reload only final datasets
full_dataset <- read.table(".//cleaned_data.txt")
tidy_dataset <- read.table(".//tidy_data.txt")
#==============================================
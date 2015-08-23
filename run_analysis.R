##Installing the libraries needed for the functions to work
library(data.table)
library(plyr)
library(dplyr)
library(reshape2)

##Getting the data from the files
setwd("/Users/geetikagangwani/Downloads")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

##Extracting the column names
col_data <- read.table("./UCI HAR Dataset/features.txt") [,2]

##Using the column names from the features table
colnames(X_test) <- col_data
colnames(X_train) <- col_data

##Merging Y and subject data into X
X_train$activities <- Y_train[,1]
X_test$activities <- Y_test[,1]
X_train$participants <- subject_train[,1]
X_test$participants <- subject_test[,1]

##Merging the data (all)
data_merge <- rbind(X_test, X_train)

#Merging the data for columns with mean and std deviation
mean_std_col <- grepl("mean|std", col_data)
X_train_mstd <- X_train[,mean_std_col]
X_test_mstd <- X_test[,mean_std_col]
merge_mstd_data <- rbind(X_train_mstd, X_test_mstd)

#Setting the 
data_merge$activities <- as.character(data_merge$activities)
data_merge$activities[data_merge$activities == 1] <- "WALKING"
data_merge$activities[data_merge$activities == 2] <- "WALKING_UPSTAIRS"
data_merge$activities[data_merge$activities == 3] <- "WALKING_DOWNSTAIRS"
data_merge$activities[data_merge$activities == 4] <- "SITTING"
data_merge$activities[data_merge$activities == 5] <- "STANDING"
data_merge$activities[data_merge$activities == 6] <- "LAYING"
data_merge$activities <- as.factor(data_merge$activities)

data_merge$participants <- as.character(data_merge$participants)
data_merge$participants[data_merge$participants == 1] <- "Participant 1"
data_merge$participants[data_merge$participants == 2] <- "Participant 2"
data_merge$participants[data_merge$participants == 3] <- "Participant 3"
data_merge$participants[data_merge$participants == 4] <- "Participant 4"
data_merge$participants[data_merge$participants == 5] <- "Participant 5"
data_merge$participants[data_merge$participants == 6] <- "Participant 6"
data_merge$participants[data_merge$participants == 7] <- "Participant 7"
data_merge$participants[data_merge$participants == 8] <- "Participant 8"
data_merge$participants[data_merge$participants == 9] <- "Participant 9"
data_merge$participants[data_merge$participants == 10] <- "Participant 10"
data_merge$participants[data_merge$participants == 11] <- "Participant 11"
data_merge$participants[data_merge$participants == 12] <- "Participant 12"
data_merge$participants[data_merge$participants == 13] <- "Participant 13"
data_merge$participants[data_merge$participants == 14] <- "Participant 14"
data_merge$participants[data_merge$participants == 15] <- "Participant 15"
data_merge$participants[data_merge$participants == 16] <- "Participant 16"
data_merge$participants[data_merge$participants == 17] <- "Participant 17"
data_merge$participants[data_merge$participants == 18] <- "Participant 18"
data_merge$participants[data_merge$participants == 19] <- "Participant 19"
data_merge$participants[data_merge$participants == 20] <- "Participant 20"
data_merge$participants[data_merge$participants == 21] <- "Participant 21"
data_merge$participants[data_merge$participants == 22] <- "Participant 22"
data_merge$participants[data_merge$participants == 23] <- "Participant 23"
data_merge$participants[data_merge$participants == 24] <- "Participant 24"
data_merge$participants[data_merge$participants == 25] <- "Participant 25"
data_merge$participants[data_merge$participants == 26] <- "Participant 26"
data_merge$participants[data_merge$participants == 27] <- "Participant 27"
data_merge$participants[data_merge$participants == 28] <- "Participant 28"
data_merge$participants[data_merge$participants == 29] <- "Participant 29"
data_merge$participants[data_merge$participants == 30] <- "Participant 30"
data_merge$participants <- as.factor(data_merge$participants)

dt <- data.table(data_merge)
head(dt)
##final_data = dcast(data_merge, activities ~ variable, mean)
final_data <- dt[, lapply(.SD,mean), by = "activities"]
final_data
write.table(final_data, file="./tidy_data.txt", row.names = FALSE)

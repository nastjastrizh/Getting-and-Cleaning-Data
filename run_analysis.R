setwd ("E:/")

#file download

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Data.zip")

#unzip file

unzip(zipfile="./data/Data.zip",exdir="./data")

#read general and training data

subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")  

#Merges the training and the test sets to create one data set

Subject <- rbind(subject_train, subject_test)
X <- rbind(X_test, X_train)
Y <- rbind(y_test, y_train)

names(Subject)<-c("subject")
names(Y)<- c("activity")
names(X)<- features$V2

new_data <- cbind(Subject, Y)
Full_data <- cbind(X, new_data)

#Extracts only the measurements on the mean and standard deviation for each measurement

mean_std <-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
selectedNames<-c(as.character(mean_std), "subject", "activity" )
data_mean_std <-subset(Full_data,select=selectedNames)

#Uses descriptive activity names to name the activities in the data set

library(plyr)
colnames(activity_labels) <- c("activity")
data_mean_std <- join(data_mean_std, Y, by = "activity", match = "first")

#Appropriately labels the data set with descriptive variable names

names(data_mean_std) <- gsub("Acc", "Acceleration", names(data_mean_std))
names(data_mean_std) <- gsub("^t", "Time", names(data_mean_std))
names(data_mean_std) <- gsub("^f", "Frequency", names(data_mean_std))
names(data_mean_std) <- gsub("BodyBody", "Body", names(data_mean_std))
names(data_mean_std) <- gsub("mean", "Mean", names(data_mean_std))
names(data_mean_std) <- gsub("std", "Std", names(data_mean_std))
names(data_mean_std) <- gsub("Freq", "Frequency", names(data_mean_std))
names(data_mean_std) <- gsub("Mag", "Magnitude", names(data_mean_std))

#Creates a second, independent tidy data seknit2html("codebook.Rmd")t with the average of each variable for each activity and each subject

tidydata <- ddply(data_mean_std, c("subject","activity"), numcolwise(mean))
write.table(tidydata,file="./data/tidydata.txt", row.names = FALSE)
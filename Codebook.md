# Code Book

Start: Download and unzip the file

### 1.Read data and Merge
subject_test : subject IDs for test

subject_train : subject IDs for train

X_test : values of variables in test

X_train : values of variables in train

y_test : activity ID in test

y_train : activity ID in train

activity_labels : Description of activity IDs in y_test and y_train

features : description(label) of each variables in X_test and X_train

Full_data : bind of all data

### 2.Extract only mean() and std()
Create a vector of only mean and std labels, then use the vector to subset dataSet.

### 3.Changing Column label of dataSet
Create a vector of "clean" feature names by getting rid of "()" at the end. Then, will apply that to the data_mean_std to rename column labels.

### 4.Adding Subject and Activity to the dataSet
Combine test data and train data of subject and activity, then give descriptive lables. Finally, bind with data_mean_std. At the end of this step, dataSet has 2 additonal columns 'subject' and 'activity' in the left side.

subject : bind of subject_train and subject_test
activity : bind of y_train and y_test

### 5.Rename activity name
Rename each levels with 2nd column of activity_levels. 

### 6.Output tidy data
In this part, data_mean_std is melted to create tidy data. It will also add [mean of] to each column labels for better description. Finally output the data as "tidydata.txt"

## How run_analysis.R implements the above steps:
Require plyr and data.table librareis.
Load both test and train data
Load the features and activity labels.
Extract the mean and standard deviation column names and data.
Process the data. There are two parts processing test and train data respectively.
Merge data set.
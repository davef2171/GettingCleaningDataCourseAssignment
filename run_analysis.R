## run_analysis.R

## packages we need
library(data.table)
library(dplyr)

## Expects working directory to contain two directories, 
## the test and train data files

## Master data set
## original data was split into two data sets and no further
## data manipulation so safe to recombine

## Files have an implict data id using row position so do not
## sort of touch coulmn or row order before recombination

## read data set feature names
features <- read.csv("./features.txt",header=FALSE,sep="", col.names = c("number","featurename"))

## First recombine data set

##read files
test_subjects <- read.csv("./test/subject_test.txt", header=FALSE,sep="", col.names = c("Subject"))
test_activities <- read.csv("./test/y_test.txt", header=FALSE,sep="", col.names = c("Activity"))
test_data <- read.csv("./test/X_test.txt", header=FALSE,sep="")

##read files
train_subjects <- read.csv("./train/subject_train.txt", header=FALSE,sep="", col.names = c("Subject"))
train_activities <- read.csv("./train/y_train.txt", header=FALSE,sep="", col.names = c("Activity"))
train_data <- read.csv("./train/X_train.txt", header=FALSE,sep="")

# recombine into all data
all_subjects <- rbind( test_subjects, train_subjects)
all_activities <- rbind( test_activities, train_activities)
all_data <- rbind( test_data, train_data)

## Create a subset of just Mean and Standard Deviation Columns

## extract columns of interest (mena and standard deviations)
wanted_cols <- c( grep("*.mean*",features$featurename),
                  grep("*.std*",features$featurename))

subset_data <- select(all_data,wanted_cols)
names(subset_data) <- features$featurename[wanted_cols]

## expand column names to be more informative
analysis_column_names <- names( subset_data)
analysis_column_names <- sub("t","Time.",analysis_column_names)
analysis_column_names <- sub("f","Freq.",analysis_column_names)
analysis_column_names <- sub("Freq","Frequency",analysis_column_names)
analysis_column_names <- sub("Acc","Accelerometer",analysis_column_names)
analysis_column_names <- sub("Gyro","Gyroscope",analysis_column_names)
names(subset_data) <- analysis_column_names

## recombine subject, activities, data
analysis_data_table <- data.table( all_subjects, all_activities, subset_data)

## conserve memory remove originals
rm(test_subjects)
rm(test_activities)
rm(test_data)
rm(train_subjects)
rm(train_activities)
rm(train_data)
rm(all_subjects)
rm(all_activities)
rm(all_data)
rm(subset_data)

## convert activties to user friendly names
## read activity labels
activity_labels <- read.csv("./activity_labels.txt", header=FALSE, sep="",
                            col.names =c("number","name"))

## create list of activities by name
Activity_byname <- sapply( analysis_data_table$Activity, function(x){ as.character(activity_labels$name[x])}) 

## Add Subject and Activity by Name
analysis_data_table <- mutate(analysis_data_table, TestActivity.byname = Activity_byname)
## remove Activty by number
analysis_data_table$Activity <- NULL

##tidy up
rm(features)
rm(activity_labels)
rm(Activity_byname)
rm(analysis_column_names)

## Analysis Phase
## Create a tidy data set with the average of each variable 
## for each activity and each subject.
summary_dataset <- summarize_all(group_by(analysis_data_table, Subject, TestActivity.byname),mean)

## rename column names to be more informative
summary_column_names <- names( summary_dataset)
summary_column_names <- sub("Time","Mean.Time",summary_column_names)
summary_column_names <- sub("Frequency","Mean.Frequency",summary_column_names)
names(summary_dataset) <- summary_column_names

##tidy up
rm(summary_column_names)
rm(analysis_data_table)
rm(wanted_cols)

#write out dataset
if(!file.exists("./summary")) { dir.create("./summary")}

## Write full dataset
write.table(summary_dataset, file="./summary/summary_full.txt",sep=" ",row.names=FALSE,col.names=TRUE)

summary_subjects <- summary_dataset$Subject
summary_dataset$Subject <- NULL
write.table(summary_subjects, file="./summary/summary_subjects.txt",sep=" ",row.names=FALSE,col.names=FALSE)

summary_activity <- summary_dataset$TestActivity.byname
summary_dataset$TestActivity.byname <- NULL
write.table(summary_activity, file="./summary/summary_activity.txt",sep=" ",row.names=FALSE,col.names=FALSE)

##CAUTION these columns names may not be syntactically correct so meed to be coerced before use
write.table(names(summary_dataset), file="./summary/summary_fields.txt",sep=" ",row.names=FALSE,col.names=FALSE)

write.table(summary_dataset, file="./summary/summary.txt",sep=" ",row.name=FALSE,col.names=FALSE)

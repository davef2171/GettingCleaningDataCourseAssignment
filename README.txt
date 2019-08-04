==================================================================
This is an extension analysis of the data sets originally collected and analysis under
the following:

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The original project description is located at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The set used in this project at located at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data is under the following license:
License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

===================================================================


In the original analysis teh dates was separated in to two a test dataset and a training dataset. No specific different processing was performed on the two data sets so this project starts by recombining them back in to the original complete dataset.

The data was in a number of files:
1.subject_dataset.txt - a list of the subject identifier (integer)
2,X_dataset.txt - a set of 561 variables
3.y_dataset.txt - a list of the activity identifiers (integer)
All three files used row order as an implicit index to link the subject, activity and data measurements


Based on the original authors field description and naming convention any field which has a type descriptor starting with the word "mean" or "std" denoting a mean or standard deviation was extracted into a subset of the data.

The using the original notes field names had abbreviations expanded into readable formats.

Using the supplied Activity identifier to name file Activities were replaced by the equivalent readable names.

The subset of Subject, Activities by name and the subset of mean and standard deviation data was assembled into a complete dataset.

This subset of data was the basis for the subsequent analysis.

The analysis collapsed teh data to provide a mean for was of the remaining data variables summarized by Subject and Activity pairs. This collapsed the original measurements to a table of 180 entries representing 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) per test subject.

For each record it is provided:
- An identifier of the subject who carried out the experiment.
- Its activity label.
- A 79-feature vector with the mean of the extracted original mean and std variables.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'Original_README.txt' a copy of the original README.txt file describing the original data

- 'summary.txt' the data set is a 180 row set of 79 variable which  are means of values which were normalized and bounded within [-1,1].

- 'summary_field.txt' the data set variable names. 

- 'summary_subject.txt' - Each of the 180 rows identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'summary_activity.txt' - Each of the 180 rows identifies the activity performed by the subject for each variable. Its range of one of (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

- 'run_analysis.R' an R script which taking the original data set processes it to produce the new summary dataset. The R scripts working directory should be the top directory of the extracted zip file of the original data.

Processing steps
=========================================
1. Relieve the dataset UCI HAR dataset.zip from the supplied link

2. Unzip the Data set

3. Instal teh R Script  run_analysis.R in top directory, usually "UCI HAR Dataset"

4. The R Script will request the libraries "data.table" and "dplyr" to be available

5. Run the R Script

6 It will create a data table of the summary dataset and generate the following files in a new directory called "summary"
summary.txt
summary_field.txt
summary_activity.txt
summary_subject.txt

7. Note - the variable names used in the columns as in summary_field.txt are readable but not syntactically correct and either need to be or will be coerced to correct before use. 


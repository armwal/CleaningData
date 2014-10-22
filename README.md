# Running the analysis

## Prerequisites

Make sure that the UCI data is present in a folder named "UCI HAR Dataset" in your working directory.

## Analysis

Run run_analysis.R

This script will read in the training and test data, select those features that are generated from 
measurement means and standard deviations for all measurement and merge them. It will then construct 
a data frame, combining these features with the subject codes and the activity labels. Additionally,
it will construct a second data frame holding the averages of all measurements for each combination
of subject code and activity label. The resluting data frames are:

data - holding all samples of the combined training and test data with reduced feature set
averageData - holding the averages for each measurement for all subjects and activities
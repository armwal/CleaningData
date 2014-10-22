# read training data
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X.train <- read.table("UCI HAR Dataset/train/X_train.txt")
y.train <- read.table("UCI HAR Dataset/train/y_train.txt")

# read test data
subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X.test <- read.table("UCI HAR Dataset/test/X_test.txt")
y.test <- read.table("UCI HAR Dataset/test/y_test.txt")

# get the feature names 
features <- read.table("UCI HAR Dataset/features.txt")

# select features generated from measurement mean and standard deviations
meanFeatures <- grep(".*mean\\(\\)",features[[2]])
stdFeatures <- grep(".*std\\(\\)",features[[2]])
validFeatures <- sort(c(meanFeatures, stdFeatures))

# replace activity codes with activity names
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
y <- rbind(y.train, y.test)
activities <- sapply(y, function(x){activityLabels[[2]][x]})

# make a subject vector
subject <- rbind(subject.train, subject.test)

# generate the data frame
data <- data.frame(subject, activities, rbind(X.train[,validFeatures], X.test[,validFeatures]))
names(data) <- c("Subject", "Activity", as.vector(features[[2]][validFeatures]))
as.factor(data$Subject)
as.factor(data$Activity)

# generate the averages per activity and subject
averageData <- aggregate(x = data[,3:68], by = list(Subject=data$Subject,Activity=data$Activity), FUN = "mean")

# write the averages to a file
write.table(averageData, "averageData.txt", row.names=F)

# clean up
rm(subject.train, subject.test, X.train, y.train, X.test, y.test)
rm(features, meanFeatures, stdFeatures, validFeatures, activityLabels)
rm(subject,y,activities)
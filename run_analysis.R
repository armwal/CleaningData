subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X.train <- read.table("UCI HAR Dataset/train/X_train.txt")
y.train <- read.table("UCI HAR Dataset/train/y_train.txt")

subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X.test <- read.table("UCI HAR Dataset/test/X_test.txt")
y.test <- read.table("UCI HAR Dataset/test/y_test.txt")

features <- read.table("UCI HAR Dataset/features.txt")
meanFeatures <- grep(".*mean()",features[[2]])
stdFeatures <- grep(".*std()",features[[2]])
validFeatures <- sort(c(meanFeatures, stdFeatures))

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")

subject <- rbind(subject.train, subject.test)

y <- rbind(y.train, y.test)
activities <- sapply(y, function(x){activityLabels[[2]][x]})

data <- data.frame(subject, activities, rbind(X.train[,validFeatures], X.test[,validFeatures]))
names(data) <- c("Subject", "Activity", as.vector(features[[2]][validFeatures]))
as.factor(data$Subject)
as.factor(data$Activity)

averageData <- aggregate(x = data[,3:81], by = list(Subject=data$Subject,Activity=data$Activity), FUN = "mean")
write.table(averageData, "averageData.txt", row.names=F)

#clean up
rm(subject.train, subject.test, X.train, y.train, X.test, y.test)
rm(features, meanFeatures, stdFeatures, validFeatures, activityLabels)
rm(subject,y,activities)
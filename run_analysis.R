# Setting the working directory
setwd("C:/Users/Nayan/Desktop/Coursera")

# Training dataset is formed
# reading the data from X_train.txt file
training <- read.csv("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
# adding a column to the training dataset to include the data from Y_train.txt file
training[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
# adding a column to the training dataset to include the data from subject_train.txt file
training[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

# Testing dataset is formed
# reading the data from X_test.txt file
testing = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
# adding a column to the testing dataset to include the data from Y_test.txt file
testing[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
# adding a column to the testing dataset to include the data from subject_test.txt file
testing[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

# Reading the data from activity_labels.txt file
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# Reading features and making the feature names better suited for R with some substitutions
# reading the data from activity_labels.txt file
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
# replacing the pattern -mean with Mean
features[,2] = gsub('-mean', 'Mean', features[,2])
# replacing the pattern -std with Std
features[,2] = gsub('-std', 'Std', features[,2])
# removing the special characters
features[,2] = gsub('[-()]', '', features[,2])

# Training and testing datasets are merged
allData = rbind(training, testing)

# Getting the row indices for rows involving mean and std. dev. only
colsWeWant <- grep(".*Mean.*|.*Std.*", features[,2])
# First reducing the features table to what we want
features <- features[colsWeWant,]
# Now add the last two columns (subject and activity)
colsWeWant <- c(colsWeWant, 562, 563)
# And remove the unwanted columns from allData
allData <- allData[,colsWeWant]
# Add the column names (features) to allData
colnames(allData) <- c(features$V2, "Activity", "Subject")
# The header is converted to lower case
colnames(allData) <- tolower(colnames(allData))

# The activity is labelled
currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
        allData$activity <- gsub(currentActivity, currentActivityLabel, allData$activity)
        currentActivity <- currentActivity + 1
}

allData$activity <- as.factor(allData$activity)
allData$subject <- as.factor(allData$subject)

tidy <- aggregate(allData, by=list(activity = allData$activity, subject=allData$subject), mean)
tidy[,90] = NULL
tidy[,89] = NULL

write.table(tidy, "tidy.txt", sep="\t", row.name=FALSE)

library(dplyr)

# Read features list
features <- read.table("./UCI HAR Dataset/features.txt")

# Read test data set
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_act <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subj <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(test) <- features$V2
test$activity <- test_act$V1
test$subject <- test_subj$V1

# Remove unused variables
rm(test_act, test_subj)

# Read training data set
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_act <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subj <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(train) <- features$V2
train$activity <- train_act$V1
train$subject <- train_subj$V1

# Remove unused variables
rm(train_act, train_subj, features)

# Merge training data and test data
all_data <- rbind(test, train)
rm(test, train)

# Extract mean and standard deviation columns
index <- grep("mean", names(all_data))
std_index <- grep("std", names(all_data))
index <- c(index, std_index, 562, 563) # Add activity and subject column index
index <- index[order(index)]
all_data <- all_data[, index]

rm(index, std_index)

activity_list <- read.table("./UCI HAR Dataset/activity_labels.txt")
all_data$act_label <- activity_list[all_data$activity, "V2"]
all_data <- select(all_data, -(activity))
all_data <- rename(all_data, activity = act_label)

rm(activity_list)

all_data$activity <- as.factor(all_data$activity)
all_data$subject <- as.factor(all_data$subject)

# Calculate mean of each column
all_data <- group_by(all_data, activity, subject)
summarized_data <- summarize_each(all_data, funs(mean))

rm(all_data)

# Write the resulting data into file: tidy_HAR_data.txt
write.table(summarized_data, file = "tidy_HAR_data.txt", row.names = FALSE)
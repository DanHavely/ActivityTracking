library(dplyr)

# Load reference tables
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("activity_id","activity_label")
# Tidy up what will become the data column names
features <- read.table("UCI HAR Dataset/features.txt")
names(features) <- c("feature_id","feature_label")
features$feature_label <- gsub("^t","time_domain_",  features$feature_label)
features$feature_label <- gsub("^f","freq_domain_",  features$feature_label)
features$feature_label <- gsub("Body","body_",  features$feature_label)
features$feature_label <- gsub("Gravity","gravity_",  features$feature_label)
features$feature_label <- gsub("Acc","accelerometer_",  features$feature_label)
features$feature_label <- gsub("Gyro","gyroscope_",  features$feature_label)
features$feature_label <- gsub("Mag","magnitude_",  features$feature_label)
features$feature_label <- gsub("Jerk","jerk_",  features$feature_label)
features$feature_label <- gsub("-(.*)-(.+)$", "\\2axis_\\1", features$feature_label)
features$feature_label <- gsub(" |-|,|\\(\\)", "", features$feature_label)

# Load training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- c("subject_id")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
names(y_train) <- c("activity_id")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
names(x_train) <- features$feature_label
# Bind training data together by row-order
train_data <- cbind(subject_train, y_train, study_phase = "train", x_train)

# Load testing data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- c("subject_id")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
names(y_test) <- c("activity_id")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
names(x_test) <- features$feature_label
# Bind testing data together by row-order
test_data <- cbind(subject_test, y_test, study_phase = "test", x_test)

# Bind training and testing data together
activity_tracking <- rbind(train_data, test_data)
# Make activity field from y_**** tables a factor and give it the names from activity_labels
activity_tracking$activity_id <- as.factor(activity_tracking$activity_id)
levels(activity_tracking$activity_id) <- activity_labels$activity_label

# Select out only those fields with means and standard deviations by name - I'm ignoring the additional freq mean columns
activ_track_mean_std <- activity_tracking[,c(c(TRUE,TRUE,TRUE),grepl("mean$|std$",features$feature_label))]

# Summarise with mean of all measures by activity and subject
activ_track_summary <- activ_track_mean_std %>% select(-study_phase) %>% group_by(activity_id, subject_id) %>% summarise_all(mean) 

# Save datasets
saveRDS(activ_track_mean_std,"activ_track_mean_std.rds")
saveRDS(activ_track_summary,"activ_track_summary.rds")

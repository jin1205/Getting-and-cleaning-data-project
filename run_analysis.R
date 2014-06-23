## get train data with id
x_train <- read.csv("./train/X_train.txt", header=FALSE,sep="", comment.char="", colClasses="numeric")
id_train <- read.csv("./train/subject_train.txt", header=FALSE,sep="", comment.char="", colClasses="numeric")
names(id_train) <- "id"
activity_train <- read.csv("./train/Y_train.txt", header=FALSE,sep="", comment.char="", colClasses="numeric")

names_factor <- factor(c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"),
              levels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
activity_train <- names_factor[unlist(activity_train)]
activity_train <- data.frame(activity_train)
names(activity_train) <- "Activity"
train_data <- cbind(id_train,activity_train)
train_data <- cbind(train_data, x_train)
## get test data with id
x_test <- read.csv("./test/X_test.txt", header=FALSE,sep="", comment.char="", colClasses="numeric")
id_test <- read.csv("./test/subject_test.txt", header=FALSE,sep="", comment.char="", colClasses="numeric")
activity_test <- read.csv("./test/Y_test.txt", header=FALSE,sep="", comment.char="", colClasses="numeric")
activity_test <- names_factor[unlist(activity_test)]
activity_test <- data.frame(activity_test)
names(id_test) <- "id"
names(activity_test) <- "Activity"
test_data <- cbind(id_test,activity_test)
test_data <- cbind(test_data,x_test)

## merge data without ordering
mergedData <- rbind(test_data,train_data)

subdata <- mergedData[,c(1:8,42:47,82:87,122:127,162:167, 202:203, 215:216, 228:229, 241:242, 254,255)]
names(subdata)<- c("id","Activitiy","tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z","tBodyAcc-std()-X",
                   "tBodyAcc-std()-Y","tBodyAcc-std()-Z", "tGravityAcc-mean()-X","tGravityAcc-mean()-Y",
                   "tGravityAcc-mean()-Z","tGravityAcc-std()-X","tGravityAcc-std()-Y","tGravityAcc-std()-Z",
                   "tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z","tBodyAccJerk-std()-X",
                   "tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z","tBodyGyro-mean()-X","tBodyGyro-mean()-Y",
                   "tBodyGyro-mean()-Z","tBodyGyro-std()-X","tBodyGyro-std()-Y","tBodyGyro-std()-Z",
                   "tBodyGyroJerk-mean()-X","tBodyGyroJerk-mean()-Y","tBodyGyroJerk-mean()-Z","tBodyGyroJerk-std()-X",
                   "tBodyGyroJerk-std()-Y","tBodyGyroJerk-std()-Z","tBodyAccMag-mean()","tBodyAccMag-std()",
                   "tGravityAccMag-mean()","tGravityAccMag-std()","tBodyAccJerkMag-mean()","tBodyAccJerkMag-std()",
                   "tBodyGyroMag-mean()","tBodyGyroMag-std()","tBodyGyroJerkMag-mean()","tBodyGyroJerkMag-std()")

sp_factor <- subdata[,1:2]
sp <- split(subdata, sp_factor, drop = TRUE)
sp_data <- lapply(sp,function(x) colMeans(x[,3:42]))
sp_data <- data.frame(sp_data)
sp_data <- data.frame(t(sp_data))

id <- gl(30,6)
Activity <- rep(1:6,30)
Activity <- names_factor[Activity]
Activity <- as.character(Activity)
firsttwocols <- cbind(id, Activity)
tidy_data <- cbind(firsttwocols, sp_data)
rownames(tidy_data) <- 1:180
write.table(tidy_data, file="./TidyDataset.txt", sep = " ")

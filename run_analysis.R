## Load variables

features <- read.table('features.txt')
activity_labels <- read.table('activity_labels.txt')

## Test set load

x_test <- read.table('test/X_test.txt')
y_test <-read.table('test/y_test.txt')
subject_test <- read.table('test/subject_test.txt')

## Training Set load

x_train <- read.table('train/X_train.txt')
y_train<-read.table('train/y_train.txt')
subject_train <- read.table('train/subject_train.txt')

#Add column names

names(x_train)<- features[,2]
names(x_test) <- features[,2]

## Create Labels
train_label <- rep("TRAIN", 7352)
test_label <- rep("TEST", 2947)

## cbind train and test sets
total_train <- cbind(subject_train, train_label,y_train, x_train)
total_test <- cbind(subject_test, test_label,y_test, x_test)

names(total_train) [2] <- "type"
names(total_test) [2] <- "type"
names(total_train) [1] <- "subject"
names(total_test) [1] <- "subject"
names(total_train) [3] <- "activity"
names(total_test) [3] <- "activity"

## rbind all data together

all_data <- rbind(total_train, total_test)

## Condense columns

nam <- names(all_data)
mean_true <- grepl("mean", nam)
std_true <- grepl("std", nam)
true1 <- mean_true | std_true
true1[1:3] <- TRUE
sset1 <- subset(all_data, select = true1)

nam2 <- names(sset1)
meanFreq<- grepl("meanFreq", nam2)
sset2 <- subset(sset1, select = !meanFreq)

#Sub for real variables
y <- sub(1,"WALKING",sset2[,3])
y <- sub(2,"WALKING_UPSTAIRS",y)
y <- sub(3,"WALKING_DOWNSTAIRS",y)
y <- sub(4,"SITTING",y)
y <- sub(5, "STANDING", y)
y <- sub(6, "LAYING", y)
sset2$activity <- y

#Condense the data by means

mdata <- melt(sset2, id.vars=c("subject","activity", "type"))
final <- dcast(data = mdata, subject + activity + type ~ variable, fun = mean)

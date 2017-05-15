library(dplyr)

# Getting Feature Names
FeaturesNames <- read.table("UCI HAR Dataset/features.txt",header = F, stringsAsFactors = F)[,2]

#Reading Test Dataset
x_test <- read.table(textConnection(gsub("[ \t]+", " ", readLines("UCI HAR Dataset/test/X_test.txt"))),header = F, col.names = FeaturesNames)
y_test <- read.csv("UCI HAR Dataset/test/y_test.txt",header = F, col.names = "Activity")
subject_id_test <- read.csv("UCI HAR Dataset/test/subject_test.txt",header = F, col.names = "Subject_ID")
TestDataset <- cbind(subject_id_test,x_test,y_test)

#Reading Train Dataset
x_train <- read.table(textConnection(gsub("[ \t]+", " ", readLines("UCI HAR Dataset/train/X_train.txt"))),header = F, col.names = FeaturesNames)
y_train <- read.csv("UCI HAR Dataset/train/y_train.txt",header = F, col.names = "Activity")
subject_id_train <- read.csv("UCI HAR Dataset/train/subject_train.txt",header = F, col.names = "Subject_ID")
TrainDataset <- cbind(subject_id_train,x_train,y_train)


#Merging the datasets
CompleteDataset <- rbind(TrainDataset,TestDataset)

# Getting variables of means or std
completeNames <- names(CompleteDataset)
Selectedcolumns <- grep("mean|std", completeNames)
Selectedcolumns <- c(1,Selectedcolumns,length(completeNames)) # Adding the subject_ID and Label columns
FilteredData <- CompleteDataset[,Selectedcolumns]

#Replacing activity code with activity name
ActivityNames <- read.table("activity_labels.txt",header = F, stringsAsFactors = F)
FilteredData$Activity <- as.character(FilteredData$Activity)
FilteredData$Activity <- ActivityNames[FilteredData$Activity,2]

# Summarise the data by getting the mean of each column grouped by activity and subject
FinalDataset <- FilteredData %>% 
                  group_by(Activity,Subject_ID) %>% 
                  summarise_each(funs(mean))

#Save the dataset
write.table(FinalDataset,file = "SummarisedDataSet.txt", row.name=FALSE)
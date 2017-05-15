# Getting Feature Names
FeaturesNames <- read.table("features.txt",header = F, stringsAsFactors = F)[,2]

#Reading Test Dataset
x_test <- read.table(textConnection(gsub("[ \t]+", " ", readLines("test/X_test.txt"))),header = F, col.names = FeaturesNames)
y_test <- read.csv("test/y_test.txt",header = F, col.names = "Label")
subject_id_test <- read.csv("test/subject_test.txt",header = F, col.names = "Subject_ID")
TestDataset <- cbind(subject_id_test,x_test,y_test)

#Reading Train Dataset
x_train <- read.table(textConnection(gsub("[ \t]+", " ", readLines("train/X_train.txt"))),header = F, col.names = FeaturesNames)
y_train <- read.csv("train/y_train.txt",header = F, col.names = "Label")
subject_id_train <- read.csv("train/subject_train.txt",header = F, col.names = "Subject_ID")
TrainDataset <- cbind(subject_id_train,x_train,y_train)


#Merging the datasets
CompleteDataset <- rbind(TrainDataset,TestDataset)



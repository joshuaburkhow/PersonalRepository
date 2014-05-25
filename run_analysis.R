# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
# measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject. 

# Note: The data set is a zip file that was downloaded manually so Before this 
# script is run, you need to set your working directory to the appropriate 
# location (setwd()) to where the extracted zip file resides
setwd("L:\\Files\\Coursera\\Getting and Cleaning Data\\Project\\UCI HAR Dataset\\")

# Read in training and test data
    # create the data directory that will hold the merged files
    if(!file.exists("./data")){dir.create("./data")}
    
    #First we need to read the features list (headers)
    library(reshape2)
    features <- read.table("features.txt")
    features <- rbind(features, data.frame(V1 = "562",V2 = "subject"))
    features <- rbind(features, data.frame(V1 = "563",V2 = "y"))
    
    #tranpose feature list so it can be used as headers for merged dataset
    features <- t(features[2])
    features$V1 <- NULL

    #read files into environment
    testData <- read.table(file="./test/X_test.txt",header=FALSE)
    trainData <- read.table(file="./train/X_train.txt",header=FALSE)
    subject_test <- read.table(file="./test/subject_test.txt",header=FALSE)
    y_test <- read.table(file="./test/y_test.txt",header=FALSE)
    subject_train <- read.table(file="./train/subject_train.txt",header=FALSE)
    y_train <- read.table(file="./train/y_train.txt",header=FALSE)
    activity_labels <- read.table(file="./activity_labels.txt",header=FALSE)
    

# Merge datasets
    #set the column names
    names(subject_test) <- "subject"
    names(subject_train) <- "subject"
    names(y_test) <- "y"
    names(y_train) <- "y"
    names(activity_labels) <- "y"

    testData <- cbind(testData,subject_test,y_test)
    trainData <- cbind(trainData,subject_train,y_train)
    
    mergedData <- merge(testData,trainData,all=TRUE)
    
    #set the column names
    names(mergedData) <- features
    

# Extract only the mean and Std dev for each measurement (and subject and y)
    mergedData <- mergedData[ , grepl( "mean|std" , names( mergedData ) ) | names(mergedData) =="y" | 
                                          names(mergedData) == "subject"  ]
    mergedData <- mergedData[ , !grepl( "Freq" , names( mergedData ) ) ]

# Assign the descriptive activity names to the data set
    mergedData <- merge(x = mergedData, y = activity_labels, by = "y", all.x = TRUE)    
    
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
    mergedDataTidy <- melt(mergedData,id.vars = c("subject","y"))
    mergedDataTidy <- cast(data=mergedDataTidy, subject ~ y,mean,value = 'value')

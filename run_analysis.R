##Step01

subject_test<-"./UCI HAR Dataset/test/subject_test.txt"
x_test<-"./UCI HAR Dataset/test/X_test.txt"
y_test<-"./UCI HAR Dataset/test/y_test.txt"
subject_train<-"./UCI HAR Dataset/train/subject_train.txt"
x_train<-"./UCI HAR Dataset/train/X_train.txt"
y_train<-"./UCI HAR Dataset/train/y_train.txt"
activity_labels<-"./UCI HAR Dataset/activity_labels.txt"
features<-"./UCI HAR Dataset/features.txt"
subject_trainTXT<-read.csv(subject_train,sep="",header=FALSE,col.names="subject")
x_trainTXT<-read.csv(x_train,sep="",header=FALSE)
y_trainTXT<-read.csv(y_train,sep="",header=FALSE,col.names="activity")
subject_testTXT<-read.csv(subject_test,sep="",header=FALSE,col.names="subject")
x_testTXT<-read.csv(x_test,sep="",header=FALSE)
y_testTXT<-read.csv(y_test,sep="",header=FALSE,col.names="activity")
activity_labelsTXT<-read.csv(activity_labels,sep="",header=FALSE)
featuresTXT<-read.csv(features,sep="",header=FALSE)

featuresTXT$V2<-gsub("BodyBody","Body",featuresTXT$V2)

names(x_trainTXT)<-featuresTXT[1:561,2]
names(x_testTXT)<-featuresTXT[1:561,2]

testTXT<-cbind(subject_testTXT,x_testTXT,y_testTXT)
trainTXT<-cbind(subject_trainTXT,x_trainTXT,y_trainTXT)

DataSet01<-rbind(testTXT,trainTXT)

##Step02

DataSet01<-DataSet01[,grep("-mean\\(\\)|-std\\(\\)|subject|activity",names(DataSet01))]

##Step03

DataSet01$activity_desc<-activity_labelsTXT$V2[DataSet01$activity]
DataSet01$activity<-NULL

##Step04

    names(DataSet01)<-gsub("^t","time_",names(DataSet01))
    names(DataSet01)<-gsub("^f","freq_",names(DataSet01))
    names(DataSet01)<-gsub("Body","body_",names(DataSet01))
    names(DataSet01)<-gsub("Gravity","grav_",names(DataSet01))
    names(DataSet01)<-gsub("Acc","accelerometer_",names(DataSet01))
    names(DataSet01)<-gsub("Gyro","gyroscope_",names(DataSet01))
    names(DataSet01)<-gsub("Jerk","jerk_",names(DataSet01))
    names(DataSet01)<-gsub("Mag","magnitude_",names(DataSet01))
    names(DataSet01)<-gsub("-mean\\(\\)","mean",names(DataSet01))
    names(DataSet01)<-gsub("-std\\(\\)","stdev",names(DataSet01))
    names(DataSet01)<-gsub("-X","_x",names(DataSet01))
    names(DataSet01)<-gsub("-Y","_y",names(DataSet01))
    names(DataSet01)<-gsub("-Z","_z",names(DataSet01))

##Step05

library(reshape2)
DataSet02<-melt(DataSet01, id.vars=c("activity_desc","subject"))

DataSet02<-dcast(DataSet02,activity_desc + subject ~ variable,mean)

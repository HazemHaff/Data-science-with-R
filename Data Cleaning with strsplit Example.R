library(dplyr)

#PUMS 2006
#Download the dataset
urlds<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(urlds, destfile = "ss06hid.csv")

#Download the Dataset Codebook
urlcb<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(urlcb, destfile = "PUMSDataDict06.pdf")

#Load the data
data<-read.csv("ss06hid.csv")

#Column Names
names(data)

#Applying strsplit() to split all the names of the data frame on the characters "wgtp"
split_names<-strsplit(names(data), "wgtp")

#Checking What is the value of the 123 element of the resulting list
result<-split_names[[123]]
print(result)
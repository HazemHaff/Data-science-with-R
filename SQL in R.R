install.packages("sqldf")
library(sqldf)

#download from https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
acs <- read.csv("C:/Users/hhaff/Downloads/getdata_data_ss06pid.csv")

sqldf("select pwgtp1 from acs where AGEP < 50")

sqldf("select distinct AGEP from acs")
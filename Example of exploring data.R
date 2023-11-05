library(readr)
library(dplyr)

#importing dataset
dpbr <- read.csv("C:/Users/hhaff/Downloads/fmkpMBhnRhOpKTAYZ2YTJA_9b70df6c74f240b982aafba5dc34fcf1_adm2020.csv")
head(dpbr)

#finding the value in row 1337 of Enrollment of Women column
row <- dpbr[1337,c('ENRLW')]
print(row)

#finding the Number o nulls in Admission columns for men and women, "OR" operation :
nulls <- sum(is.na(dpbr$ADMSSNM) | is.na(dpbr$ADMSSNW))
print (nulls)

#finding the average number of me who were admitted

average_men_admitted <- mean(dpbr$ADMSSNM, na.rm = TRUE)
print(average_men_admitted)
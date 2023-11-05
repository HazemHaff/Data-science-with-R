data<-read.csv("C:/Users/hhaff/Downloads/getdata_data_ss06hid.csv")

agricultureLogical<-(data$ACR==3) & (data$AGS==6)

rows<-which(agricultureLogical)

head(rows,3)

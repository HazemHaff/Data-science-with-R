library(dplyr)

#PUMS 2006
data<-read.csv("C:/Users/hhaff/Downloads/getdata_data_GDP.csv", skip = 4, header = TRUE)

#Checking Data
head(data)
names(data)
(str(data))

unique_gdp_values<-unique(data$X.4)
print(unique_gdp_values)
unique(gsub("[0-9]", "", data$X.4))


#Clean the GDP data - Remove commas, extra spaces, and all other non-numeric characters
#Trim leading and trailing spaces before replacing non-numeric characters
data$GDP_Clean<-as.numeric(gsub("[^0-9]", "", trimws(data$X.4)))

#Check for and handle NA values
if (any(is.na(data$GDP_Clean))) {
  warning("NA values were introduced during conversion. Check for non-numeric characters.")
  # Inspect the problematic rows
  na_rows<-which(is.na(data$GDP_Clean))
  print(data[na_rows, c("X.4", "GDP_Clean")])
}

#Filter out rows with invalid (NA) GDP data
valid_gdp_data<-data[!is.na(data$GDP_Clean), ]

#Recalculate the average GDP using the filtered and cleaned data
average_gdp<-mean(valid_gdp_data$GDP_Clean, na.rm = TRUE)

print(average_gdp)
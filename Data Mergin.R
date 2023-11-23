# Load necessary libraries
library(dplyr)

#Download data
urlgdp<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(urlgdp, destfile = "GDP.csv")
urledu<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(urledu, destfile = "EDSTATS_Country.csv")

#Load the GDP data
gdp_data<-read.csv("GDP.csv", stringsAsFactors = FALSE)

#Load the educational data
edu_data<-read.csv("EDSTATS_Country.csv", stringsAsFactors = FALSE)

# Check the data
colnames(gdp_data)
colnames(edu_data)

head(gdp_data)
head(edu_data)


#Merge the datasets based on the country shortcode
merged_data <- merge(gdp_data, edu_data, by.x = "X", by.y = "CountryCode", all = TRUE)

#Check the structure of the merged data
str(merged_data)

#Filter out rows where fiscal year information is available and ends in June
fiscal_year_june <- merged_data[grep("June", merged_data$Special.Notes, ignore.case = TRUE), ]

# Count the number of such countries
num_countries_june_fiscal <- nrow(fiscal_year_june)

print(num_countries_june_fiscal)
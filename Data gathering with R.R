install.packages("pdftools")
install.packages("readxl")
install.packages("xml2")
install.packages("httr")

library(xml2)
library(httr)
library(tidyverse)
library(readr)
library(pdftools)
library(readxl)

data <- read_csv("C:/Users/hhaff/Downloads/getdata_data_ss06hid.csv")
pdf_text <- pdf_text("C:/Users/hhaff/Downloads/getdata_data_PUMSDataDict06.pdf")

summary(data$VAL)
head(data$VAL)

count_value_24 <- function(data, column_name) sum(data[[column_name]] == 24, na.rm = TRUE)
count_result <- count_value_24(data, 'VAL')
print(paste("Number of properties worth more than $1 Million: ", count_result))

summary(data$FES)

dat <- read_xlsx("C:/Users/hhaff/Downloads/getdata_data_DATA.gov_NGAP.xlsx",range = "G18:O23")
      
head(dat)

sum(dat$Zip*dat$Ext,na.rm=T)

response <- GET("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml")
xml_data <- read_xml(content(response, "text"))

count <- xml_data %>% 
  xml_find_all("//row[zipcode='21231']") %>% 
  xml_length()
print(count)




library(dplyr)

gdp_data <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", skip = 4)
gdp_data <- gdp_data[, c("X", "X.4")]
colnames(gdp_data) <- c("CountryCode", "GDP")
gdp_data$GDP <- sapply(gdp_data$GDP, function(x) gsub(",", "", x))
head(gdp_data)

gdp_data <- gdp_data[gdp_data$GDP != "" & !is.na(gdp_data$GDP) & gdp_data$GDP != "..", ]
gdp_data$GDP <- as.numeric(gdp_data$GDP)

edu_data <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
edu_data <- edu_data[, c("CountryCode", "Long.Name")]
colnames(edu_data) <- c("CountryCode", "Country")


merged_data <- merge(edu_data, gdp_data, by = "CountryCode")

matched_ids <- nrow(merged_data)
cat("Number of matched IDs:", matched_ids, "\n")

sorted_data <- merged_data %>% arrange(desc(GDP))
thirteenth_country <- sorted_data$Country[13]
cat("The 13th country in the sorted data frame is:", thirteenth_country, "\n")
#You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE.

install.packages("quantmod")
library(quantmod)

#Download data for Amazon's stock price
amzn<-getSymbols("AMZN", auto.assign = FALSE, src = "yahoo")

#Get the dates when the data was sampled
sampleTimes<-index(amzn)

#Filter for entries from the year 2012
sampleTimes_2012<-sampleTimes[format(sampleTimes, "%Y") == "2012"]

#Count the total number of values in 2012
total_values_2012<-length(sampleTimes_2012)

#Identify and count the number of Mondays in 2012
mondays_2012<-sampleTimes_2012[weekdays(sampleTimes_2012) == "Monday"]
num_mondays_2012<-length(mondays_2012)

#Print the results
print(paste("Total values in 2012:", total_values_2012))
print(paste("Values on Mondays in 2012:", num_mondays_2012))
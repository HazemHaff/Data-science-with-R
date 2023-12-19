if (!require(data.table)) install.packages("data.table")
library(data.table)

setwd("C:/Users/hhaff/Downloads/Household data")

data <- fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", 
              colClasses = c("character", "character", "numeric", "numeric", "numeric", 
                             "numeric", "numeric", "numeric", "numeric"),
              nrows = -1)

#Convert the Date and Time variables to POSIXct datetime object
data[, DateTime := as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")]

#Subset the data to only include 2007-02-01 and 2007-02-02
data <- data[DateTime >= as.POSIXct("2007-02-01") & DateTime < as.POSIXct("2007-02-03")]

#Remove rows with missing values
data <- na.omit(data)

setwd("C:/Users/hhaff/Downloads/Household data/Plots")

#Plot 1
png("plot1.png", width=480, height=480)
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

#Plot 2
png("plot2.png", width=480, height=480)
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

#Plot 3
png("plot3.png", width=480, height=480)
with(data, {
  plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
  lines(DateTime, Sub_metering_1, type="l", col="black")
  lines(DateTime, Sub_metering_2, type="l", col="red")
  lines(DateTime, Sub_metering_3, type="l", col="blue")
  legend("topright", col=c("black", "red", "blue"), lty=1, 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.off()

#Plot 4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
with(data, {
  plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
  lines(DateTime, Sub_metering_1, type="l", col="black")
  lines(DateTime, Sub_metering_2, type="l", col="red")
  lines(DateTime, Sub_metering_3, type="l", col="blue")
})
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")
dev.off()

par(mfrow=c(1,1))
library(ggplot2)
library(dbplyr)

setwd("C:/Users/hhaff/Downloads/exdata_data_NEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Merge NEI and SCC
combined_data <- merge(NEI, SCC, by="SCC")

#Aggregate data by year
total_emissions <- aggregate(Emissions ~ year, NEI, sum)

#plot 1
# Using ggplot2 for a bar chart
png(filename = "plot1.png")
ggplot(total_emissions, aes(x=as.factor(year), y=Emissions)) + 
  geom_bar(stat="identity", fill="steelblue") +
  scale_y_continuous(labels = scales::comma) +
  labs(title="Total PM2.5 Emissions in the US (1999-2008)", 
       x="Year", y="Total Emissions (tons)")
dev.off()



#Plot2:

#Filter for Baltimore City
baltimore_data <- NEI[NEI$fips == "24510",]

#Aggregate data by year
baltimore_emissions <- aggregate(Emissions ~ year, baltimore_data, sum)

# Bar chart using ggplot2
png(filename = "plot2.png")
ggplot(baltimore_emissions, aes(x=as.factor(year), y=Emissions)) + 
  geom_bar(stat="identity", fill="steelblue") +
  scale_y_continuous(labels = scales::comma) +
  labs(title="Total PM2.5 Emissions in Baltimore City (1999-2008)", 
       x="Year", y="Total Emissions (tons)")
dev.off()





#Plot3:

#Aggregate data by year and type
baltimore_by_type <- aggregate(Emissions ~ year + type, baltimore_data, sum)

# ggplot2 with geom_bar
png(filename = "plot3.png")
ggplot(baltimore_by_type, aes(x=year, y=Emissions, fill=type)) + 
  geom_bar(stat="identity", position=position_dodge()) +
  scale_y_continuous(labels = scales::comma) +
  labs(title="PM2.5 Emissions by Source Type in Baltimore City (1999-2008)", 
       x="Year", y="Emissions (tons)")
dev.off()



#Plot4:

#Filter for coal combustion-related sources
coal_data <- combined_data[grep("Coal", combined_data$Short.Name, ignore.case = TRUE), ]

#Aggregate data by year
coal_emissions <- aggregate(Emissions ~ year, coal_data, sum)

# Bar chart using ggplot2
png(filename = "plot4.png")
ggplot(coal_emissions, aes(x=as.factor(year), y=Emissions)) + 
  geom_bar(stat="identity", fill="steelblue") +
  scale_y_continuous(labels = scales::comma) +
  labs(title="Emissions from Coal Combustion-Related Sources in the US (1999-2008)", 
       x="Year", y="Total Emissions (tons)")
dev.off()




#Plot5:

#Filter for motor vehicle sources in Baltimore
motor_vehicle_data <- combined_data[grep("Motor Vehicle", combined_data$Short.Name) & combined_data$fips == "24510", ]

#Aggregate data by year
motor_vehicle_emissions <- aggregate(Emissions ~ year, motor_vehicle_data, sum)

#ggplot2 with geom_bar
png(filename = "plot5.png")
ggplot(motor_vehicle_emissions, aes(x=as.factor(year), y=Emissions)) + 
  geom_bar(stat="identity", fill="steelblue") +
  scale_y_continuous(labels = scales::comma) +
  labs(title="Emissions from Motor Vehicle Sources in Baltimore City (1999-2008)", 
       x="Year", y="Emissions (tons)")
dev.off()



#plot6:

#Filter for motor vehicle sources in Los Angeles
la_data <- combined_data[grep("Motor Vehicle", combined_data$Short.Name) & combined_data$fips == "06037", ]

#Aggregate data by year for both cities
baltimore_mv_emissions <- aggregate(Emissions ~ year, motor_vehicle_data, sum)
la_mv_emissions <- aggregate(Emissions ~ year, la_data, sum)

#Merge data for comparison
comparison_data <- merge(baltimore_mv_emissions, la_mv_emissions, by="year", suffixes=c("_Baltimore", "_LA"))

# Bar chart using ggplot2 for comparison
png(filename = "plot6.png")
ggplot(comparison_data, aes(x=year)) + 
  geom_bar(aes(y=Emissions_Baltimore, fill="Baltimore"), stat="identity", position=position_dodge()) +
  geom_bar(aes(y=Emissions_LA, fill="Los Angeles"), stat="identity", position=position_dodge()) +
  scale_y_continuous(labels = scales::comma) +
  labs(title="Motor Vehicle Emissions Comparison: Baltimore City vs. Los Angeles County (1999-2008)", 
       x="Year", y="Emissions (tons)")
dev.off()
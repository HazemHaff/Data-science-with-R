# Load necessary libraries
library(forecast)
library(lubridate)

# Read in the dataset
dat <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv")

# Preprocess the data: Create training and testing sets based on the year
training <- dat[year(dat$date) < 2012,]
testing <- dat[year(dat$date) > 2011,]

# Convert the training data into a time series object
tstrain <- ts(training$visitsTumblr)

# Fit a BATS model to the training time series
fit <- bats(tstrain)

# Forecast using the fitted BATS model for the required number of time points
forecasts <- forecast(fit, h=length(testing))

# Ensure that 'testing$visitsTumblr' is not a time series object
testing$visitsTumblr <- as.numeric(testing$visitsTumblr)

# Forecast using the fitted BATS model for the number of points in the testing set
h <- length(testing$visitsTumblr)
forecasts <- forecast(fit, h=h)

# Check lengths
print(length(forecasts$lower[, "95%"]))
print(length(testing$visitsTumblr))


# Calculate the percentage of testing points where the true value is within the 95% prediction interval
within_bounds <- (testing$visitsTumblr >= forecasts$lower[,2]) & (testing$visitsTumblr <= forecasts$upper[,2])
percentage_within_bounds <- sum(within_bounds) / length(testing$visitsTumblr)

# Print the percentage
print(percentage_within_bounds)
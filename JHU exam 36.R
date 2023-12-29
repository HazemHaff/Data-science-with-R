# Load the mtcars dataset
data(mtcars)

# Fit the linear regression model
model <- lm(mpg ~ wt, data=mtcars)

# Question 3: Get a 95% confidence interval for the expected mpg at the average weight
average_weight <- mean(mtcars$wt)
conf_int <- predict(model, newdata=data.frame(wt=average_weight), interval="confidence", level=0.95)

# The lower endpoint of the confidence interval
lower_endpoint <- conf_int[,"lwr"]

# Question 5: Get a 95% prediction interval for a new car weighing 3000 pounds (which is 3 in 1000s lbs)
pred_int <- predict(model, newdata=data.frame(wt=3), interval="prediction", level=0.95)

# The upper endpoint of the prediction interval
upper_endpoint <- pred_int[,"upr"]

# Print the lower and upper endpoints
print(lower_endpoint)
print(upper_endpoint)


# Fit the linear regression model
model <- lm(mpg ~ wt, data=mtcars)

# Get the summary of the model to look at the coefficients
summary_model <- summary(model)

# The coefficient of 'wt' is the amount by which 'mpg' is expected to decrease
# for each additional 1,000 lbs (or 1 unit in the 'wt' variable of the mtcars dataset) of car weight.
weight_coefficient <- summary_model$coefficients["wt", "Estimate"]

# Print the weight coefficient
print(weight_coefficient)

# Calculate the 95% confidence interval for the slope coefficient
conf_int_slope <- confint(model, level=0.95)["wt", ]

# Since a short ton is 2,000 lbs, which is equivalent to 2 units of 'wt' in the mtcars dataset,
# we multiply the confidence interval by 2 to get the interval for a 1 short ton increase in weight.
conf_int_short_ton <- conf_int_slope * 2

# Print the confidence interval for a 1 short ton increase in weight
print(conf_int_short_ton)

# Fit the model with intercept only
model_intercept_only <- lm(mpg ~ 1, data=mtcars)

# Fit the model with both intercept and slope
model_full <- lm(mpg ~ wt, data=mtcars)

# Calculate the sum of squared errors for both models
sse_intercept_only <- sum(resid(model_intercept_only)^2)
sse_full <- sum(resid(model_full)^2)

# Calculate the ratio
sse_ratio <- sse_intercept_only / sse_full

# Print the SSE results
print(sse_full)
print(sse_intercept_only)
print(sse_ratio)
# Load the MASS package
library(MASS)

# Load the shuttle dataset from MASS
data(shuttle)

# Fit logistic regression model for autolander use ('auto') as predicted by wind sign
model <- glm(use ~ wind, family = binomial, data = shuttle)

# Calculate odds ratio for head winds compared to tail winds
# Note: You'll need to reference the levels of 'use' correctly, based on the model summary
summary(model)
# The name of the coefficient for tail wind as per the summary is 'windtail'
# To get the odds ratio for head winds compared to tail winds, we take the inverse
odds_ratio <- exp(-coef(model)['windtail'])
odds_ratio





# Fit logistic regression model with an additional variable for wind strength
model_adjusted <- glm(use ~ wind + magn, family = binomial, data = shuttle)

# View the summary to check for the correct coefficient names
summary(model_adjusted)

# Assuming the summary shows the correct name for the head wind coefficient
# Replace 'windhead' with the actual coefficient name from the summary if necessary
# If the coefficient for head wind is the baseline and thus not shown, we would use the coefficient for tail wind as follows
adjusted_odds_ratio <- exp(-coef(model_adjusted)['windtail']) # If 'windtail' is the coefficient for tail wind
adjusted_odds_ratio







# Convert the factor levels of 'use' to 0 and 1
# Assuming the first level (e.g., 'auto') is the 'positive' outcome and should be 1
shuttle$use_numeric <- ifelse(shuttle$use == levels(shuttle$use)[1], 1, 0)

# Fit logistic regression model to the inverted outcome
model_complement <- glm(I(1 - use_numeric) ~ wind, family = binomial, data = shuttle)

# View the summary of the model
summary(model_complement)

# Extracting the coefficients
coef_complement <- coef(model_complement)
coef_complement

# Load the datasets package
library(datasets)
# Load the InsectSprays dataset
data(InsectSprays)
# Check the levels of the spray variable
levels(InsectSprays$spray)
# Fit a Poisson model using spray as a factor level
model_poisson <- glm(count ~ spray, family = poisson, data = InsectSprays)
# View the summary of the model to check the coefficients
summary(model_poisson)
# Calculate the relative rate of spray A compared to spray B
relative_rate_A_to_B <- exp(-coef(model_poisson)['sprayB'])
relative_rate_A_to_B


# Fit Poisson model with an offset
model_offset <- glm(count ~ temperature + offset(exposure_time), family = poisson, data = insect_data)

# Coefficient estimate for temperature
coef_estimate <- coef(model_offset)['temperature']

# Fit Poisson model with a modified offset (e.g., log(10) + exposure_time)
model_offset_modified <- glm(count ~ temperature + offset(log(10) + exposure_time), family = poisson, data = insect_data)

# Coefficient estimate for temperature with the modified offset
coef_estimate_modified <- coef(model_offset_modified)['temperature']

# Compare the two coefficients
coef_estimate
coef_estimate_modified

# Example data (replace with your actual data)
x <- c(-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5)  # Predictor
y <- c(5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5)        # Response
knot_value <- 0                                # Knot point

# Create the new variable for the knot
x_knot <- pmax(0, x - knot_value)

# Fit the linear model with the knot
model <- lm(y ~ x + x_knot)

# Summary of the model to get coefficients
summary(model)
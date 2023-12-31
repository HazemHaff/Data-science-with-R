# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load the mtcars dataset
data(mtcars)

# Modify the 'am' column to a factor for clarity in plots and models
mtcars$am <- factor(mtcars$am, labels = c("Automatic", "Manual"))

# Exploratory Data Analysis (EDA)
# Boxplot of MPG by Transmission Type
ggplot(mtcars, aes(x = am, y = mpg)) + 
  geom_boxplot() +
  labs(x = "Transmission Type", y = "Miles Per Gallon") +
  theme_minimal()

# Model Fitting
# Simple model with transmission type
simple_model <- lm(mpg ~ am, data = mtcars)

# More complex model adjusting for other variables
complex_model <- lm(mpg ~ am + wt + hp + qsec, data = mtcars)

# Compare models using AIC and BIC
aic_values <- AIC(simple_model, complex_model)[1, "AIC"]
bic_values <- BIC(simple_model, complex_model)[1, "BIC"]

# Choose the model with the lowest AIC or BIC
chosen_model <- if(aic_values < bic_values) simple_model else complex_model

# Coefficient Interpretation
# Interpret the coefficient for transmission type
coef_summary <- summary(chosen_model)$coefficients

# Print the coefficient summary
print(coef_summary)

# Quantify MPG Difference
# Calculate the MPG difference between transmission types
mpg_difference <- coef(chosen_model)["amManual"]

# Residual Diagnostics
# Check residuals to ensure model assumptions are met
par(mfrow = c(2, 2))
plot(chosen_model)

# Uncertainty Quantification and Inference
# Use confidence intervals to quantify the uncertainty around the MPG difference
mpg_diff_confint <- confint(chosen_model, "amManual")

# Print results to the console
cat("AIC Comparison:\n", aic_values, "\n\n")
cat("BIC Comparison:\n", bic_values, "\n\n")
cat("Coefficient for Manual Transmission:\n", mpg_difference, "\n\n")
cat("95% Confidence Interval for MPG Difference:\n", mpg_diff_confint, "\n\n")

# Reset par to default
par(mfrow = c(1, 1))
# Load necessary libraries
library(caret)
library(randomForest)
library(gbm)
library(ElemStatLearn)

# Load the data
data(vowel.train)
data(vowel.test)

# Convert 'y' to a factor in both datasets
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

# Set the seed
set.seed(33833)

# Train control setup for consistent method application
train_control <- trainControl(method = "none")  # No resampling

# Fit a Random Forest model
rf_fit <- train(y ~ ., data = vowel.train, method = "rf", trControl = train_control)

# Fit a GBM model
gbm_fit <- train(y ~ ., data = vowel.train, method = "gbm", trControl = train_control, verbose = FALSE)

# Predictions on the test set
rf_pred <- predict(rf_fit, vowel.test)
gbm_pred <- predict(gbm_fit, vowel.test)

# Calculate accuracies
rf_accuracy <- sum(rf_pred == vowel.test$y) / nrow(vowel.test)
gbm_accuracy <- sum(gbm_pred == vowel.test$y) / nrow(vowel.test)

# Calculate agreement accuracy
agree <- rf_pred == gbm_pred
agree_accuracy <- sum(agree & (rf_pred == vowel.test$y)) / sum(agree)

# Print the accuracies
print(paste("RF Accuracy =", round(rf_accuracy, 4)))
print(paste("GBM Accuracy =", round(gbm_accuracy, 4)))
print(paste("Agreement Accuracy =", round(agree_accuracy, 4)))
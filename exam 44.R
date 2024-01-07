library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
library(randomForest)
library(dplyr)
library(psych)
library(ggplot2)
library(caret)

# Load the data
data(vowel.train)
data(vowel.test)

# Convert 'y' to a factor in both datasets
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

# Set the seed
set.seed(33833)

# Fit a random forest model
rf_model <- randomForest(y ~ ., data = vowel.train)

# Calculate variable importance
importance <- varImp(rf_model, scale = FALSE)

# Print the order of variable importance
importance
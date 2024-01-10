library(caret)
library(randomForest)
library(gbm)
library(MASS)

alzheimerData <- read.csv("C:/Users/hhaff/Downloads/ad_data.csv")

# View the first few rows of the dataset
head(alzheimerData)

# Convert 'Class' to a factor (assuming 'Class' is the target variable)
alzheimerData$Class <- as.factor(alzheimerData$Class)

# Remove the 'Genotype' variable from the dataset
alzheimerData <- alzheimerData[, !names(alzheimerData) %in% "Genotype"]

# Partition the data into training and testing sets
set.seed(3433)
inTrain <- createDataPartition(alzheimerData$Class, p = 3/4)[[1]]
training <- alzheimerData[inTrain, ]
testing <- alzheimerData[-inTrain, ]

# Set the seed for model training
set.seed(62433)

# Fit Random Forest model
rf_model <- train(Class ~ ., data = training, method = "rf")

# Fit GBM model
gbm_model <- train(Class ~ ., data = training, method = "gbm", verbose = FALSE)

# Fit LDA model
lda_model <- train(Class ~ ., data = training, method = "lda")

# Make predictions on the test set with each model
rf_pred <- predict(rf_model, testing)
gbm_pred <- predict(gbm_model, testing)
lda_pred <- predict(lda_model, testing)

# Combine the predictions with the actual class labels
combined_data_for_stacking <- cbind(combined_pred, Class = testing$Class)

# Train a new RF model on the combined predictions
stacked_rf_model <- train(Class ~ ., data = combined_data_for_stacking, method = "rf")

# Predict on the test set using the stacked model
stacked_pred <- predict(stacked_rf_model, combined_pred)

# Calculate stacked model accuracy
stacked_accuracy <- sum(stacked_pred == testing$Class) / length(testing$Class)

# Print the stacked accuracy
print(paste("Stacked Accuracy:", round(stacked_accuracy, 2)))

# Calculate individual model accuracies
rf_accuracy <- sum(rf_pred == testing$Class) / length(testing$Class)
gbm_accuracy <- sum(gbm_pred == testing$Class) / length(testing$Class)
lda_accuracy <- sum(lda_pred == testing$Class) / length(testing$Class)

# Print individual accuracies
print(paste("RF Accuracy:", round(rf_accuracy, 2)))
print(paste("GBM Accuracy:", round(gbm_accuracy, 2)))
print(paste("LDA Accuracy:", round(lda_accuracy, 2)))
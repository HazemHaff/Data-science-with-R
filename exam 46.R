library(caret)
library(randomForest)
library(gbm)
library(MASS)

# Load the data
data(AlzheimerDisease)
adData <- data.frame(diagnosis, predictors)
set.seed(3433)
inTrain <- createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training <- adData[inTrain, ]
testing <- adData[-inTrain, ]

# Set the seed
set.seed(62433)

# Fit individual models
rf_model <- train(diagnosis ~ ., data = training, method = "rf")
gbm_model <- train(diagnosis ~ ., data = training, method = "gbm", verbose = FALSE)
lda_model <- train(diagnosis ~ ., data = training, method = "lda")

# Predictions on the test set
rf_pred <- predict(rf_model, testing)
gbm_pred <- predict(gbm_model, testing)
lda_pred <- predict(lda_model, testing)

# Combine predictions for stacking
combined_pred <- data.frame(rf_pred, gbm_pred, lda_pred)

# Train a new RF model on the combined predictions
stacked_rf_model <- randomForest(diagnosis ~ ., data = cbind(testing[,1, drop=FALSE], combined_pred))

# Predict on the test set using the stacked model
stacked_pred <- predict(stacked_rf_model, cbind(testing[,1, drop=FALSE], combined_pred))

# Calculate stacked model accuracy
stacked_accuracy <- sum(stacked_pred == testing$diagnosis) / nrow(testing)

# Print the accuracy
print(paste("Stacked Accuracy:", round(stacked_accuracy, 2)))
# Set the seed for reproducibility
set.seed(325)

# Load necessary libraries
library(AppliedPredictiveModeling)
library(e1071)

# Load the concrete dataset
data(concrete)

# Partition the data
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[inTrain, ]
testing = concrete[-inTrain, ]

# Fit the SVM model using default settings
svmModel <- svm(CompressiveStrength ~ ., data = training)

# Predict on the testing set
predictions <- predict(svmModel, testing)

# Calculate the RMSE
rmse <- sqrt(mean((predictions - testing$CompressiveStrength)^2))

# Print the RMSE
print(rmse)
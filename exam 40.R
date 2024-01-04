library(AppliedPredictiveModeling)
data(concrete)
library(caret)
library(psych)
library(forecast)

set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

names(concrete)
describe(concrete)
describe(mixtures)
describe(testing)
describe(training)

# Load necessary libraries
library(ggplot2)
library(Hmisc)
library(dplyr)

data(concrete)

# Convert continuous variables into categorical factors using cut2
concrete_factorized <- concrete %>%
  mutate(across(.cols = -CompressiveStrength, .fns = ~ cut2(., g = 5)))

# Add an explicit index column for plotting
concrete_factorized <- concrete_factorized %>% 
  mutate(Index = row_number())

# Plot CompressiveStrength against index, colored by each variable
plot_list <- list()
for (var in colnames(concrete_factorized)[-which(colnames(concrete_factorized) == "CompressiveStrength")]) {
  p <- ggplot(concrete_factorized, aes(x = Index, y = CompressiveStrength, color = !!sym(var))) +
    geom_point() +
    theme_minimal() +
    ggtitle(paste("Compressive Strength vs Index - Colored by", var))
  plot_list[[var]] <- p
}

# Display the plots
plot_list

# Find an optimal lambda for the Box-Cox transformation
lambda <- BoxCox.lambda(concrete$Superplasticizer, lower = 0)

# Apply the Box-Cox transformation
concrete$SuperplasticizerBoxCox <- BoxCox(concrete$Superplasticizer, lambda)

# Create histogram for the transformed variable
ggplot(concrete, aes(x = SuperplasticizerBoxCox)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  theme_minimal() +
  ggtitle("Histogram of Box-Cox Transformed Superplasticizer")



library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis, predictors)
# Create partitions
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
# Split the data into training and testing sets
training = adData[inTrain, ]
testing = adData[-inTrain, ]
# Step 1: Identify variables starting with 'IL'
il_vars <- grep("^IL", names(training), value = TRUE)
# Step 2: Perform PCA on these variables
preproc <- preProcess(training[, il_vars], method = "pca", thresh = 0.8)
# Step 3: Calculate the number of principal components
num_components <- sum(preproc$rotation^2) # this gives us the eigenvalues
cum_variance <- cumsum(num_components) / sum(num_components)
num_needed <- which(cum_variance >= 0.8)[1]
# Print the number of principal components needed to capture 80% of the variance
num_needed




library(caret)

# Subset the training and testing sets to include only IL predictors and diagnosis
il_vars <- grep("^IL", names(training), value = TRUE)
training_subset <- training[, c(il_vars, "diagnosis")]
testing_subset <- testing[, c(il_vars, "diagnosis")]

# Perform PCA on the training predictors
preproc <- preProcess(training_subset[, il_vars], method = "pca", thresh = 0.8)
training_pca <- predict(preproc, training_subset[, il_vars])

# Train a GLM using original predictors
set.seed(3433) # For reproducibility
glm_fit_original <- train(diagnosis ~ ., data = training_subset, method = "glm", trControl = trainControl(method = "none"))
predictions_original <- predict(glm_fit_original, testing_subset)
accuracy_original <- postResample(predictions_original, testing_subset$diagnosis)

# Train a GLM using principal components
training_pca$diagnosis <- training_subset$diagnosis # Add diagnosis to the PCA-transformed data
glm_fit_pca <- train(diagnosis ~ ., data = training_pca, method = "glm", trControl = trainControl(method = "none"))
testing_pca <- predict(preproc, testing_subset[, il_vars])
testing_pca$diagnosis <- testing_subset$diagnosis # Add diagnosis to the PCA-transformed testing data
predictions_pca <- predict(glm_fit_pca, testing_pca)
accuracy_pca <- postResample(predictions_pca, testing_pca$diagnosis)

# Compare accuracies
accuracy_original
accuracy_pca

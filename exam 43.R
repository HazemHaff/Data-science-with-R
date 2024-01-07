# Install ElemStatLearn from the CRAN archive
packageurl <- "https://cran.r-project.org/src/contrib/Archive/ElemStatLearn/ElemStatLearn_2012.04-0.tar.gz"
install.packages(packageurl, repos=NULL, type="source")

# Load necessary library and data
library(ElemStatLearn)
data(SAheart)

# Create training and test sets
set.seed(8484)
train = sample(1:dim(SAheart)[1], size=dim(SAheart)[1]/2, replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

# Fit logistic regression model
set.seed(13234)
fit <- glm(chd ~ age + alcohol + obesity + tobacco + typea + ldl, 
           family=binomial, data=trainSA)

# Prediction function
missClass = function(values, prediction) {
  sum(((prediction > 0.5) * 1) != values) / length(values)
}

# Predictions on training set
prediction_train <- predict(fit, newdata=trainSA, type="response")
misclass_rate_train <- missClass(trainSA$chd, prediction_train)

# Predictions on test set
prediction_test <- predict(fit, newdata=testSA, type="response")
misclass_rate_test <- missClass(testSA$chd, prediction_test)

# Print the misclassification rates
print(paste("Training Set Misclassification:", misclass_rate_train))
print(paste("Test Set Misclassification:", misclass_rate_test))
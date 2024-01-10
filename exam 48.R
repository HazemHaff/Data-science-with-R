set.seed(3523)
library(AppliedPredictiveModeling)
install.packages("D:/download/glmnet_4.1-8.tar.gz", repos = NULL, type = "source")
library(glmnet)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(233)
# Prepare the data for glmnet (requires matrix format)
x = as.matrix(training[, -which(names(training) == "CompressiveStrength")])
y = training$CompressiveStrength
# Fit the Lasso model
lassoModel = glmnet(x, y, alpha = 1)
# Plot the coefficient paths
plot(lassoModel, xvar = "lambda", label = TRUE)
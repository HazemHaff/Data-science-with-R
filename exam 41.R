library(AppliedPredictiveModeling)
library(caret)
data(segmentationOriginal)

trainData <- subset(segmentationOriginal, Case == "Train")
testData <- subset(segmentationOriginal, Case == "Test")

set.seed(125)
fit <- train(Class ~ ., data = trainData, method = "rpart")

# Create a template for prediction
prediction_template <- trainData[1,]

# Case a
prediction_a <- prediction_template
prediction_a$TotalIntenCh2 <- 23000
prediction_a$FiberWidthCh1 <- 10
prediction_a$PerimStatusCh1 <- 2

# Case b
prediction_b <- prediction_template
prediction_b$TotalIntenCh2 <- 50000
prediction_b$FiberWidthCh1 <- 10
prediction_b$VarIntenCh4 <- 100

# Case c
prediction_c <- prediction_template
prediction_c$TotalIntenCh2 <- 57000
prediction_c$FiberWidthCh1 <- 8
prediction_c$VarIntenCh4 <- 100

# Case d
prediction_d <- prediction_template
prediction_d$FiberWidthCh1 <- 8
prediction_d$VarIntenCh4 <- 100
prediction_d$PerimStatusCh1 <- 2

prediction_result_a <- predict(fit, newdata = prediction_a)
prediction_result_b <- predict(fit, newdata = prediction_b)
prediction_result_c <- predict(fit, newdata = prediction_c)
prediction_result_d <- predict(fit, newdata = prediction_d)

print(prediction_result_a)
print(prediction_result_b)
print(prediction_result_c)
print(prediction_result_d)
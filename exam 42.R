# Load necessary libraries
library(tree)
library(pgmm)

# Load the olive dataset
data(olive)
olive <- olive[,-1] # Excluding the first column as instructed

# Convert 'Area' to a factor if it's not already
olive$Area <- as.factor(olive$Area)

# Fit a classification tree
olive_tree <- tree(Area ~ ., data = olive)

# Create a new data frame for prediction
# Taking the column means of the olive dataset excluding 'Area'
olive_without_area <- olive[, sapply(olive, is.numeric)]
newdata <- as.data.frame(t(colMeans(olive_without_area)))

# Predict the value of 'Area' for the new data frame
prediction <- predict(olive_tree, newdata)

# Print the resulting prediction
print(prediction)
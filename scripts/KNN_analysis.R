library(class)
library(caret)
data <- data.frame(t(log2count.table))
data$class <- disease.types
nbPackages <- 10
flds <- createFolds(disease.types, k = 10, list = TRUE, returnTrain = FALSE)
errorRateList <- list(10)
for(i in 1:10){
  test <- data[flds[[i]],]
  train <- data[-flds[[i]],]
  prediction <- knn(train[,-ncol(train)], test[,-ncol(test)], train$class)
  errorRate <- sum(prediction != test$class) / nrow(test)
  errorRateList[i] <- errorRate
}
somme <- 0
for(elements in errorRateList)
{
  somme <- somme + elements
}
errorRateMean <- somme/10


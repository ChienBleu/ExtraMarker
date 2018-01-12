#Script for K-FOLD crossvalidation
#
library(caret)
data <- data.frame(t(log.count.table))
data$class <- disease.types
nbPackages <- 10
flds <- createFolds(disease.types, k = 10, list = TRUE, returnTrain = FALSE)

for(i in 1:10){
  test <- data[flds[[i]],]
  train <- data[-flds[[i]],]
}
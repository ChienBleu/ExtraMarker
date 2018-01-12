library(class)
set.seed(2)
data <- data.frame(t(log.count.table))
data$class <- disease.types

training.sample <- sample(seq_len(nrow(data)), nrow(data) * 0.66)
training.data <- data[training.sample,]
test.data <- data[-training.sample,]
predictions <- knn(training.data[,-ncol(training.data)], test.data[,-ncol(test.data)], training.data$class)
error.rate <- sum(predictions != test.data$class) / nrow(test.data)


new.table <- count.table[sample(nrow(count.table)),]
new.table <- rbind(new.table, disease.types)
train.df <- new.table[,1:as.integer(0.7*61)]
trainlabels <- data.frame(colnames(train.df))
trainlabels <- cbind(trainlabels, train.df[58038,])
test.df <- new.table[,as.integer(0.7*61 +1):61]
"knn.val <- summary(knn(train.df, test.df, cl = disease.types, k=3))"

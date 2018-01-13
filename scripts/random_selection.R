library(MASS)
library(caret)
library(randomForest)

n.samples <- length(phenotypes)

# Creation of the data frame
all.data <- data.frame(t(log2(counts(dds.norm, normalized=TRUE) + 1)))

# Test without feature selection
mean.error.rates <- c()
var.error.rates <- c()
gene.number <- 2
for(i in 1:5){
  error <- c()
  print(gene.number)
  for(j in 1:30){
    print(j)
    # randomly select 10000 genes
    reduce.data <- all.data[, sample(colnames(all.data), gene.number)]
    reduce.data$class <- phenotypes
    # Partition of training and testing set
    training.samples <- sample(seq_len(n.samples), size = n.samples * 0.66)
    train <- reduce.data[training.samples, ]
    test <- reduce.data[-training.samples, ]
    
    # Test with 15000 columns randomly selected
    model <- randomForest(class ~ ., train)
    predictions <- predict(model, test[,-ncol(test)])
  
    error <- c(error, sum(predictions != test$class)/ n.samples)
  }
  gene.number <- gene.number * 2
  mean.error.rates <- c(mean.error.rates, mean(error))
  var.error.rates <- c(var.error.rates, var(error))
}

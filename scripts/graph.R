library(affy)
# Creating a bar plot representing all the reads per sample
col.diseases <- c("Colorectal Cancer"="green", "Prostate Cancer"="orange", "Pancreatic Cancer" = "blue", "Healthy Control" = "black")
colors <- col.diseases[as.vector(selected$disease)]
barplot(rowSums(count.table)/1000000, 
        main="Total number of reads per sample (million)",
        col=colors, 
        #        names.arg = "", 
        las=1,  horiz=TRUE,
        ylab="Samples", cex.names=0.5,
        xlab="Million counts")
# Creating an histogram of counts per gene
epsilon <- 1
hist(as.matrix(log2(count.table + epsilon)), col="blue", border="white",
     main="Log2-transformed counts per gene", xlab="log2(counts+1)", ylab="Number of genes", 
     las=1, cex.axis=0.7, ylim = c(0,80000))

par(mfrow = c(1,3))
hist(as.matrix(log2(sCC + epsilon)), col=col.diseases["Colorectal Cancer"], border="white",
     main="Log2-transformed counts per gene", xlab="log2(counts+1)", ylab="Number of genes", 
     las=1, cex.axis=0.7, ylim = c(0,300000))
hist(as.matrix(log2(sPC + epsilon)), col=col.diseases["Prostate Cancer"], border="white",
     main="Log2-transformed counts per gene", xlab="log2(counts+1)", ylab="Number of genes", 
     las=1, cex.axis=0.7, ylim = c(0,300000))
hist(as.matrix(log2(sHC + epsilon)), col=col.diseases["Healthy Control"], border="white",
     main="Log2-transformed counts per gene", xlab="log2(counts+1)", ylab="Number of genes", 
     las=1, cex.axis=0.7, ylim = c(0,300000))

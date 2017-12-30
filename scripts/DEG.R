library(affy)
# Reducing the data set
count.table <- data.frame(t(assay(rse)))
count.table$disease <- disease.types
sCC <- count.table[count.table$disease == "Colorectal Cancer",]
sPC <- count.table[count.table$disease == "Prostate Cancer",]
sHC <- count.table[count.table$disease == "Healthy Control",]
selected <- sCC[sample(nrow(sCC), 20), ]
selected <- rbind(selected, sPC[sample(nrow(sPC), 20), ])
selected <- rbind(selected, sHC[sample(nrow(sHC), 20), ])
count.table <- as.matrix(selected[,-58038])
count.table <- count.table[,colSums(count.table) > 0]
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
     las=1, cex.axis=0.7, ylim = c(0,500000))
# Get a boxplot off the data
boxplot(log2(count.table + epsilon), col=colors, pch=".", 
        horizontal=TRUE, cex.axis=0.5,
        las=1, ylab="Samples", xlab="log2(Counts +1)")
# Get a density plot off the data
plotDensity(log2(count.table + epsilon), lty=1, col=colors, lwd=2)
grid()
legend("topright", legend=names(col.strain), col=col.strain, lwd=2)

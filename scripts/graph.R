# Creating a bar plot representing all the reads per sample
col.diseases <- c("Control"="cadetblue", "BD"="tomato")
colors <- col.diseases[as.vector(disease.types)]
barplot(colSums(count.table)/1000000, 
        main="Total number of reads per sample (million)",
        col=colors,
        border = "white",
        #        names.arg = "", 
        las=1,  horiz=TRUE,
        ylab="Samples", cex.names=0.5,
        xlab="Million counts")
# Creating an histogram of counts per gene
hist(as.matrix(log.count.table), col="slategray", border="white",
     main="Log2-transformed counts per gene", xlab="log2(counts+1)", ylab="Number of genes", 
     las=1, cex.axis=0.7)
## Boxplots
boxplot(log.count.table, col=colors, pch=".", 
        horizontal=TRUE, cex.axis=0.5,
        las=1, ylab="Samples", xlab="log2(Counts +1)")
#density plot
library(affy)
plotDensity(log2(count.table + epsilon), lty=1, col=colors, lwd=2)

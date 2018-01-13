colData <- data.frame(colnames(count.table))
colData <- cbind(colData, phenotypes)
colnames(colData) <- c("Sample", "Phenotype")
colnames(count.table) <- NULL
dds <- DESeqDataSetFromMatrix(countData = count.table, colData = colData, design = ~ Phenotype)
rm(colData)
dds.norm <-  estimateSizeFactors(dds)
sizeFactors(dds.norm)
## Checking the normalization
par(mfrow=c(2,2),cex.lab=0.7)
boxplot(log2(counts(dds.norm)+epsilon),  col=colors, cex.axis=0.7, 
        las=1, xlab="log2(counts)", horizontal=TRUE, main="Raw counts")
boxplot(log2(counts(dds.norm, normalized=TRUE)+epsilon),  col=colors, cex.axis=0.7, 
        las=1, xlab="log2(normalized counts)", horizontal=TRUE, main="Normalized counts") 
plotDensity(log2(counts(dds.norm)+epsilon),  col=colors, 
            xlab="log2(counts)", cex.lab=0.7, panel.first=grid()) 
plotDensity(log2(counts(dds.norm, normalized=TRUE)+epsilon), col=colors, 
            xlab="log2(normalized counts)", cex.lab=0.7, panel.first=grid()) 
par(mfrow=c(1,1),cex.lab=1)
## Computing mean and variance
norm.counts <- counts(dds.norm, normalized=TRUE)
mean.counts <- rowMeans(norm.counts)
variance.counts <- apply(norm.counts, 1, var)
## Mean and variance relationship
mean.var.col <- densCols(x=log2(mean.counts), y=log2(variance.counts))
plot(x=log2(mean.counts), y=log2(variance.counts), pch=16, cex=0.5, 
     col=mean.var.col, main="Mean-variance relationship",
     xlab="Mean log2(normalized counts) per gene",
     ylab="Variance of log2(normalized counts)",
     panel.first = grid())
abline(a=0, b=1, col="brown")
## Performing estimation of dispersion parameter
dds.disp <- estimateDispersions(dds.norm)

## A diagnostic plot which
## shows the mean of normalized counts (x axis)
## and dispersion estimate for each genes
plotDispEsts(dds.disp)
#pvalues
alpha <- 0.0001
wald.test <- nbinomWaldTest(dds.disp)
res.DESeq2 <- results(wald.test, alpha=alpha, pAdjustMethod="BH")
res.DESeq2 <- res.DESeq2[order(res.DESeq2$padj),]
head(res.DESeq2)
## Draw an histogram of the p-values
hist(res.DESeq2$padj, breaks=20, col="grey", main="DESeq2 p-value distribution", xlab="DESeq2 P-value", ylab="Number of genes")
#volcano  plot
alpha <- 0.01 # Threshold on the adjusted p-value
cols <- densCols(res.DESeq2$log2FoldChange, -log10(res.DESeq2$pvalue))
plot(res.DESeq2$log2FoldChange, -log10(res.DESeq2$padj), col=cols, panel.first=grid(),
     main="Volcano plot", xlab="Effect size: log2(fold-change)", ylab="-log10(adjusted p-value)",
     pch=20, cex=0.6)
abline(v=0)
abline(v=c(-1,1), col="brown")
abline(h=-log10(alpha), col="brown")

gn.selected <- abs(res.DESeq2$log2FoldChange) > 2 & res.DESeq2$padj < alpha 
text(res.DESeq2$log2FoldChange[gn.selected],
     -log10(res.DESeq2$padj)[gn.selected],
     lab=rownames(res.DESeq2)[gn.selected ], cex=0.4)
## Draw a MA plot.
## Genes with adjusted p-values below 1% are shown
plotMA(res.DESeq2, colNonSig = "blue")
abline(h=c(-1:1), col="red")

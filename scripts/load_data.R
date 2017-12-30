library(recount)
library(DESeq2)
project.id <- 'SRP061240'
# Downloading the files
if(!file.exists(file.path(project.id, 'rse_gene.Rdata'))){
  print("Downloading the study file.")
  download_study(project.id)
}
if(!file.exists(file.path(project.id, 'counts_gene.tsv.gz'))){
  print("Downloading the gene expressions file.")
  download_study(project.id, "counts-gene")
}
# Load the rse data
load(file.path(project.id, 'rse_gene.Rdata'))
geochar <- lapply(split(colData(rse_gene), seq_len(nrow(colData(rse_gene)))), recount::geo_characteristics)
# Get the phenotypes of interest
disease.types <- unlist(as.factor(unlist(lapply(geochar, "[", 4))))
# Create the DESeq2 object
rse <- scale_counts(rse_gene)
count.table <- data.frame(t(assay(rse)))
rm(rse)
rm(geochar)
rm(rse_gene)
# Reducing the data set
count.table$disease <- disease.types
sCC <- count.table[count.table$disease == "Colorectal Cancer",]
sPC <- count.table[count.table$disease == "Prostate Cancer",]
sHC <- count.table[count.table$disease == "Healthy Control",]
selected <- sCC[sample(nrow(sCC), 20), ]
selected <- rbind(selected, sPC[sample(nrow(sPC), 20), ])
selected <- rbind(selected, sHC[sample(nrow(sHC), 20), ])
count.table <- as.matrix(selected[,-58038])
sCC <- as.matrix(sCC[,-58038])
sPC <- as.matrix(sPC[,-58038])
sHC <- as.matrix(sHC[,-58038])
disease.types <- selected$disease
rm(selected)
# Log the data
epsilon <- 1
log.count.table <- log2(count.table + epsilon)

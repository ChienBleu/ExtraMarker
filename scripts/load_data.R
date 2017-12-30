library(recount)
library(DESeq2)
project.id <- 'SRP033725'
# Downloading the files
if(!file.exists(file.path(project.id, 'rse_gene.Rdata'))){
  print("Downloading the study file.")
  download_study(project.id)
}
# Load the rse data
load(file.path(project.id, 'rse_gene.Rdata'))
geochar <- lapply(split(colData(rse_gene), seq_len(nrow(colData(rse_gene)))), recount::geo_characteristics)
# Get the phenotypes of interest
disease.types <- unlist(as.factor(unlist(lapply(geochar, "[", 2))))
# Create the DESeq2 object
rse <- scale_counts(rse_gene)
count.table <- as.matrix(assay(rse))
rm(rse)
rm(geochar)
rm(rse_gene)
# Log the data
epsilon <- 1
log.count.table <- log2(count.table + epsilon)

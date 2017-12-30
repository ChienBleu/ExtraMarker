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
colData(rse)$group <- disease.types
dds <- DESeqDataSet(rse, ~ group)
vsd <- vst(dds)

project.id <- 'SRP061240'
if(!file.exists(file.path(project.id, 'rse_gene.Rdata'))){
  print("Downloading the study file.")
  recount::download_study(project.id)
}
if(!file.exists(file.path(project.id, 'counts_gene.tsv.gz'))){
  print("Downloading the gene expressions file.")
  recount::download_study(project.id, "counts-gene")
}
print("Loading the  rse")
load(file.path(project.id, 'rse_gene.Rdata'))
geochar <- lapply(split(colData(rse_gene), seq_len(nrow(colData(rse_gene)))), recount::geo_characteristics)
disease.types <- unlist(as.factor(unlist(lapply(geochar, "[", 4))))
rse <- scale_counts(rse_gene)
colData(rse)$group <- disease.types
dds <- DESeqDataSet(rse, ~ group)
rld <- rlog(dds)

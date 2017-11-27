project.id <- 'SRP061240'
if(!file.exists(file.path(project.id, 'rse_gene.Rdata'))){
  print("Downloading the study file.")
  recount::download_study(project.id)
}
if(!file.exists(file.path(project.id, 'counts_gene.tsv.gz'))){
  print("Downloading the gene expressions file.")
  recount::download_study(project.id, "counts-gene")
}
print("Loading the  phenotypes.")
load(file.path(project.id, 'rse_gene.Rdata'))
geochar <- lapply(split(colData(rse_gene), seq_len(nrow(colData(rse_gene)))), recount::geo_characteristics)
rm(rse_gene)
disease.types <- lapply(geochar, "[", 4)
rm(geochar)
print("Loading the gene expressions")
count.table <- read.table(file = file.path(project.id, "counts_gene.tsv.gz"), sep = "\t", header = TRUE)
rm(project.id)


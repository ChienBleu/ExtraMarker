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
sCC <- as.matrix(sCC[,-58038])
sPC <- as.matrix(sPC[,-58038])
sHC <- as.matrix(sHC[,-58038])
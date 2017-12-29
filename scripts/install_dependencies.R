source("https://bioconductor.org/biocLite.R")
if(!require("recount")){
  biocLite("recount")
  
}
if(!require("DESeq2")){
  biocLite("DESeq2")
}

library(DESeq2)

  
source("https://bioconductor.org/biocLite.R")
if(!require("recount")){
  biocLite("recount")
}
if(!require("DESeq2")){
  biocLite("DESeq2")
}
if(!require("affy")){
  biocLite("affy")
}
if(!require("caret")){
  install.packages("caret")
}



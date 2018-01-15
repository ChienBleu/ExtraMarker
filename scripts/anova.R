pvals <- c()
for(i in 1:ncol(all.data)){
  print(i)
  g <- i ## Select an arbitrary gene
  ## Build a data frame with gene expression values in the first column, 
  ## and sample labels in the second column.
  g.expr <- all.data[,g]
  g.for.anova <- data.frame("expr"=g.expr, "group"=phenotypes)
  ## We thus try the indirect approach: fit a linear model and run anova on it.
  g.anova.result <- anova(lm(formula = expr ~ group, data = g.for.anova))
  pval <- as.numeric(unlist(g.anova.result)["Pr(>F)1"])
  pvals <- c(pvals, pval)
}

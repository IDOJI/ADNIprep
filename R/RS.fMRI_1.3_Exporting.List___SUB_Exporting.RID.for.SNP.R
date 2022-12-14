RS.fMRI_1.3_Exporting.List___SUB_Exporting.RID.for.SNP = function(data.df, path, filename){
  RID = data.df$RID
  keep = sapply(RID, FUN=function(y){
    return(paste("0", y, sep="\t"))
  })

  write.table(keep %>% as.data.frame, file=paste(path, paste0(filename,".txt"), sep="/"), row.names = F, col.names = F, quote=F)
  text1 = crayon::blue("Writing")
  text2 = crayon::red("keep RID for SNP")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3,"\n")
}

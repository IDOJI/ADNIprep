RS.fMRI_3.3.Generate.SliceOrderInfo.tsv = function(manu_path){
  is.philips = length(grep(pattern = "Philips", x = manu_path, ignore.case = T))
  if(is.philips==1){
    manu_path = manu_path %>% path_tail_slash()
    path_FunRaw= paste0(manu_path, "FunRaw")
    sub_list = list.files(path_FunRaw)
    type = rep("IA", length(sub_list))
    SliceOrderInfo = cbind("Subject ID" = sub_list, "Slice Order Type" = type)
    write.table(SliceOrderInfo, paste(path, paste("SliceOrderInfo", "tsv", sep="."), sep=""), row.names=F, quote=F, sep="\t")
    cat("\n", crayon::blue("SliceOrderInfo.tsv is created !"), "\n")
  }else{
    cat("\n", crayon::blue("The manufacture is not Philips. No need to create SliceOrderInfo.tsv."), "\n")
  }
}

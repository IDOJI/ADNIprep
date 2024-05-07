Generate.Slice.Timing.Information = function(path_ADNI.Unzipped.Folders="E:/ADNI/ADNI_RS.fMRI___SB/Error/ADNI"){
  #=============================================================================
  # sub folders path
  #=============================================================================
  Sub_Folders = list.files(path_ADNI.Unzipped.Folders, pattern="Philips")
  path_Sub_Folders = list.files(path_ADNI.Unzipped.Folders, pattern="Philips", full.names=T)




  #=============================================================================
  # Extract Sub
  #=============================================================================
  Extracted_Sub = sapply(Sub_Folders, function(y){
    strsplit(y,split = "___")[[1]][2]
  })
  names(Extracted_Sub) = NULL


  #=============================================================================
  # Generate tsv files
  #=============================================================================
  Results = lapply(seq_along(path_Sub_Folders), function(i){
    SliceOrderInfo = cbind("Subject ID" = Extracted_Sub[i], "Slice Order Type" = "IA")
    write.table(SliceOrderInfo, file.path(path_Sub_Folders[i], "SliceOrderInfo.tsv"), row.names=F, quote=F, sep="\t")
    cat("\n", crayon::yellow("Generating"), crayon::red("SliceOrderInfo.tsv"), crayon::yellow("is done : "), crayon::bgRed(Extracted_Sub[i]) ,"\n")
  })
  cat("\n", crayon::blue("Generating"), crayon::bgRed("SliceOrderInfo.tsv"), crayon::blue("is done!"), "\n")
}

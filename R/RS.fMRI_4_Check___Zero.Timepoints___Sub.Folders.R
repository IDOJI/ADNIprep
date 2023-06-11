RS.fMRI_4_Check___Zero.Timepoints___Sub.Folders = function(path_Sub.Folders, ROI_Signals_Folder){
  path_Folders = list.files(path_Sub.Folders, full.names=T)

  Results  = sapply(path_Folders, function(y){
    cat("\n",  crayon::red(basename(y)),"\n")
    RS.fMRI_4_Check___Zero.Timepoints(path_Preprocessed = y, ROI_Signals_Folder)
  }) %>% unlist %>% unname
  return(Results)
}

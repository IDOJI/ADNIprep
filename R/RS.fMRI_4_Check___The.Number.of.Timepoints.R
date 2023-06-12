RS.fMRI_4_Check___The.Number.of.Timepoints = function(path_Sub.Folders, ROI_Signals_Folder = "ROISignals_FunImgARCWSF"){
  #=============================================================================
  # Sub folders list
  #=============================================================================
  path_Sub_Folders = fs::dir_ls(path_Sub.Folders, type = "dir")



  #=============================================================================
  # Results path
  #=============================================================================
  path_ROI_BOLD_Signals = sapply(path_Sub_Folders, function(y, ...){
    path_ROI_Folder = paste0(list.files(y, pattern="Results", full.names=T), "/", ROI_Signals_Folder)
    path_ROI_BOLD_Signals = list.files(path_ROI_Folder, pattern = "ROISignals_Sub_", full.names=T) %>% filter_by(include = "\\.txt")
    return(path_ROI_BOLD_Signals)
  }) %>% unlist %>% unname



  #=============================================================================
  # n_timepoints for each BOLD signals
  #=============================================================================
  n_timepoints = sapply(path_ROI_BOLD_Signals, function(x){read.table(x) %>% nrow}) %>% unlist %>% unname

  return(list(path_Sub = path_Sub_Folders, n_timepoints = n_timepoints))
}

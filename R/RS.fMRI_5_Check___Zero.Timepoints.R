RS.fMRI_5_Check___Zero.Timepoints = function(path_Preprocessed){
  # path_Preprocessed = Clipboard_to_path()
  #=============================================================================
  # list.files
  #=============================================================================
  path_Results = paste0(path_Preprocessed, "/Results")
  path_ROI_Signals = list.files(path_Results, pattern = "ROISignals", full.names=T)
  path_ROI_Signals_Sub = list.files(path_ROI_Signals, pattern="ROISignals_Sub_", full.names=T) %>% filter_by(include="\\.txt", any_include = T, exact_include = F)



  #=============================================================================
  # Check zeros
  #=============================================================================
  which_path_have_zeros = sapply(path_ROI_Signals_Sub, function(y){
    ith_ROI_Signals_Mean = read.table(y) %>% apply(1, mean) %>% filter_by(include = 0, any_include = T, exact_include = T)
    if(length(ith_ROI_Signals_Mean)>0){
      y
    }
  }) %>% rm_list_null()

  if(length(which_path_have_zeros)==0){
    cat("\n", crayon::blue("Congratulations! There is no all zero timepoints!"), "\n")
  }else{
    cat("\n", crayon::red("There are all zero timepoints!"), "\n")
    return(which_path_have_zeros)
  }
}

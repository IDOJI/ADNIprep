RS.fMRI_4_Check___Zero.Timepoints = function(path_Preprocessed, ROI_Signals_Folder = "ROISignals_FunImgARCWSF"){
  # path_Preprocessed = Clipboard_to_path()
  #=============================================================================
  # path ROI signals
  #=============================================================================
  path_ROI_Signals = paste(path_Preprocessed, "Results", ROI_Signals_Folder, sep="/")
  path_ROI_Signals_Sub = list.files(path_ROI_Signals, pattern="ROISignals_Sub_", full.names=T) %>% filter_by(include = "\\.txt")
  ROI_Signals.mat = read.table(path_ROI_Signals_Sub)



  #=============================================================================
  # Check zeros
  #=============================================================================
  is_all_zero_timepoints = apply(ROI_Signals.mat, 1, function(y){
    sum(y == 0)==length(y)/3
  })



  if(sum(is_all_zero_timepoints)>0){
    cat("\n", crayon::red("There are all zero timepoints! Check the path of result!"), "\n")
    return(path_Preprocessed)
  }else{
    cat("\n", crayon::blue("Congratulations! There is no all zero timepoints!"), "\n")
  }
}

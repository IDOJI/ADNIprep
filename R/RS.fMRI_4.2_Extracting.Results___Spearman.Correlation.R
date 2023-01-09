RS.fMRI_4.2_Extracting.Results___Spearman.Correlation = function(ROI_Signals.list){
  Spearman_Corr.list = ROI_Signals.list
  for(i in 1:length(ROI_Signals.list)){
    # i=1
    ith_folder_ROISignals = ROI_Signals.list[[i]]
    Spearman_Corr.list[[i]] = lapply(ith_folder_ROISignals, FUN=function(jth_ROISignals){
      # jth_ROISignals = ith_folder_ROISignals[[1]]
      cor(jth_ROISignals, method = "spearman")
    })
  }
  return(Spearman_Corr.list)
}

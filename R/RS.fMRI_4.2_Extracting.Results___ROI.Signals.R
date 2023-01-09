RS.fMRI_4.2_Extracting.Results___ROI.Signals = function(path_ROISignals){
  folders = names(path_ROISignals)
  index = 1:length(path_ROISignals) %>% as.character


  ROISignals.list = lapply(index, FUN=function(ith_index, ...){
    # ith_index = index[1]
    ith_results_folder = path_ROISignals[[as.numeric(ith_index)]]
    ith_ROISignals_files = filter_by(list.files(ith_results_folder), including.words = c("ROISignals_Sub", "\\.txt"))
    ith_ROISignals_path = paste0(ith_results_folder, ith_ROISignals_files)

    ith_ROISignals.list = lapply(ith_ROISignals_path, FUN=function(kth_ROISignals_path, ...){
      # kth_ROISignals_path = ith_ROISignals_path[1]
      kth_ROISignals = read.table(kth_ROISignals_path)
      names(kth_ROISignals) = paste0("ROI_", fit_length(1:ncol(kth_ROISignals), 3))
      return(kth_ROISignals)
    })
    names(ith_ROISignals.list) = RS.fMRI_4.2_Extracting.Results___Extract.Sub.Names(ith_ROISignals_files)
    return(ith_ROISignals.list)
  })
  names(ROISignals.list) = folders
  return(ROISignals.list)
}

RS.fMRI_4.2_Extracting.Results___Pearson.Correlation.FisherZ = function(path_ROISignals){
  folders = names(path_ROISignals)
  index = 1:length(path_ROISignals) %>% as.character


  Corr.list = lapply(index, FUN=function(ith_index, ...){
    # ith_index = index[1]
    ith_results_folder = path_ROISignals[[as.numeric(ith_index)]]
    ith_Corr_files = filter_by(list.files(ith_results_folder), including.words = c("FisherZ", "Correlation", "\\.txt"))
    ith_Corr_path = paste0(ith_results_folder, ith_Corr_files)

    ith_Corr.list = lapply(ith_Corr_path, FUN=function(kth_Corr_path, ...){
      # kth_Corr_path = ith_Corr_path[1]
      kth_Corr = read.table(kth_Corr_path) %>% as.matrix
      colnames(kth_Corr) = paste0("ROI_", fit_length(1:ncol(kth_Corr), 3))
      rownames(kth_Corr) = paste0("ROI_", fit_length(1:ncol(kth_Corr), 3))
      return(kth_Corr)
    })
    names(ith_Corr.list) = RS.fMRI_4.2_Extracting.Results___Extract.Sub.Names(ith_Corr_files)
    return(ith_Corr.list)
  })
  names(Corr.list) = folders
  return(Corr.list)
}

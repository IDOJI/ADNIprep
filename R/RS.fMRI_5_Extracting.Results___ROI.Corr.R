RS.fMRI_4.2_Extracting.Results___ROI.Corr___Loading.Files = function(path_files){
  loaded_ROICorr = lapply(path_files, FUN=function(path_ith_file){
    ith_file = read.table(path_ith_file, header = F) %>% as.matrix
    colnames(ith_file) = paste0("ROI_", fit_length(1:ncol(ith_file), nchar(ncol(ith_file))))
    rownames(ith_file) = paste0("ROI_", fit_length(1:ncol(ith_file), nchar(ncol(ith_file))))
    return(ith_file)
  })
  return(loaded_ROICorr)
}

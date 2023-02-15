RS.fMRI_4.2_Extracting.Results___ROI.Signals___Exclude.Zero.Signals = function(combined_ROISignals.list){
  data_0.list = list()
  data_1.list = list()
  
  have_zeros = list()
  
  
  for(i in 1:length(combined_ROISignals.list)){
    have_zeros[[i]] = lapply(combined_ROISignals.list[[i]], FUN=function(ijth_signals){
      # ijth_signals = combined_ROISignals.list[[1]][[11]]
    is.zero = apply(ijth_signals %>% as.data.frame, MARGIN=2, FUN=function(ijkth_col){
        sum(ijkth_col==0)==length(ijkth_col)
      }) %>% sum %>% as.logical
      if(is.zero){
        return(FALSE)
      }else{
        return(TRUE)
      }
    }) %>% unlist
  }
  
  
  for(k in 1:length(have_zeros)){
    # k = 1
    data_1.list[[k]] = combined_ROISignals.list[[k]][have_zeros[[k]]]
    data_0.list[[k]] = combined_ROISignals.list[[k]][!have_zeros[[k]]]
  }

  names(data_1.list) = names(combined_ROISignals.list)
  names(data_0.list) = names(combined_ROISignals.list)
  return(list(non_zero = data_1.list, having_zero = data_0.list))
}

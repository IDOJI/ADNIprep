RS.fMRI_4.2_Extracting.Results___ROI.Signals___Extract.Each.ROI.Signals = function(data.list){
  n_ROI = data.list[[1]][[2]] %>% ncol

  Each_ROI.list = list()
  for(r in 1:n_ROI){
    Each_ROI.list[[r]] = lapply(data.list, FUN=function(ith_Subject, ...){
      ith_Subject[[2]][,r]
    })
  }
  names(Each_ROI.list) = paste0("ROI_", fit_length(1:n_ROI, 3))
  return(Each_ROI.list)
}

RS.fMRI_4.2_Extracting.Results___ROI.Signals___Combining.by.Data.Frame.for.Each.ROI = function(ROI_Signals){
  # ROI_Signals = Extracted.list[[1]]
  combined_ROI_Signals = lapply(ROI_Signals, FUN=function(ith_ROI){
    # ith_ROI = ROI_Signals[[1]]
    combined.df = do.call(cbind, ith_ROI) %>% as.data.frame
    return(combined.df)
  })
  return(combined_ROI_Signals)
}

RS.fMRI_5_Functional.Connectivity___Dynamic___Extract.Timeseries = function(Corr_Mat.list){
  #=========================================================================
  # Brain Region Combinations
  #=========================================================================
  Brain_Regions = colnames(Corr_Mat.list[[1]])

  Brain_Regions_Rep.list = lapply(Brain_Regions, function(jth_Region, ...){
    paste(Brain_Regions, rep(jth_Region, length(Brain_Regions)), sep = "___")
  })

  Brain_Regions.mat = do.call(cbind, Brain_Regions_Rep.list) %>% as.matrix
  Brain_Regions_Upper = Brain_Regions.mat[upper.tri(Brain_Regions.mat, diag=F)]





  #=========================================================================
  # Extracting Upper Triangular Elements
  #=========================================================================
  Extracted.list = lapply(Corr_Mat.list, function(kth_Cor.mat){
    kth_Cor.mat[upper.tri(kth_Cor.mat, diag = FALSE)]
  })
  Extracted_Timeseries.df = do.call(rbind, Extracted.list)
  colnames(Extracted_Timeseries.df) = Brain_Regions_Upper

  # Comparision
  # test = sapply(Corr_Mat.list, function(y){
  #   y[1,2]
  # })
  return(Extracted_Timeseries.df)
}

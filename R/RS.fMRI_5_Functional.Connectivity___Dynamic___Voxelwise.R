RS.fMRI_5_Functional.Connectivity___Dynamic___Voxelwise = function(path_BOLD.Signals, path_Export){
  path_BOLD.Signals = list.files(path_BOLD.Signals, full.names = T)

  # Extract coordinates & Brain Region
  BOLD.Signals = readRDS(path_BOLD.Signals[1])
  colnames_TimeSeries = colnames(BOLD.Signals[[1]])
  Brain.Regions = names(BOLD.Signals)
  rownames_Brain.Regions = lapply(seq_along(X), function(k, ...){
    kth_BOLD.Signals = BOLD.Signals[[k]]
    kth_Brain.Region = rep(Brain.Regions[k], nrow(kth_BOLD.Signals))
    paste0(kth_Brain.Region, "___", rownames(kth_BOLD.Signals))
  }) %>% unlist


  # Exporting
  Results = lapply(path_BOLD.Signals, function(y, ...){
    ith_BOLD.df = do.call(rbind, readRDS(y))
    rownames(ith_BOLD.df) = rownames_Brain.Regions
    colnames(ith_BOLD.df) = colnames_TimeSeries



  })
}

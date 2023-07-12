RS.fMRI_5_BOLD.Signals___FDA___Combining.by.ROI = function(Data.list, path_Export=NULL, Pipeline){
  n_ROI = Data.list[[1]] %>% ncol

  Combined.list = lapply(1:n_ROI, function(k, ...){
    kth_ROI = lapply(Data.list, function(ith_Data, ...){
      ith_Data[,k]
    })

    kth_Combined.df = do.call(cbind, kth_ROI) %>% as.data.frame()
    return(kth_Combined.df)
  })
  names(Combined.list) = colnames(Data.list[[1]])

  if(!is.null(path_Export)){
    saveRDS(Combined.list, paste0(path_Export, "/", "BOLD.Signals___ROI___AAL3___", Pipeline,"___Z.Standardization___Cut.for.FDA___Combined.rds"))
    cat("\n", crayon::yellow("Exporting RDS file is done!") ,"\n")
  }
  return(Combined.list)
}

RS.fMRI_5_BOLD.Signals___FDA___Combining.by.ROI = function(path_Data, path_Export=NULL, file.name=NULL){
  if(!is.null(path_Export)){
    dir.create(path_Export, showWarnings = F)
  }

  RID = list.files(path_Data) %>% str_extract("RID_\\d+")


  Data.list = lapply(list.files(path_Data, full.names=T), function(y){
    readRDS(y)
  })

  n_ROI = Data.list[[1]] %>% ncol


  Combined.list = lapply(1:n_ROI, function(k, ...){
    kth_ROI = lapply(Data.list, function(ith_Data, ...){
      ith_Data[,k]
    })

    kth_Combined.df = do.call(cbind, kth_ROI) %>% as.data.frame()
    colnames(kth_Combined.df) = RID

    return(kth_Combined.df)
  })
  names(Combined.list) = colnames(Data.list[[1]])


  if(!is.null(path_Export)){
    saveRDS(Combined.list, paste0(path_Export, "/", file.name, ".rds"))

    cat("\n", crayon::yellow("Exporting RDS file is done!") ,"\n")
  }
  return(Combined.list)
}

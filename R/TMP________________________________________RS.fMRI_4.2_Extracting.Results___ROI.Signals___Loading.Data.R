RS.fMRI_4.2_Extracting.Results___ROI.Signals___Loading.Data = function(path_ROI, Signals_txt_files){
  if(length(Signals_txt_files)==0){
    return(NULL)
  }else{
    path_Signals_files = paste0(path_ROI, "/", Signals_txt_files)

    Data.list = lapply(path_Signals_files, FUN=function(path_kth_Signals){
      # path_kth_Signals = path_Signals_files[1]
      kth_data = data.table::fread(path_kth_Signals) %>% as.data.frame()
      names(kth_data) = paste0("ROI_", 1:ncol(kth_data) %>% fit_length(3))
      which_na = which(apply(kth_data, 2, is.na) %>% colSums() > 0)
      return(kth_data[,-which_na])
    })

    names(Data.list) = substr(Signals_txt_files, 12, 18)


    return(Data.list)
  }
}

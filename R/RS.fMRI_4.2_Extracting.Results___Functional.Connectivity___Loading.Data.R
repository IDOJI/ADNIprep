RS.fMRI_4.2_Extracting.Results___Functional.Connectivity___Loading.Data = function(path_ROI, FisherZ_txt_files){
  if(length(FisherZ_txt_files)==0){
    return(NULL)
  }else{
    path_FisherZ_files = paste0(path_ROI, "/", FisherZ_txt_files)
    
    Data.list = lapply(path_FisherZ_files, FUN=function(path_kth_FisherZ){
      # path_kth_FisherZ = path_FisherZ_files[1]
      kth_data = data.table::fread(path_kth_FisherZ) %>% as.matrix
      colnames(kth_data) = paste0("ROI_", 1:ncol(kth_data) %>% fit_length(3))
      rownames(kth_data) = paste0("ROI_", 1:nrow(kth_data) %>% fit_length(3))
      which_na = which(apply(kth_data, 2, is.na) %>% colSums() > 0)
      if(length(which_na)>0){
        return(kth_data[,-which_na])
      }else{
        return(kth_data)
      }
    })
    names(Data.list) = substr(FisherZ_txt_files, 24, 30)
    return(Data.list)
  }
}

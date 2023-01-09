RS.fMRI_4.2_Extracting.Results___Functional.Connectivity = function(Excluding_List_with_Path.list, save.path=NULL){
  Each_Folders_Path = names(Excluding_List_with_Path.list)

  FC_of_Each_Folders.list = lapply(Each_Folders_Path, FUN=function(x, ...){
    #x = Each_Folders_Path[12]
    ind = which(Each_Folders_Path == x)
    path_ROI = paste0(x, "/", "Results/ROISignals_FunImgARCWSF")

    Corr_txt_files = filter_by(list.files(path_ROI, pattern = "ROICorrelation_"), including.words = "txt", excluding.words = c(Excluding_List_with_Path.list[[ind]], "Fisher")) # Exclude bad subjects
    Corr_Data.list = RS.fMRI_4.2_Extracting.Results___Functional.Connectivity___Loading.Data(path_ROI, Corr_txt_files)

    FisherZ_txt_files = filter_by(list.files(path_ROI, pattern = "FisherZ_"), including.words = "txt", excluding.words = Excluding_List_with_Path.list[[ind]]) # Exclude bad subjects
    FisherZ_Data.list = RS.fMRI_4.2_Extracting.Results___Functional.Connectivity___Loading.Data(path_ROI, FisherZ_txt_files)

    if(is.null(Corr_Data.list)){
      Combined_Corr.list = NULL
    }else{
      Combined_Corr.list = list()
      for(k in 1:length(FisherZ_txt_files)){
        Combined_Corr.list[[k]] = c(Corr_Data.list[k], FisherZ_Data.list[k])
        names(Combined_Corr.list)[k] = names(Corr_Data.list)[k]
        names(Combined_Corr.list[[k]]) = c("Corr.mat", "Corr_FisherZ.mat")
      }
    }

    return(Combined_Corr.list)
  })
  names(FC_of_Each_Folders.list) = RS.fMRI_4.0_SUB___Folders.Path.Extractor(Each_Folders_Path)
  ADNI___RS.fMRI___Functional.Connectivity = RS.fMRI_4.0_SUB___Combining.by.Scanner.Manufacturer(FC_of_Each_Folders.list)


  if(!is.null(save.path)){
    setwd(save.path)
    usethis::use_data(ADNI___RS.fMRI___Functional.Connectivity, overwrite = T)
    cat("\n", crayon::yellow("Functional Connectivity"), crayon::blue("are saved !"), "\n")
  }

  return(ADNI___RS.fMRI___Functional.Connectivity)
}

RS.fMRI_4.2_Extracting.Results___Functional.Connectivity = function(Excluding_List_with_Path.list, save.path=NULL){
  Each_Folders_Path = names(Excluding_List_with_Path.list)

  FC_of_Each_Folders.list = lapply(Each_Folders_Path, FUN=function(x, ...){
    # x= Each_Folders_Path[2]
    ind = which(Each_Folders_Path == x)
    path_ROI = paste0(x, "/", "Results/ROISignals_FunImgARCWSF")
    FisherZ_txt_files = filter_by(list.files(path_ROI, pattern = "FisherZ_"), including.words = "txt", excluding.words = Excluding_List_with_Path.list[[ind]]) # Exclude bad subjects
    Data.list = RS.fMRI_4.2_Extracting.Results___Functional.Connectivity___Loading.Data(path_ROI, FisherZ_txt_files)
    return(Data.list)
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

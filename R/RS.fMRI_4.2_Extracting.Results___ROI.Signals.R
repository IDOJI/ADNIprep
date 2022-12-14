RS.fMRI_4.2_Extracting.Results___ROI.Signals = function(Excluding_List_with_Path.list, save.path=NULL){
  Each_Folders_Path = names(Excluding_List_with_Path.list)

  Signals_of_Each_Folders.list = lapply(Each_Folders_Path, FUN=function(x, ...){
    ind = which(Each_Folders_Path == x)
    path_ROI = paste0(x, "/", "Results/ROISignals_FunImgARCWSF")
    Signals_txt_files = filter_by(list.files(path_ROI, pattern = "ROISignals_"), including.words = "txt", excluding.words = Excluding_List_with_Path.list[[ind]]) # Exclude bad subjects
    Data.list = RS.fMRI_4.2_Extracting.Results___ROI.Signals___Loading.Data(path_ROI, Signals_txt_files)
    return(Data.list)
  })
  names(Signals_of_Each_Folders.list) = RS.fMRI_4.0_SUB___Folders.Path.Extractor(Each_Folders_Path)
  ADNI___RS.fMRI___ROI.Signals = RS.fMRI_4.0_SUB___Combining.by.Scanner.Manufacturer(Signals_of_Each_Folders.list)


  if(!is.null(save.path)){
    setwd(save.path)
    usethis::use_data(ADNI___RS.fMRI___ROI.Signals, overwrite = T)
    cat("\n", crayon::yellow("ROI Signals"), crayon::blue("are saved !"), "\n")
  }

  return(ADNI___RS.fMRI___ROI.Signals)
}

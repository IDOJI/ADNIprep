RS.fMRI_4.2_Extracting.Results = function(path_Results, path_Norm.Pictures, atlas="AAL116"){
  ##############################################################################
  # path & save list
  ##############################################################################
  Extracted_Data.list = list()
  path_Results.ROISignals = lapply(path_Results, FUN=function(ith_path_Results){
    list.files(ith_path_Results, pattern = glob2rx(paste0("*", "ROISignals", "*", atlas, "*")), full.names = T)
  })



  ##############################################################################
  # Norm pictures filenames
  ##############################################################################
  files_Norm.Pictures = lapply(path_Norm.Pictures, FUN=function(ith_path_Norm.Pictures){
    ith_Norm.Pictures = list.files(ith_path_Norm.Pictures, pattern="\\.tif$")
    ith_Norm.Pictures = sub("\\..*$", "", basename(ith_Norm.Pictures))
    return(ith_Norm.Pictures)
  })



  ##############################################################################
  # 1) ROI Signals
  ##############################################################################
  Extracted_Data.list[[1]] = RS.fMRI_4.2_Extracting.Results___ROI.Signals(path_Results.ROISignals, files_Norm.Pictures)
  names(Extracted_Data.list)[1] = "ROI_Signals"
  cat("\n", crayon::red("Step 4.2.1."), crayon::blue("Extracting"), crayon::yellow("ROI Signals"), crayon::blue("is done !!") ,"\n")


  ##############################################################################
  # 2) Pearson Correlation
  ##############################################################################
  Extracted_Data.list[[2]] = RS.fMRI_4.2_Extracting.Results___Pearson.Correlation(path_Results.ROISignals, files_Norm.Pictures, FisherZ = F)
  names(Extracted_Data.list)[2] = "Pearson_Correlation"
  cat("\n", crayon::red("Step 4.2.2."), crayon::blue("Extracting"), crayon::yellow("Pearson Correlation"), crayon::blue("is done !!") ,"\n")



  ##############################################################################
  # 3) Pearson Correlation FisherZ
  ##############################################################################
  Extracted_Data.list[[3]] = RS.fMRI_4.2_Extracting.Results___Pearson.Correlation(path_Results.ROISignals, files_Norm.Pictures, FisherZ = T)
  names(Extracted_Data.list)[3] = "Pearson_Correlation_FisherZ"
  cat("\n", crayon::red("Step 4.2.3."), crayon::blue("Extracting"), crayon::yellow("FisherZ Pearson Correlation"), crayon::blue("is done !!") ,"\n")



  # ############################################################################
  # # 4) Spearman Correlation
  # ############################################################################
  # Extracted_Data.list[[4]] = Spearman_Corr.list = RS.fMRI_4.2_Extracting.Results___Spearman.Correlation(ROI_Signals.list)
  # names(Extracted_Data.list)[4] = "Spearman Correlation"
  # cat("\n", crayon::red("Step 4.2.3."), crayon::blue("Extracting"), crayon::yellow("Spearman Correlation"), crayon::blue("is done !!") ,"\n")



  ############################################################################
  # 5) returning data
  ############################################################################
  return(Extracted_Data.list)
}



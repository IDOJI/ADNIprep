RS.fMRI_4.2_Extracting.Results = function(path_Results){
  Extracted_Data.list = list()
  ############################################################################
  # path
  ############################################################################
  path_ROISignals = lapply(path_Results %>% path_tail_slash, FUN=function(ith_Results_path){
    list.files(ith_Results_path, full.names = T, pattern = "ROISignals_") %>% path_tail_slash %>% return
  })



  ############################################################################
  # 1) ROI Signals
  ############################################################################
  Extracted_Data.list[[1]] = ROI_Signals.list = RS.fMRI_4.2_Extracting.Results___ROI.Signals(path_ROISignals)
  names(Extracted_Data.list)[1] = "ROI Signals"
  cat("\n", crayon::red("Step 4.2.1."), crayon::blue("Extracting"), crayon::yellow("ROI Signals"), crayon::blue("is done !!") ,"\n")


  ############################################################################
  # 2) Pearson Correlation
  ############################################################################
  Extracted_Data.list[[2]] =Pearson_Corr.list = RS.fMRI_4.2_Extracting.Results___Pearson.Correlation(path_ROISignals)
  names(Extracted_Data.list)[2] = "Pearson Correlation"
  cat("\n", crayon::red("Step 4.2.2."), crayon::blue("Extracting"), crayon::yellow("Pearson Correlation"), crayon::blue("is done !!") ,"\n")



  ############################################################################
  # 3) Pearson Correlation FisherZ
  ############################################################################
  Extracted_Data.list[[3]] = FisherZ_Pearson_Corr.list = RS.fMRI_4.2_Extracting.Results___Pearson.Correlation.FisherZ(path_ROISignals)
  names(Extracted_Data.list)[3] = "FisherZ Pearson Correlation"
  cat("\n", crayon::red("Step 4.2.3."), crayon::blue("Extracting"), crayon::yellow("FisherZ Pearson Correlation"), crayon::blue("is done !!") ,"\n")



  ############################################################################
  # 4) Spearman Correlation
  ############################################################################
  Extracted_Data.list[[4]] = Spearman_Corr.list = RS.fMRI_4.2_Extracting.Results___Spearman.Correlation(ROI_Signals.list)
  names(Extracted_Data.list)[4] = "Spearman Correlation"
  cat("\n", crayon::red("Step 4.2.3."), crayon::blue("Extracting"), crayon::yellow("Spearman Correlation"), crayon::blue("is done !!") ,"\n")



  ############################################################################
  # 5) returning data
  ############################################################################
  return(Extracted_Data.list)
}



RS.fMRI_4.2_Extracting.Results___Pearson.Correlation = function(Extracted_ROI.Signals, path_Results.ROISignals, files_Norm.Pictures, FisherZ=F){
  ##############################################################################
  ### Files' path list
  ##############################################################################
  if(FisherZ){
    path_ROICorr.list = lapply(path_Results.ROISignals, FUN=function(ith_path_Results.ROISignals){
      list.files(ith_path_Results.ROISignals, pattern=glob2rx("*ROICorrelation_FisherZ_Sub*txt*"), full.names = T)
    })
  }else{
    path_ROICorr.list = lapply(path_Results.ROISignals, FUN=function(ith_path_Results.ROISignals){
      list.files(ith_path_Results.ROISignals, pattern=glob2rx("*ROICorrelation_Sub*txt*"), full.names = T)
    })
  }



  ##############################################################################
  ### Loading files
  ##############################################################################
  ROICorr.list = lapply(path_ROICorr.list, FUN=function(path_ith_ROICorr){
    # path_ith_ROICorr = path_ROICorr.list[[1]]
    ith_Loaded.ROICorr = RS.fMRI_4.2_Extracting.Results___ROI.Corr___Loading.Files(path_ith_ROICorr)
  })



  ##############################################################################
  ### Adding Sub names
  ##############################################################################
  for(i in 1:length(ROICorr.list)){
    names(ROICorr.list[[i]]) = files_Norm.Pictures[[i]]
  }


  ##############################################################################
  ### Combining by Manufacturers
  ##############################################################################
  combined_ROICorr.list = RS.fMRI_4.0_SUB___Combining.by.Scanner.Manufacturer(ROICorr.list)



  ##############################################################################
  ### Ordering by "Sub"
  ##############################################################################
  Ordered_by_Sub.list = lapply(combined_ROICorr.list, FUN=function(ith_manu.list){
    ith_manu.list[order(names(ith_manu.list))]
  })



  ##############################################################################
  ### half-vectorize
  ##############################################################################
  Corr_half_vectorized.list = RS.fMRI_4.2_Extracting.Results___Pearson.Correlation___Upper.Triangle.Elements(Ordered_by_Sub.list)



  ##############################################################################
  ### combined data
  ##############################################################################
  combined.list = list(Ordered_by_Sub.list, Corr_half_vectorized.list)
  if(FisherZ){
    names(combined.list) = c("ROI_Pearson.Correlation_FisherZ", "ROI_Pearson.Correlation_FisherZ_Upper.Triangle")
  }else{
    names(combined.list) = c("ROI_Pearson.Correlation", "ROI_Pearson.Correlation_Upper.Triangle")
  }

  
  ##############################################################################
  ### Excluding subjects
  ##############################################################################
  for(i in 1:length(Extracted_ROI.Signals[[1]])){
    # i=2
    ith_ROI.Sigs_names = Extracted_ROI.Signals[[2]][[i]] %>% names
    if(length(ith_ROI.Sigs_names)>0){
      ith_Corr_names = combined.list[[1]][[i]] %>% names
      combined.list[[1]][[i]] = combined.list[[1]][[i]][!ith_Corr_names %in% ith_ROI.Sigs_names]
      combined.list[[2]][[i]] = combined.list[[2]][[i]][!ith_Corr_names %in% ith_ROI.Sigs_names]
    }
  }
  
  return(combined.list)
}
















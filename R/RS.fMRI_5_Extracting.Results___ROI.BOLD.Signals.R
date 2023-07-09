RS.fMRI_5_Extracting.Results___ROI.BOLD.Signals = function(path_Results.ROISignals, files_Norm.Pictures){
  ##############################################################################
  ### Files' list
  ##############################################################################
  path_ROISignals.list = lapply(path_Results.ROISignals, FUN=function(ith_path_Results.ROISignals){
    list.files(ith_path_Results.ROISignals, pattern=glob2rx("*ROISignals_Sub*txt*"), full.names = T)
  })




  ##############################################################################
  ### Files' list
  ##############################################################################
  ROISignals.list = lapply(path_ROISignals.list, FUN=function(path_ith_ROISignals){
    # path_ith_ROISignals = path_ROISignals.list[[1]]
    RS.fMRI_4.2_Extracting.Results___ROI.Signals___Loading.Files(path_ith_ROISignals)
  })



  ##############################################################################
  ### Adding Sub names
  ##############################################################################
  for(i in 1:length(ROISignals.list)){
    names(ROISignals.list[[i]]) = files_Norm.Pictures[[i]]
  }



  ##############################################################################
  ### Combining by each manufacture
  ##############################################################################
  combined_ROISignals.list = RS.fMRI_4.0_SUB___Combining.by.Scanner.Manufacturer(ROISignals.list)



  ##############################################################################
  # ROI signals이 0으로 나온 개체가 있으면 제외하기
  ##############################################################################
  Excluded_Zero_ROISignals.list = RS.fMRI_4.2_Extracting.Results___ROI.Signals___Exclude.Zero.Signals(combined_ROISignals.list)
  # Non_zero.list = Excluded_Zero_ROISignals.list[[1]]
  # zero.list = Excluded_Zero_ROISignals.list[[2]]

  return(Excluded_Zero_ROISignals.list)
}







RS.fMRI_4.7_Combining.Functional.Connectivity = function(Excluding_Not_Defined_ROIs.list){
  tmp.list = Excluding_Not_Defined_ROIs.list
  for(g in 1:length(Excluding_Not_Defined_ROIs.list)){
    gth_Group = Excluding_Not_Defined_ROIs.list[[g]]
    ##############################################################################
    # ROI colnames
    ##############################################################################
    ROI = paste0("ROI_", fit_length(1:ncol(gth_Group$Pearon_Correlation[[1]]), 3))
    ROI.mat = matrix(NA, length(ROI), length(ROI))
    for(i in 1:length(ROI)){
      for(j in 1:length(ROI)){
        ROI.mat[i,j] = paste0(ROI[i], "-", ROI[j])
      }
    }
    ROI_colnames = gdata::upperTriangle(ROI.mat, diag=F, byrow=F)
    ##############################################################################
    # ROI colnames
    ##############################################################################
    gth_Group$Pearson_Correlation_UpperTriangle = do.call(rbind, gth_Group$Pearson_Correlation_UpperTriangle)
    gth_Group$FisherZ_Pearson_Correlation_UpperTriangle = do.call(rbind, gth_Group$FisherZ_Pearson_Correlation_UpperTriangle)
    names(gth_Group$Pearson_Correlation_UpperTriangle) = ROI_colnames
    names(gth_Group$FisherZ_Pearson_Correlation_UpperTriangle) = ROI_colnames
    tmp.list[[g]] = gth_Group
  }
  return(tmp.list)
}

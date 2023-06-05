RS.fMRI_5_Voxelwise.Signals___Extractor___Standardization = function(ith_Volume.mat, ith_FC_Mask.vec, Standardization.Method){
  which_Selected_ROI = which(ith_FC_Mask.vec!=0)
  Selected_Coordinates_BOLD_Signals.mat = ith_Volume.mat[which_Selected_ROI, ]

  if(Standardization.Method=="Z.Standardization" | Standardization.Method=="Z.standardization"){
    ith_Mean = mean(Selected_Coordinates_BOLD_Signals.mat)
    ith_SD = sd(Selected_Coordinates_BOLD_Signals.mat)
    ith_Volume.mat[which_Selected_ROI, ] = (Selected_Coordinates_BOLD_Signals.mat - ith_Mean)/ith_SD
  }
  return(ith_Volume.mat)
}

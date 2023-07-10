RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor___Standardization = function(Volume.mat, FC_Mask.vec, Standardization.Method){
  which_Selected_ROI = which(FC_Mask.vec!=0) %>% unname
  Selected_Coordinates_BOLD_Signals.mat = Volume.mat[which_Selected_ROI, ]

  if(Standardization.Method=="Z.Standardization" | Standardization.Method=="Z.Standardization"){
    Mean = mean(Selected_Coordinates_BOLD_Signals.mat)
    SD = sd(Selected_Coordinates_BOLD_Signals.mat)
    Volume.mat[which_Selected_ROI, ] = (Selected_Coordinates_BOLD_Signals.mat - Mean)/SD
  }
  return(Volume.mat)
}

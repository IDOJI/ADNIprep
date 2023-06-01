RS.fMRI_5_Extracting.Results___Voxel.Wise.Signals___Vector.From.FC.ROI.Mask = function(path_Mask){
  # path_Mask = "E:/ADNI/ADNI_RS.fMRI___SB/Completed___AutoMask___O/Philips/Philips_SB___Sub_015___RID_4021/Masks/FCROI_1_Sub_015.nii"
  #=============================================================================
  # Load the data
  #=============================================================================
  Mask =  oro.nifti::readNIfTI(path_Mask, reorient=F)
  Mask.vec = Mask %>% as.vector



  #=============================================================================
  # Dimension
  #=============================================================================
  n_x = dim(Mask)[1]
  n_y = dim(Mask)[2]
  n_z = dim(Mask)[3]

  names_xy = lapply(1:n_y, FUN=function(y, ...){
    paste(fit_length(1:n_x,2), fit_length(y, 2), sep="_")
  }) %>% unlist
  names_xyz = lapply(1:n_z, FUN=function(z, ...){
    paste(names_xy, fit_length(z, 2), sep="_")
  }) %>% unlist


  #=============================================================================
  # Labeling
  #=============================================================================
  names(Mask.vec) = names_xyz

  return(Mask.vec)

}

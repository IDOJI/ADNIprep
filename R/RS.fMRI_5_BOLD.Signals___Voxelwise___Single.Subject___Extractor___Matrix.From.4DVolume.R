RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor___Matrix.From.4DVolume = function(path_4DVolume.nii=NULL, Filtered_4DVolume=NULL){

  if(!is.null(path_4DVolume.nii)){
    # path_4DVolume.nii
    ith_Volume = RNifti::readNifti(path_4DVolume.nii)
  }else if(!is.null(Filtered_4DVolume)){
    ith_Volume = Filtered_4DVolume
  }


  n_x = dim(ith_Volume)[1]
  n_y = dim(ith_Volume)[2]
  n_z = dim(ith_Volume)[3]
  n_t = dim(ith_Volume)[4] # TR



  #=============================================================================
  # Row names by each coordinates
  #=============================================================================
  ith_row_names_xy = lapply(1:n_y, FUN=function(y, ...){
    paste(fit_length(1:n_x,2), fit_length(y, 2), sep="_")
  }) %>% unlist
  ith_row_names_xyz = lapply(1:n_z, FUN=function(z, ...){
    paste(ith_row_names_xy, fit_length(z, 2), sep="_")
  }) %>% unlist



  #=============================================================================
  # Vectorize voxel array
  #=============================================================================
  ith_Voxel_Signals.mat = matrix(nrow = prod(n_x, n_y, n_z), ncol = n_t)
  rownames(ith_Voxel_Signals.mat) = ith_row_names_xyz
  colnames(ith_Voxel_Signals.mat) = paste0(fit_length(1:n_t, nchar(n_t)), "_", "Timepoint")
  for (t in 1:n_t) {
    ith_Voxel_Signals.mat[, t] = ith_Volume[, , , t] %>% as.vector %>% as.numeric
  }


  return(ith_Voxel_Signals.mat)
}

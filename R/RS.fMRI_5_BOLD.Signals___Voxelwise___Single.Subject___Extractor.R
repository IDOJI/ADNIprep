RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor = function(RID, Atlas, result.folder.name, Standardization.Method=NULL, path_Volume, path_FCROI, path_BOLD_Signals, path_ROI_Order_Keys, path_save, Include.Raw = T){
  #===========================================================================
  # 4D Volume
  #===========================================================================
  tictoc::tic()
  Volume.mat = RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor___Matrix.From.4DVolume(path_4DVolume.nii = path_Volume)
  tictoc::toc()
  cat("\n", crayon::yellow("Make 4DVolume.nii A Matrix :"), crayon::red(paste0("RID_", RID)),"\n")



  #===========================================================================
  # FC ROI
  #===========================================================================
  tictoc::tic()
  FC_Mask.vec = RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor___Vectorize.FC.ROI.Mask(path_Mask = path_FCROI)
  tictoc::toc()
  cat("\n", crayon::yellow("Vectorize FCROI.nii :"), crayon::red(paste0("RID_", RID)),"\n")





  #===========================================================================
  # Standardization
  #===========================================================================
  tictoc::tic()
  if(!is.null(Standardization.Method)){
    Volume_Standardized.mat = RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor___Standardization(Volume.mat, FC_Mask.vec, Standardization.Method)
    cat("\n", crayon::yellow("Standardization 4DVolume.nii :"), crayon::red(paste0("RID_", RID)),"\n")
  }
  tictoc::toc()





  #===========================================================================
  # Grouping Voxels by ROIs : Comparing with DPABI ROI signals
  #===========================================================================
  tictoc::tic()
  BOLD_Signals = read.table(path_BOLD_Signals)
  Voxelwise_BOLD_Signals_Grouped_by_ROIs.list = RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor___Grouping.by.ROI(Volume.mat, FC_Mask.vec, BOLD_Signals)
  if(!is.null(Standardization.Method)){
    Voxelwise_BOLD_Signals_Grouped_by_ROIs_Standardized.list = RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor___Grouping.by.ROI(Volume_Standardized.mat, FC_Mask.vec)
  }
  tictoc::toc()
  cat("\n", crayon::yellow("Grouping Voxelwise BOLD signals by ROI :"), crayon::red(paste0("RID_", RID)),"\n")




  #===========================================================================
  # Labeling Brain Region by ROI order keys
  #===========================================================================
  tictoc::tic()
  Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list = RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor___ROI.Labeling(Voxelwise_BOLD_Signals_Grouped_by_ROIs.list, path_ROI_Order_Keys, Atlas)
  if(!is.null(Standardization.Method)){
    Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs_Standardized.list = RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor___ROI.Labeling(Voxelwise_BOLD_Signals_Grouped_by_ROIs_Standardized.list, path_ROI_Order_Keys, Atlas)
  }
  tictoc::toc()
  cat("\n", crayon::yellow("Labeling Grouped Voxelwise BOLD signals by ROI :"), crayon::red(paste0("RID_", RID)),"\n")




  #===========================================================================
  # Exporting Voxelwise Signals
  #===========================================================================
  tictoc::tic()
  # Raw
  if(Include.Raw){
    RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor___Saving.RDS.Data(RID, result.folder.name, filename_suffix="Raw", save_path, Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list)
  }
  # Standardized
  if(!is.null(Standardization.Method)){
    RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor___Saving.RDS.Data(RID, result.folder.name, filename_suffix=Standardization.Method, save_path, Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list)
  }
  tictoc::toc()
  cat("\n", crayon::yellow("Exporting RDS data of Voxelwise signals :"), crayon::red(paste0("RID_", RID)),"\n")





  #===========================================================================
  # the number of voxels of each ROI & Coordinates
  #===========================================================================
  # ith_n_Voxels = lapply(ith_Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list, nrow)
  Voxels_Coordinates = lapply(Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list, rownames)

  # Path for saving
  path_save_New = paste0(path_save, "/",  paste0("BOLD.Signals___Voxelwise___", Atlas, "___", Pipeline, "___Coordinates"))
  dir.create(path_save_New, showWarnings = F)
  saveRDS(Voxels_Coordinates, file = paste0(path_save_New, "/RID_", fit_length(RID, 4), "___BOLD.Signals___Voxelwise___", Atlas, "___", result.folder.name, "___Coordinates.rds"))
  cat("\n", crayon::yellow("Exporting RDS data of Voxels Coordinates :"), crayon::red(paste0("RID_", RID)),"\n")




  # Saving =====================================================================

  saveRDS(object = Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list, file = paste0(path_save_New, "/", filename, ".rds"))






  #===========================================================================
  # Returning
  #===========================================================================
  cat("\n", crayon::green("Extracting Voxelwise BOLD signals by ROI :"), crayon::bgMagenta(paste0("RID_", RID)),"\n")
}



#
# ### Label
# FC_Mask_Label = FC_Mask.vec %>% table %>% names %>% as.numeric %>% sort
# FC_Mask_Label = FC_Mask_Label[FC_Mask_Label!=0]
#
#
#
# ### Voxel Coordinates
# FC_Mask_Voxel_Coordinates = names(FC_Mask.vec)
#
#
# #=========================================================================
# # select by ROIs
# #=========================================================================
# Voxelwise_ROI_BOLD_Signals.list = lapply(seq_along(FC_Mask_Label), function(i, ...){
#   ith_ROI = FC_Mask_Label[i]
#   which_ith_ROI_Voxels = which(FC_Mask.vec==ith_ROI)
#
#   ### ith ROI voxels in Volume
#   ith_ROI_Volume = Volume.mat[which_ith_ROI_Voxels, ]
#
#
#   ### Check Voxel Coordinates
#   ith_ROI_Coordinates = rownames(Volume.mat)[which_ith_ROI_Voxels]
#   ith_ROI_Voxel_Coordinates = FC_Mask_Voxel_Coordinates[which_ith_ROI_Voxels]
#   if(sum(ith_ROI_Voxel_Coordinates == ith_ROI_Coordinates) != length(ith_ROI_Coordinates)){
#     stop(paste0(ROI, "different coordinates voxels exist"))
#   }
#
#

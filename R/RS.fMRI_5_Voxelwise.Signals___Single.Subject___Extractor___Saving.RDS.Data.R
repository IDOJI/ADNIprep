RS.fMRI_5_Voxelwise.Signals___Single.Subject___Extractor___Saving.RDS.Data = function(RID, filename_suffix=NULL, save_path, Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list){
  dir.create(path_save, showWarnings = F)

  tictoc::tic()
  if(is.null(filename_suffix)){
    filename = paste0(fit_length(RID, 4), "___", "Voxelwise.BOLD.Signals")
  }else{
    filename = paste0(fit_length(RID, 4), "___", "Voxelwise.BOLD.Signals", "___", filename_suffix)
  }

  saveRDS(object = Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list, file = paste0(path_save, "/RID_", filename, ".rds"))
  tictoc::toc()
  # cat("\n", crayon::green("Saving Voxel-wise BOLD signals is done :"), paste0("RID_", crayon::red(RID)),"\n")
}













































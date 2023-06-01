RS.fMRI_5_Voxelwise.Signals___Extractor___Saving.RDS.Data = function(ith_RID, filename_suffix=NULL, save_path, ith_Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list){
  dir.create(save_path, showWarnings = F)

  tictoc::tic()
  filename = paste(fit_length(ith_RID, 3), "Voxelwise.BOLD.Signals", filename_suffix, sep="___")
  saveRDS(object = ith_Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list, file = paste0(save_path, "/RID_", filename, ".rds"))
  tictoc::toc()
  cat("\n", crayon::green("Saving Voxel-wise BOLD signals is done :"), crayon::red(ith_RID) ,"\n")
}













































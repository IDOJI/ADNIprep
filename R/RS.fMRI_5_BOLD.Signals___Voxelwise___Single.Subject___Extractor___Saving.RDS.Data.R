RS.fMRI_5_BOLD.Signals___Voxelwise___Single.Subject___Extractor___Saving.RDS.Data = function(RID, result.folder.name, filename_suffix=NULL, save_path, Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list){
  if(!fs::dir_exists(path_save)) {
    fs::dir_create(path_save)
    cat(crayon::green("The directory did not exist. Created it now."))
  }
  # dir.create(path_save, showWarnings = F)


  tictoc::tic()
  # Pipeline ========================================================================
  filename_Voxelwise = paste0("BOLD.Signals___Voxelwise___", Atlas, "___", result.folder.name)



  # Suffix =====================================================================
  if(is.null(filename_suffix)){
    filename = paste0("RID_", fit_length(RID, 4), "___", filename_Voxelwise)

    path_save_New = paste0(path_save, "/",  filename_Voxelwise)
    dir.create(path_save_New, showWarnings = F)

  }else{
    filename = paste0("RID_", fit_length(RID, 4), "___", filename_Voxelwise, "___", filename_suffix)

    path_save_New = paste0(path_save, "/",  filename_Voxelwise, "___", filename_suffix)
    dir.create(path_save_New, showWarnings = F)
  }


  # Saving =====================================================================

  saveRDS(object = Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list, file = paste0(path_save_New, "/", filename, ".rds"))
  tictoc::toc()
  # cat("\n", crayon::green("Saving Voxel-wise BOLD signals is done :"), paste0("RID_", crayon::red(RID)),"\n")
}






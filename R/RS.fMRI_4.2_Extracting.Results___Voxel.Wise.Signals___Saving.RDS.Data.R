RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals___Saving.RDS.Data = function(path_Preprocessing.Completed, Volumes_path, save_path){
  #=============================================================================
  # Extracting files at save_path
  #=============================================================================
  files_at_save_path = list.files(save_path)

  #=============================================================================
  # Extracting save_names
  #=============================================================================
  save_names = list.files(path_Preprocessing.Completed) %>% strsplit("___") %>% sapply(FUN=function(y){y[3]})


  sapply(Volumes_path, FUN=function(ith_Volume_path, ...){
    # ith_Volume_path = Volumes_path[1]
    #=============================================================================
    # Index
    #=============================================================================
    ind = which(Volumes_path == ith_Volume_path)


    #=============================================================================
    # Extracting Signals from 4D volume.nii
    #=============================================================================
    ith_Voxel_Signals.mat = RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals___Extractor(ith_Volume_path)



    #=============================================================================
    # Saving
    #=============================================================================
    tictoc::tic()
    saveRDS(object = ith_Voxel_Signals.mat, file = paste0(save_path, "/", save_names[ind], ".rds"))
    tictoc::toc()
    cat("\n", crayon::green("Saving Voxel-wise BOLD signals is done :"), crayon::red(save_names[ind]) ,"\n")

    # tictoc::tic()
    # test = readRDS(file = paste0(save_path, "/", save_names[ind], ".rds"))
    # tictoc::toc()



    #=============================================================================
    # All zero rows
    #=============================================================================
    ith_rowSums = rowSums(ith_Voxel_Signals.mat);names(ith_rowSums) = NULL
    if(length(ith_row_names_xyz)==length(ith_rowSums)){
      write.csv(data.frame(Zero_Coordinate = ith_row_names_xyz[which(ith_rowSums==0)]), file = paste0(save_path, "/", save_names[ind], "___Zero_Coordinates", ".csv"), row.names = F)
      cat("\n", crayon::green("Saving Coordinates with only zeros is done :"), crayon::red(save_names[ind]) ,"\n")
    }
  })
}






















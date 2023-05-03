RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals___Saving.RDS.Data = function(path_Preprocessing.Completed, Volumes_path, save_path){
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
    # Loading Volume files
    #=============================================================================
    ith_Volume = RNifti::readNifti(ith_Volume_path)

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
      ith_Voxel_Signals.mat[, t] = as.vector(ith_Volume[, , , t])
    }

    View(ith_Voxel_Signals.mat)


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






















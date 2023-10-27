RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Extract.Median.Voxel.Coordinates.Dist = function(ith_VoxelwiseBoldSignals, path_Export){
  #===========================================================================
  # Brain regions & Numbering
  #===========================================================================
  Numbers_vector = 1:length(ith_VoxelwiseBoldSignals)
  Brain_Regions = names(ith_VoxelwiseBoldSignals)



  #===========================================================================
  # Voxel coordinate
  #===========================================================================
  Coordinates = lapply(ith_VoxelwiseBoldSignals, rownames) %>% setNames(Brain_Regions)




  #===========================================================================
  # Extracting Coordinates
  #===========================================================================
  Save_Matrix.mat = matrix(0, nrow = length(Brain_Regions), ncol = length(Brain_Regions))

  Median_Voxel_Coordiantes_Distance.list = lapply(Numbers_vector, function(j){
    tictoc::tic()
    jth_Coordiantes_Dist_Median.list = lapply(Numbers_vector, function(k){
      print(paste0(j," __ ", k))
      if(j==k | k<j){
       return(NA)
      }else{
        #=========================================================================
        # rownames
        #=========================================================================
        jth_rownames = Coordinates[[j]]
        kth_rownames = Coordinates[[k]]



        #=========================================================================
        # Extract rownames to use as coordinates
        #=========================================================================
        jth_coordinates = jth_rownames %>% RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Extract.Median.Voxel.Coordinates___As.DF
        kth_coordinates = kth_rownames %>% RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Extract.Median.Voxel.Coordinates___As.DF




        #=========================================================================
        # Compute distances
        #=========================================================================
        jk_distance.mat = rbind(jth_coordinates, kth_coordinates) %>% dist %>% as.matrix
        colnames(jk_distance.mat) = rownames(jk_distance.mat) = c(jth_rownames, kth_rownames)
        jk_distance_selected.mat = jk_distance.mat[rownames(jk_distance.mat) %in% jth_rownames, colnames(jk_distance.mat) %in% kth_rownames, drop = F]




        #=========================================================================
        # Compute the median value(s) of the matrix
        #=========================================================================
        jk_matrix_sorted = sort(jk_distance_selected.mat)
        n = length(jk_matrix_sorted)
        if(n %% 2 == 0){
          # If the number of elements is even, calculate the mean of the two middle values
          jk_matrix_median = jk_matrix_sorted[n/2]
        }else{
          # If the number of elements is odd, find the middle value
          jk_matrix_median = jk_matrix_sorted[(n + 1) / 2]
        }



        return(jk_matrix_median)
      }
    }) %>% setNames(Brain_Regions)
    tictoc::toc()
    Save_Matrix.mat[j,] <<- jth_Coordiantes_Dist_Median.list %>% unlist
  })
  rownames(Save_Matrix.mat) = colnames(Save_Matrix.mat) = Brain_Regions




  #===========================================================================
  # Making symmetric
  #===========================================================================
  Save_Matrix.mat = make_sym(Save_Matrix.mat, T)



  #===========================================================================
  # Exporting
  #===========================================================================
  dir.create(path_Export, F)
  saveRDS(object = Save_Matrix.mat, file = paste0(path_Export, "/Median_Voxel_Dist_Between_ROIs.rds"))






  #===========================================================================
  # return
  #===========================================================================
  return(Save_Matrix.mat)
}

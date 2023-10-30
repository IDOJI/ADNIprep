RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Center.Coordinates = function(ith_VoxelwiseBoldSignals){
  #===========================================================================
  # Brain regions & Numbering
  #===========================================================================
  Numbers_vector = 1:length(ith_VoxelwiseBoldSignals)
  Brain_Regions = names(ith_VoxelwiseBoldSignals)



  #===========================================================================
  # Extracting Coordinates
  #===========================================================================
  tictoc::tic()
  Center_Voxel_Coordiantes = lapply(Numbers_vector, function(j){
    jth_Coordiantes.list = lapply(Numbers_vector, function(k){
      if(k>j){
        #=========================================================================
        # BOLD signals
        #=========================================================================
        jth_Signals = ith_VoxelwiseBoldSignals[[j]]
        kth_Signals = ith_VoxelwiseBoldSignals[[k]]




        #=========================================================================
        # voxel coordiantes
        #=========================================================================
        jth_rownames = jth_Signals %>% rownames
        kth_rownames = kth_Signals %>% rownames



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



        #=========================================================================
        # Find the row and column indices of the median value
        #=========================================================================
        jk_median_indices = which(jk_distance_selected.mat == jk_matrix_median, arr.ind = TRUE)
        rownames(jk_median_indices) = NULL
        colnames(jk_median_indices) = c(Brain_Regions[j], Brain_Regions[k])
        return(jk_median_indices)
      }
    })
    names(jth_Coordiantes.list) = Brain_Regions

    return(jth_Coordiantes.list)
  })
  tictoc::toc()
  names(Median_Voxel_Coordiantes) = Brain_Regions


  #===========================================================================
  # Return
  #===========================================================================
  return(Median_Voxel_Coordiantes)
}

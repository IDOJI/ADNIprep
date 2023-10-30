RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Center.Coordinates = function(BOLD, path_Export){
  #=============================================================================
  # Brain regions & Numbering
  #=============================================================================
  Numbers_vector = 1:length(BOLD)
  Brain_Regions = names(BOLD)





  #=============================================================================
  # Voxel coordinate
  #=============================================================================
  Coordinates = lapply(BOLD, rownames) %>% setNames(Brain_Regions)




  #=============================================================================
  # Extracting Coordinates & Median FCs
  #=============================================================================
  Dist.list = lapply(Numbers_vector, function(j){
    tictoc::tic()
    jth_Dist = sapply(Numbers_vector, function(k){
      print(paste0(j," __ ", k))

      if(j==k | k<j){
       return(NA)
      }else{
        #=======================================================================
        # Coordinates
        #=======================================================================
        jth_Coordinates = BOLD[[j]] %>% rownames %>% RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Center.Coordinates___Split.Coordinates.As.DF
        kth_Coordinates = BOLD[[k]] %>% rownames %>% RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Center.Coordinates___Split.Coordinates.As.DF



        #=======================================================================
        # Extract the center of coordinates
        #=======================================================================
        jth_Center = jth_Coordinates %>% RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Center.Coordinates___Extract.Center.Coordinate %>% unlist
        kth_Center = kth_Coordinates %>% RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Center.Coordinates___Extract.Center.Coordinate %>% unlist

        jk_dist = ((jth_Center - kth_Center)^2) %>% sum() %>% sqrt()

        return(jk_dist)
      }
    }) %>% setNames(Brain_Regions)
    tictoc::toc()
    return(jth_Dist)
  })
  Dist_Matrix = do.call(cbind, Dist.list)
  colnames(Dist_Matrix) = rownames(Dist_Matrix) = Brain_Regions






  #===========================================================================
  # Making symmetric
  #===========================================================================
  Sym_Dist_Matrix = make_sym(Dist_Matrix, F)







  #===========================================================================
  # Check if distances are unique
  #===========================================================================
  test = apply(Sym_Dist_Matrix, 2, function(x){
    x %>% unique %>% length != length(x)
  })
  if(sum(test)>0){
    stop("Distances are not unique!")
  }





  #===========================================================================
  # Exporting
  #===========================================================================
  dir.create(path_Export, F)
  saveRDS(object = Sym_Dist_Matrix, file = paste0(path_Export, "/Center_Voxel_Dist_Between_ROIs.rds"))





  #===========================================================================
  # return
  #===========================================================================
  return(Sym_Dist_Matrix)
}







# RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Coordinates.Nearest.to.the.Averaged.FC = function(BOLD, path_Export){
#   #=============================================================================
#   # Brain regions & Numbering
#   #=============================================================================
#   Numbers_vector = 1:length(BOLD)
#   Brain_Regions = names(BOLD)
#
#
#
#
#
#   #=============================================================================
#   # Voxel coordinate
#   #=============================================================================
#   Coordinates = lapply(BOLD, rownames) %>% setNames(Brain_Regions)
#
#
#
#
#   #=============================================================================
#   # Extracting Coordinates & Median FCs
#   #=============================================================================
#   FC_Matrix = matrix(NA, nrow = length(Brain_Regions), ncol = length(Brain_Regions))
#   colnames(FC_Matrix) = rownames(FC_Matrix) = Brain_Regions
#
#   Median_Voxel_Coordiantes_Distance.list = lapply(Numbers_vector, function(j){
#     tictoc::tic()
#     jth_Coordiantes_Dist_Median.list = lapply(Numbers_vector, function(k){
#       print(paste0(j," __ ", k))
#
#       if(j==k | k<j){
#         return(NA)
#       }else{
#         #=======================================================================
#         # BOLD
#         #=======================================================================
#         jth_BOLD = BOLD[[j]]
#         kth_BOLD = BOLD[[k]]
#
#
#
#
#
#         #=======================================================================
#         # compute FC
#         #=======================================================================
#         #----------------------------------------------
#         # Averaged FC
#         #----------------------------------------------
#         jth_Averaged_FC = colMeans(jth_BOLD)
#         kth_Averaged_FC = colMeans(kth_BOLD)
#
#
#
#
#         #----------------------------------------------
#         # FC with Fisher Z transformation
#         #----------------------------------------------
#         jk_Corr_FisherZ.mat = cor(t(jth_BOLD), t(kth_BOLD)) %>% atanh()
#         jk_Corr_FisherZ = cor(jth_Averaged_FC, kth_Averaged_FC) %>% atanh()
#
#
#
#
#
#         #-----------------------------------------------
#         # Finding coordiantes closest to the averaged FC
#         #-----------------------------------------------
#         # Find the position of the closest value in jk_Corr_FisherZ.mat
#         jk_minimum_diff = min(abs(jk_Corr_FisherZ.mat - jk_Corr_FisherZ))
#         jk_closest_value_location = which(abs(jk_Corr_FisherZ.mat - jk_Corr_FisherZ) == jk_minimum_diff, arr.ind = TRUE)
#
#
#
#
#         #------------------------------------------------
#         # Compute distance
#         #------------------------------------------------
#         jth_Voxel_Coordinate = rownames(jk_Corr_FisherZ.mat)[jk_closest_value_location[1]] %>% RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Extract.Median.Voxel.Coordinates___As.DF %>% unlist
#         kth_Voxel_Coordinate = rownames(jk_Corr_FisherZ.mat)[jk_closest_value_location[2]] %>% RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Extract.Median.Voxel.Coordinates___As.DF %>% unlist
#         jk_Voxel_Dist = sqrt(sum((jth_Voxel_Coordinate - kth_Voxel_Coordinate)^2))
#
#
#
#         return(list(FisherZ_FC = jk_Corr_FisherZ, Nearest_Dist = jk_Voxel_Dist))
#       }
#     }) %>% setNames(Brain_Regions)
#     tictoc::toc()
#     return(jth_Coordiantes_Dist_Median.list)
#   })
#   rownames(Save_Matrix.mat) = colnames(Save_Matrix.mat) = Brain_Regions
#
#
#
#
#   #===========================================================================
#   # Making symmetric
#   #===========================================================================
#   Save_Matrix.mat = make_sym(Save_Matrix.mat, T)
#
#   Save_Matrix.mat = matrix(0, nrow = length(Brain_Regions), ncol = length(Brain_Regions))
#
#   #===========================================================================
#   # Exporting
#   #===========================================================================
#   dir.create(path_Export, F)
#   saveRDS(object = Save_Matrix.mat, file = paste0(path_Export, "/Median_Voxel_Dist_Between_ROIs.rds"))
#
#
#
#
#
#
#   #===========================================================================
#   # return
#   #===========================================================================
#   return(Save_Matrix.mat)
# }











#=======================================================================
# rownames
#=======================================================================
# jth_rownames = Coordinates[[j]]
# kth_rownames = Coordinates[[k]]



#=======================================================================
# Extract rownames to use as coordinates
#=======================================================================
# jth_coordinates = jth_rownames %>% RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Extract.Median.Voxel.Coordinates___As.DF
# kth_coordinates = kth_rownames %>% RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Extract.Median.Voxel.Coordinates___As.DF





#=======================================================================
# Compute all FC pairs
#=======================================================================






#=======================================================================
# Compute distances
#=======================================================================
# jk_distance.mat = rbind(jth_coordinates, kth_coordinates) %>% dist %>% as.matrix
# colnames(jk_distance.mat) = rownames(jk_distance.mat) = c(jth_rownames, kth_rownames)
# jk_distance_selected.mat = jk_distance.mat[rownames(jk_distance.mat) %in% jth_rownames, colnames(jk_distance.mat) %in% kth_rownames, drop = F]




#=======================================================================
# Compute the median value(s) of the matrix
#=======================================================================
# jk_matrix_sorted = sort(jk_distance_selected.mat)
# n = length(jk_matrix_sorted)
# if(n %% 2 == 0){
#   # If the number of elements is even, calculate the mean of the two middle values
#   jk_matrix_median = jk_matrix_sorted[n/2]
# }else{
#   # If the number of elements is odd, find the middle value
#   jk_matrix_median = jk_matrix_sorted[(n + 1) / 2]
# }



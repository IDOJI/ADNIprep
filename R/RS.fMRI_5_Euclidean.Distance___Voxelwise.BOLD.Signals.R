RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals = function(ith_VoxelwiseBoldSignals,
                                                                 file.name,
                                                                 path_Export){
  #=============================================================================
  # Directory
  #=============================================================================
  dir.create(path_Export, F)




  #=============================================================================
  # Finding median coordiantes among regions
  #=============================================================================
  have_coordinates = list.files(path_Export, pattern="Median_Voxel_Coordinates.rds") %>% length > 0
  if(!have_coordinates){
    Median_Voxel_Coordinates = RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Extract.Median.Voxel.Coordinates(ith_VoxelwiseBoldSignals)
    saveRDS(Median_Voxel_Coordinates, paste0(path_Export, "/Median_Voxel_Coordinates.rds"))
  }else{
    Median_Voxel_Coordinates = readRDS(paste0(path_Export, "/Median_Voxel_Coordinates.rds"))
  }






  #=============================================================================
  # Find Median FC for each coordinate
  #=============================================================================
  Median_FC_Coordinates = RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Median.FC(ith_VoxelwiseBoldSignals, Median_Voxel_Coordinates)





  #=============================================================================
  # Combine each region
  #=============================================================================
  Combined_Each_Region = RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Combined.Results.Each.Region(Median_FC_Coordinates)





  #=============================================================================
  # Combine as a matrix
  #=============================================================================
  Combined_As_Matrix = RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Combine.as.Matrix(Combined_Each_Region)




  #=============================================================================
  # Export
  #=============================================================================
  path_Export = path_Export %>% path_tail_slash()
  dir.create(path_Export, F)
  saveRDS(Combined_As_Matrix, file = paste0(path_Export, file.name, ".rds"))


  return(Combined_As_Matrix)
}




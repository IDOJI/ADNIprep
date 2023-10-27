RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Median.FC = function(ith_VoxelwiseBoldSignals, Median_Voxel_Coordinates){
  tictoc::tic()
  Results = lapply(seq_along(Median_Voxel_Coordinates), function(j){
    cat("\n", crayon::red(paste0(names(ith_VoxelwiseBoldSignals)[j])), crayon::green("is done"),"\n")
    jth_Region = Median_Voxel_Coordinates[[j]]


    jth_FC_Median.list = lapply(seq_along(jth_Region), function(k){
      # kth_Region_Coordinate = jth_Region[[2]]
      kth_Region_Coordinate = jth_Region[[k]]
      if(is.null(kth_Region_Coordinate)){
        rep(NA, 3) %>% as.list() %>% setNames(c("FC", names(ith_VoxelwiseBoldSignals)[j], names(ith_VoxelwiseBoldSignals)[k])) %>% return()
      }else{
        RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Median.FC___Extracting.Median.Coordinate(ith_VoxelwiseBoldSignals, kth_Region_Coordinate, j, k)
      }
    })
    names(jth_FC_Median.list) = names(ith_VoxelwiseBoldSignals)


    return(jth_FC_Median.list)
  })
  tictoc::toc()

  return(Results)
}










RS.fMRI_5_BOLD.Signals___Voxelwise___Check.Coordinates.Results = function(path_Extracted_Results){
  #===============================================================================
  # Reading Coordinates files
  #===============================================================================
  path_Coordinates_Files = list.files(path_Extracted_Results, pattern = "Coordinates", full.names = T)
  Coordinates.list = lapply(path_Coordinates_Files, readRDS)




  #===============================================================================
  # Combine Coordinates by ROIs
  #===============================================================================
  Coordinates_Combined_by_ROI.list = lapply(seq_along(Coordinates.list[[1]]), function(i){
    ith_ROI.list = lapply(seq_along(Coordinates.list), function(n, ...){
      y = data.frame(Coordinates.list[[n]][[i]])
      names(y) = paste0(n, "th sub")
      return(y)
    })

    do.call(cbind, ith_ROI.list)
  })




  #===============================================================================
  # Check coordinates
  #===============================================================================
  is_Same_Coordinates_Unique = sapply(Coordinates_Combined_by_ROI.list, function(y){
    nrow(y)==length(apply(y, 1, unique))
  })



  if(sum(is_Same_Coordinates_Unique) == length(is_Same_Coordinates_Unique)){
    cat("\n", crayon::green("Congratulation! All coordinates are same!") ,"\n")
  }else{
    warnings("The coordinates are not same!")
  }
}

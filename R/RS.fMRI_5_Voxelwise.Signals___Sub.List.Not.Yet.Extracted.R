RS.fMRI_5_Voxelwise.Signals___Sub.List.Not.Yet.Extracted = function(path_Extracted.Results, path_Lists){
  #===============================================================================
  # list RDS files
  #===============================================================================
  Extracted_RDS_RID = list.files(path_Extracted.Results) %>% stringr::str_extract(pattern = "RID_\\d+")




  #===============================================================================
  # Extract Sub folders list and path
  #===============================================================================
  Sub_Folders = sapply(path_Lists, function(y){
    list.files(y)
  }) %>% unlist %>% unname



  path_Sub_Folders = sapply(path_Lists, function(y){
    list.files(y, full.names=T)
  }) %>% unlist %>% unname




  #===============================================================================
  # Find which ones have not been preprocessed
  #===============================================================================
  index = sapply(Extracted_RDS_RID, function(ith_RID){
    grep(pattern = ith_RID, Sub_Folders)
  }) %>% unlist %>% unname %>% sort


  if(length(index)>0){
    cat("\n", crayon::red("These are the Subjects that have not been extracted voxel-wise signals"), "\n")
    sapply(path_Sub_Folders[-index], function(y){
      cat("\n", crayon::yellow(y) ,"\n")
    })
    return(path_Sub_Folders[-index])
  }


}

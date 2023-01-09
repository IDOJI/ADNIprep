RS.fMRI_3.1.Before.Preprocessing___Moving.Sub.Folders.For.Repreprocessing = function(from, n, specific=NULL){
  # from = manu_path
  # specific = c(83,84,86,87,91)


  if(!is.null(specific)){
    #=============================================================================
    # Moving specific Sub folders
    #=============================================================================
    RS.fMRI_3.1.Before.Preprocessing___Moving.Sub.Folders.For.Repreprocessing___Specific.Folders(from, specific)
  }else{
    #=============================================================================
    # Moving n-divided folders
    #=============================================================================
    RS.fMRI_3.1.Before.Preprocessing___Moving.Sub.Folders.For.Repreprocessing___N.Divided.Folders(from, n)
  }
}

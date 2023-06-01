RS.fMRI_5_Extracting.Results___Voxel.Wise.Signals___Extract.Volume.and.Masks.Path___DPABI.Template = function(path_Preprocessing.Completed,
                                                                                                              DPABI.Template,
                                                                                                              what.result.folder){
  #=============================================================================
  # path & folders
  #=============================================================================
  path_Preprocessing.Completed = path_Preprocessing.Completed %>% path_tail_slash()
  folders = list.files(path_Preprocessing.Completed)
  folders_path = list.files(path_Preprocessing.Completed, full.names = T)


  #=============================================================================
  # template path & folders
  #=============================================================================
  template_path = sapply(folders_path, FUN=function(y, ...){list.files(y, pattern = DPABI.Template, full.names = T)})


  #=============================================================================
  # Results path & folders
  #=============================================================================
  Results_path = sapply(template_path, FUN=function(y, ...){list.files(y, pattern = what.result.folder, full.names = T)})
  having_no_folder_named_what.result.folder = as.logical("0" %in% sapply(Results_path, length) %>% table %>% names)
  if(having_no_folder_named_what.result.folder){
    cat("\n", template_path[sapply(Results_path, length)==0], "\n")
    stop("Therer are folders having no folder named 'what result.folder' !")
  }

  #=============================================================================
  # volume files path
  #=============================================================================
  Volumes_path = sapply(Results_path, FUN=function(ith_result_path){
    list.files(ith_result_path, full.names = T, recursive = T)
  })
  names(Volumes_path) = NULL

  return(Volumes_path)
}

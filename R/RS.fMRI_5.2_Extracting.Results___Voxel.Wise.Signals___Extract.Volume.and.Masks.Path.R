RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals___Extract.Volume.and.Masks.Path = function(path_Preprocessing.Completed,
                                                                                               DPABI.Template= NULL,
                                                                                               what.result.folder){

  if(is.null(DPABI.Template)){
    # 여러 명의 사람들에 대해 한 번에 전처리한 결과를 추출하는 경우
    path_Voume_and_Masks = RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals___Extract.Volume.and.Masks.Path___No.DPABI.Template(path_Preprocessing.Completed, what.result.folder)
    return(path_Voume_and_Masks)
  }else{
    # 각각의 사람들에 대해 한 명 씩 전처리 한 결과가 @Original_EPI / @MNI_EPI 등의 폴더에 저장된 경우


  }
}



RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals___Extract.Volume.and.Masks.Path___DPABI.Template = function(path_Preprocessing.Completed,
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




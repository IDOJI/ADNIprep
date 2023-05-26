RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals___Extract.Volume.and.Masks.Path___No.DPABI.Template = function(path_Preprocessing.Completed,
                                                                                                                   what.result.folder){
  #=============================================================================
  # Extracting path
  #=============================================================================
  Result_Folder = list.files(path_Preprocessing.Completed, pattern = what.result.folder)[1]
  path_Result_Folder = list.files(path_Preprocessing.Completed, pattern = what.result.folder, full.names=T)[1]
  path_Subjects = list.files(path_Result_Folder, full.names=T)





  #=============================================================================
  # 4D volume path
  #=============================================================================
  Volume_name = list.files(path_Subjects[1])
  path_4D.Volumes = paste0(path_Subjects, "/", Volume_name)



  #=============================================================================
  # Masks path
  #=============================================================================
  path_Masks = paste0(path_tail_slash(path_Preprocessing.Completed), "Masks")
  path_FCROI = list.files(path_Masks, pattern = "FCROI_1", full.names=T)



  path_Voume_and_Masks = list()
  for(i in 1:length(path_FCROI)){
    path_Voume_and_Masks[[i]] = c(path_4D.Volumes[i], path_FCROI[i])
  }


  return(path_Voume_and_Masks)
}

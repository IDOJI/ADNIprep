RS.fMRI_5_Extracting.Results___Voxel.Wise.Signals___Extract.Volume.and.Masks.Path = function(path_Preprocessing.Completed,,
                                                                                               what.result.folder){

  if(is.null(DPABI.Template)){
    # 여러 명의 사람들에 대해 한 번에 전처리한 결과를 추출하는 경우
    path_Voume_and_Masks = RS.fMRI_5_Extracting.Results___Voxel.Wise.Signals___Extract.Volume.and.Masks.Path___No.DPABI.Template(path_Preprocessing.Completed, what.result.folder)
    return(path_Voume_and_Masks)
  }else{
    # 각각의 사람들에 대해 한 명 씩 전처리 한 결과가 @Original_EPI / @MNI_EPI 등의 폴더에 저장된 경우


  }
}





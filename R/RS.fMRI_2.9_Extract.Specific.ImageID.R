RS.fMRI_2.9_Extract.Specific.ImageID = function(path_RID.Folders = path_Preprocessing.Error,
                                                which.RID=NULL,
                                                path_Subjects.Lists.Downloaded,
                                                path_Subjects.Lists.Exported,
                                                Subjects_QC_ADNI2GO,
                                                Subjects_QC_ADNI3,
                                                Subjects_NFQ,
                                                Subjects_search,
                                                # previous
                                                path_All.Subjects.EPB.List.File=NULL,
                                                path_All.Subjects.MT1.List.File=NULL,
                                                Include_Previous_ImageID = T,
                                                Exclude_ImageID=NULL,
                                                what.date){
  #=============================================================================
  # 옵션 설명
  #=============================================================================
  # path_RID.Folders
  # 외장하드에 RID 이름으로 정렬된 fMRI 데이터 폴더들이 있는 path
  # 여기서는 보통 error가 발생한 폴더들을 모아 놓은 path를 지정
  # which.RID
  # 위의 path_RID.Folders가 지정되지 않은 경우
  # 입력된 RID의 Image ID 리스트를 가져옴
  # 기존의 subjects 리스트 가져오기


  #=============================================================================
  # 둘 중 하나는 입력해야 함
  #=============================================================================
  if(is.null(which.RID) & is.null(path_RID.Folders)){
    stop("Either 'which.RID' or 'path_RID.Folders' should be input.")
  }



  #=============================================================================
  # path_RID.Folders가 입력된 경우
  #=============================================================================
  if(!is.null(path_RID.Folders)){
    folders = list.files(path_RID.Folders)
    path_folders = list.files(path_RID.Folders, full.names = T)
    which.RID = sapply(folders, FUN=function(y){substr(y, nchar(y)-3, nchar(y))}) %>% as.numeric %>% as.character %>% union(which.RID)
  }




  #=============================================================================
  # 기존 이미지 아이디 포함?
  #=============================================================================
  if(!is.null(path_All.Subjects.EPB.List.File) & !is.null(path_All.Subjects.MT1.List.File)){
    EPB = read.csv(path_All.Subjects.EPB.List.File) %>% as_tibble
    MT1 = read.csv(path_All.Subjects.MT1.List.File) %>% as_tibble
    ImageID = c(EPB$IMAGE_ID, MT1$IMAGE_ID)
    if(Include_Previous_ImageID){
      RS.fMRI_1.(path_Subjects.Lists_Downloaded,
                 path_Export_Subjects.Lists = path_Subjects.Lists.Exported,
                 path_Export_Rda = NULL,
                 Subjects_QC_ADNI2GO,
                 Subjects_QC_ADNI3,
                 Subjects_NFQ,
                 Subjects_search,
                 what.date = what.date,
                 Include_RID = which.RID,
                 Include_ImageID = ImageID)
    }else{
      RS.fMRI_1.(path_Subjects.Lists_Downloaded,
                 path_Export_Subjects.Lists = path_Subjects.Lists.Exported,
                 path_Export_Rda = NULL,
                 Subjects_QC_ADNI2GO,
                 Subjects_QC_ADNI3,
                 Subjects_NFQ,
                 Subjects_search,
                 what.date = what.date,
                 Include_RID = which.RID,
                 Exclude_ImageID = ImageID)
    }
  }



  #=============================================================================
  # Exclude Image ID 에 있는 ImageID 제외
  #=============================================================================
  if(!is.null(Exclude_ImageID)){
    RS.fMRI_1.(path_Subjects.Lists_Downloaded,
               path_Export_Subjects.Lists = path_Subjects.Lists.Exported,
               path_Export_Rda = NULL,
               Subjects_QC_ADNI2GO,
               Subjects_QC_ADNI3,
               Subjects_NFQ,
               Subjects_search,
               what.date = what.date,
               Include_RID = which.RID,
               Exclude_ImageID = Exclude_ImageID)
  }

  cat("\n", crayon::bgMagenta("Step 2.9"), crayon::red("Extracting ImageIDs for some specific RIDs"), crayon::blue("is done!"),"\n")
}









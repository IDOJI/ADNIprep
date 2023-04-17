RS.fMRI_2.3_Check.Undownloaded.Images = function(path_All.Subjects.EPB.List.File = paste0(path_OS, "Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported/0.All_Subjects/[Final_Selected]_Subjects_list_EPB_(0.All_Subjects).csv"),
                                                 path_All.Subjects.MT1.List.File = paste0(path_OS, "Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported/0.All_Subjects/[Final_Selected]_Subjects_list_MT1_(0.All_Subjects).csv"),
                                                 path_ADNI.Unzipped.Folders){
  #=============================================================================
  # Loading folders list
  #=============================================================================
  EPB_List.df = read.csv(path_All.Subjects.EPB.List.File) %>% as_tibble
  MT1_List.df = read.csv(path_All.Subjects.MT1.List.File) %>% as_tibble

  EPB_List.df$RID = as.numeric(EPB_List.df$RID)
  MT1_List.df$RID = as.numeric(MT1_List.df$RID)



  #=============================================================================
  # Loading folders list
  #=============================================================================
  Folders = list.files(path_ADNI.Unzipped.Folders)




  #=============================================================================
  # Extract RID
  #=============================================================================
  RID = sapply(Folders, FUN=function(ith_Folder){
    # ith_Folder = Folders[10]
    ith_RID = substr(ith_Folder, nchar(ith_Folder)-4, nchar(ith_Folder))
    ith_RID = strsplit(ith_RID, "_")[[1]]
    ith_RID = ith_RID[length(ith_RID)]
    return(ith_RID)
  }) %>% as.numeric
  names(RID) = NULL





  #=============================================================================
  # 중복 RID 확인
  #=============================================================================
  duplicated_RID = table(RID)[table(RID) != 1] %>% names %>% as.numeric




  #=============================================================================
  # Check RID not downloaded
  #=============================================================================
  RID_Not_Downloaded= EPB_List.df$RID[!EPB_List.df$RID %in% RID]
  EPB_ImageID_Not_Downloaded = EPB_List.df %>% filter(RID %in% RID_Not_Downloaded) %>% select(IMAGE_ID) %>% unlist
  MT1_ImageID_Not_Downloaded = MT1_List.df %>% filter(RID %in% RID_Not_Downloaded) %>% select(IMAGE_ID) %>% unlist
  Not_Downloaded.df = data.frame(RID = RID_Not_Downloaded, EPB = EPB_ImageID_Not_Downloaded, MT1 = MT1_ImageID_Not_Downloaded) %>% as_tibble



  #=============================================================================
  # Export results
  #=============================================================================
  results.list = list(Duplicated_RID = duplicated_RID, Not_Downloaded = Not_Downloaded.df)
  return(results.list)
}

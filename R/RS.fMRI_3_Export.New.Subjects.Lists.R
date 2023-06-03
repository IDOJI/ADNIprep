RS.fMRI_3_Export.New.Subjects.Lists = function(path_All.Subjects.EPB.List.File,
                                               path_All.Subjects.MT1.List.File,
                                               Error.RID.To.Exlude,
                                               path_New.Export.Subjects.Lists,
                                               #################################
                                               path_Subjects.Lists_Downloaded,
                                               Subjects_QC_ADNI2GO,
                                               Subjects_QC_ADNI3,
                                               Subjects_NFQ,
                                               Subjects_search,
                                               #################################
                                               Former_Exclude_ImageID,
                                               what.date=2){
  # path_Error.Folders.To.Exlude = "E:/ADNI/ADNI_RS.fMRI___SB/Error/_완전제외"
  #=============================================================================
  # 1.Loading Subjects Lists
  #=============================================================================
  EPI = read.csv(path_All.Subjects.EPB.List.File) %>% as_tibble
  MT1 = read.csv(path_All.Subjects.MT1.List.File) %>% as_tibble







  #=============================================================================
  # Select Excluding RID
  #=============================================================================
  RID_Exclude = Error.RID.To.Exlude %>% as.numeric






  #=============================================================================
  # Remove RID to Exclude
  #=============================================================================
  EPI_Excluded = EPI %>% filter(RID %in% RID_Exclude)
  MT1_Excluded = MT1 %>% filter(RID %in% RID_Exclude)

  EPI_Selected = EPI %>% filter(! RID %in% RID_Exclude)
  MT1_Selected = MT1 %>% filter(! RID %in% RID_Exclude)






  #=============================================================================
  # Check the former ImageID
  #=============================================================================
  Selected_RID_Subjects_Lists_1 = RS.fMRI_1.(path_Subjects.Lists_Downloaded, path_Export_Subjects.Lists = NULL, path_Export_Rda = NULL, Subjects_QC_ADNI2GO, Subjects_QC_ADNI3, Subjects_NFQ, Subjects_search,
                                             what.date = what.date-1, Include_RID = RID_Exclude, Include_ImageID = NULL, Exclude_RID = NULL, Exclude_ImageID = Former_Exclude_ImageID, Exclude_Comments = NULL)
  EPI_List.df = Selected_RID_Subjects_Lists_1[[1]]
  MT1_List.df = Selected_RID_Subjects_Lists_1[[2]]

  is_EPI_same = sum(EPI_Excluded$IMAGE_ID %in% EPI_List.df$IMAGE_ID) == length(EPI_Excluded$IMAGE_ID)
  is_MT1_same = sum(MT1_Excluded$IMAGE_ID %in% MT1_List.df$IMAGE_ID) == length(MT1_Excluded$IMAGE_ID)
  if(!is_EPI_same | !is_EPI_same){
    stop("Check the selected ImageIDs!")
  }







  #=============================================================================
  # Select Second date
  #=============================================================================
  Selected_RID_Subjects_Lists_2 = RS.fMRI_1.(path_Subjects.Lists_Downloaded, path_Export_Subjects.Lists = NULL, path_Export_Rda = NULL, Subjects_QC_ADNI2GO, Subjects_QC_ADNI3, Subjects_NFQ, Subjects_search,
                                             what.date = what.date, Include_RID = RID_Exclude, Include_ImageID = NULL, Exclude_RID = NULL, Exclude_ImageID = Former_Exclude_ImageID, Exclude_Comments = NULL)
  New_Selected_EPI = Selected_RID_Subjects_Lists_2[[1]]
  New_Selected_MT1 = Selected_RID_Subjects_Lists_2[[2]]







  #=============================================================================
  # Binding New Subjects
  #=============================================================================
  names(New_Selected_EPI) = names(EPI_Selected)
  names(New_Selected_MT1) = names(MT1_Selected)
  Binded_EPI.df = rbind(New_Selected_EPI, EPI_Selected)
  Binded_MT1.df = rbind(New_Selected_MT1, MT1_Selected)
  Binded.list = list(Binded_EPI.df[-c(1:2)], Binded_MT1.df)







  #=============================================================================
  # Adding Subnumbering
  #=============================================================================
  Subnum_Binded.list = RS.fMRI_1.2_Merging.Lists___Adding.Numbering.By.Manufacturers(Binded.list)






  #=============================================================================
  # Exporting
  #=============================================================================
  write.csv(Subnum_Binded.list[[1]], file = paste0(path_New.Export.Subjects.Lists,"/[Final_Selected]_Subjects_list_EPB_All_New.csv"), row.names = F)
  write.csv(Subnum_Binded.list[[2]], file = paste0(path_New.Export.Subjects.Lists,"/[Final_Selected]_Subjects_list_MT1_All_New.csv"), row.names = F)
  cat("\n",crayon::yellow("Exporting"), crayon::red("New Subjects Lists"), crayon::yellow("is done!"),"\n")







  #=============================================================================
  # Image ID
  #=============================================================================
  if(nrow(New_Selected_EPI)>0 & nrow(New_Selected_MT1)>0){
    cat("\n", crayon::blue("New Image IDs to download : "),"\n")
    paste(c(New_Selected_EPI$IMAGE_ID,New_Selected_MT1$IMAGE_ID), collapse = ",") %>% cat
  }else{
    cat("\n", crayon::red("There is no newly selected subject!"),"\n")
  }
}

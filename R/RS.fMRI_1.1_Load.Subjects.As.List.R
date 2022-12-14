RS.fMRI_1.1_Load.Subjects.As.List = function(path_Subjects,
                                             path_Subjects_Downloaded,
                                             path_Rda,
                                             subjects_search_fMRI,
                                             subjects_search_MRI,
                                             subjects_QC_ADNI2GO,
                                             subjects_QC_ADNI3,
                                             subjects_NFQ,
                                             Have_Previous_Study=F){
  subjects.list = list()

  # (1) ida search ========================================================================================
  subjects.list[[1]] = RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List(subjects_search_fMRI, subjects_search_MRI, path_Subjects_Downloaded, path_Rda)



  # (2) QC info ===========================================================================================
  subjects.list[[2]] = RS.fMRI_1.1_Load.Subjects.As.List___2.QC.List(subjects_QC_ADNI2GO, subjects_QC_ADNI3, path_Subjects_Downloaded, path_Rda)



  # (3) NFQ info ==========================================================================================
  subjects.list[[3]] = RS.fMRI_1.1_Load.Subjects.As.List___3.NFQ.List(subjects_NFQ, path_Subjects_Downloaded, path_Rda)



  # (4) Intersection IMAGE_ID ===========================================================================
  ### intersection by image ID (RID 기준으로 합치면 QC 정보를 빠뜨리게 된다.)
  IMAGE_ID_intersect = intersect(subjects.list[[1]]$IMAGE_ID, subjects.list[[2]]$IMAGE_ID)
  for(i in 1:2){
    subjects.list[[i]] = subjects.list[[i]] %>% dplyr::filter(IMAGE_ID %in% IMAGE_ID_intersect)
  }
  text = "1.1 : Subsetting by intersection IMAGE_ID is done."
  cat("\n", crayon::green(text), "\n")



  # (5) Exlcude previous RID ===========================================================================
  if(Have_Previous_Study){
    folders = list.files(path_Subjects, full.names = T)
    previous = folders[grep("Previous", folders)] %>% list.files(full.names=T)
    previous_RID = read.csv(file=previous) %>% unlist %>% as.character
    for(i in 1:length(subjects.list)){
      subjects.list[[i]] = subjects.list[[i]] %>% dplyr::filter(! RID %in% previous_RID)
    }
  }


  # (6) Intersection RID ===========================================================================
  RID_intersect = intersect(subjects.list[[1]]$RID, subjects.list[[2]]$RID)
  for(i in 1:2){
    subjects.list[[i]] = subset(subjects.list[[i]], RID %in% RID_intersect)
  }
  text = "1.1 : Subsetting by intersection RID is done."
  cat("\n", crayon::green(text), "\n")


  ### returning results ===========================================================================
  text = paste("\n","Step 1.1 is done !","\n")
  cat(crayon::bgMagenta(text))
  return(subjects.list)
}



# if(!is.null(subjects_search_fMRI) && !is.null(subjects_search_MRI)){
#
# }else{
#   data("ADNI_Subjects_Search", package="ADNIprep")
#   subjects.list[[1]] = ADNI_Subjects_Search
# }
#
# if(!is.null(subjects_QC_ADNI2GO) && !is.null(subjects_QC_ADNI3)){
#
# }else{
#   data("ADNI_Subjects_QC", package="ADNIprep")
#   subjects.list[[2]] = ADNI_Subjects_QC
# }
# if(!is.null(subjects_NFQ)){
#
# }else{
#   data("ADNI_Subjects_NFQ", package="ADNIprep")
#   subjects.list[[3]] = ADNI_Subjects_NFQ
# }

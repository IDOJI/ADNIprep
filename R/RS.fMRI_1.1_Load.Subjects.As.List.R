RS.fMRI_1.1_Load.Subjects.As.List = function(path_Subjects.Lists_Downloaded,
                                             Subjects_QC_ADNI2GO,
                                             Subjects_QC_ADNI3,
                                             Subjects_NFQ,
                                             Subjects_search,
                                             what.date,
                                             Include_RID=NULL,
                                             Include_ImageID =NULL,
                                             Exclude_RID=NULL,
                                             Exclude_ImageID=NULL,
                                             Exclude_Comments=NULL){
  # (0) list for saving ========================================================================================
  subjects.list = rep(NA, 3) %>% as.list
  names(subjects.list) = c("QC", "NFQ", "SEARCH")



  # QC info ===========================================================================================
  subjects.list[[1]] = RS.fMRI_1.1_Load.Subjects.As.List___QC.List(Subjects_QC_ADNI2GO,
                                                                   Subjects_QC_ADNI3,
                                                                   path_Subjects.Lists_Downloaded,
                                                                   what.date,
                                                                   Include_RID,
                                                                   Include_ImageID,
                                                                   Exclude_RID,
                                                                   Exclude_ImageID,
                                                                   Exclude_Comments)




  # NFQ info ==========================================================================================
  subjects.list[[2]] = RS.fMRI_1.1_Load.Subjects.As.List___NFQ.List(Subjects_NFQ,
                                                                    path_Subjects.Lists_Downloaded)







  # ida search ========================================================================================
  subjects.list[[3]] = RS.fMRI_1.1_Load.Subjects.As.List___Search.List(Subjects_search,
                                                                       path_Subjects.Lists_Downloaded)




  # Final ==========================================================================================
  final_subjects.list = subjects.list



  ### returning results ===========================================================================
  text = paste("\n","Step 1.1 is done !","\n")
  cat(crayon::bgMagenta(text))
  return(final_subjects.list)
}


# # (3) Intersection by Search & QC ===========================================================================
# Intersection_subjects.list = RS.fMRI_1.1_Load.Subjects.As.List___3.Intersection.Search.and.QC(subjects.list)



# if(!is.null(Subjects_search_fMRI) && !is.null(Subjects_search_MRI)){
#
# }else{
#   data("ADNI_Subjects_search", package="ADNIprep")
#   subjects.list[[1]] = ADNI_Subjects_search
# }
#
# if(!is.null(Subjects_QC_ADNI2GO) && !is.null(Subjects_QC_ADNI3)){
#
# }else{
#   data("ADNI_Subjects_QC", package="ADNIprep")
#   subjects.list[[2]] = ADNI_Subjects_QC
# }
# if(!is.null(Subjects_NFQ)){
#
# }else{
#   data("ADNI_Subjects_NFQ", package="ADNIprep")
#   subjects.list[[3]] = ADNI_Subjects_NFQ
# }

#
#
# # (5) Intersection by SCAN.DATE ===========================================================================
# ImageID_subjects.list = RS.fMRI_1.1_Load.Subjects.As.List___4.Intersection.by.Image.ID(subjects.list)
#
#


# # (5) Exlcude previous RID ===========================================================================
# if(!is.null(Exclude_RID)){
#   folders = list.files(path_Subjects, full.names = T)
#   previous = folders[grep("Previous", folders)] %>% list.files(full.names=T)
#   previous_RID = read.csv(file=previous) %>% unlist %>% as.character
#   for(i in 1:length(subjects.list)){
#     subjects.list[[i]] = subjects.list[[i]] %>% dplyr::filter(! RID %in% previous_RID)
#   }
# }

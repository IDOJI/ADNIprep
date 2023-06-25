RS.fMRI_1.1_Load.Subjects.As.List = function(path_Subjects.Lists_Downloaded,
                                             # QC
                                             Subjects_QC_ADNI2GO,
                                             Subjects_QC_ADNI3,
                                             # NFQ
                                             Subjects_NFQ,
                                             # Search
                                             Subjects_Search,
                                             # Registry
                                             Subjects_Registry,
                                             Subjects_CV_ADNI2GO,
                                             Subjects_CV_ADNI3,
                                             what.date,
                                             Include_RID=NULL,
                                             Include_ImageID =NULL,
                                             Exclude_RID=NULL,
                                             Exclude_ImageID=NULL,
                                             Exclude_Comments=NULL){
  # (0) list for saving ========================================================================================
  Subjects.list = rep(NA, 4) %>% as.list
  names(Subjects.list) = c("QC", "NFQ", "SEARCH", "Registry")








  # NFQ info ==========================================================================================
  Subjects.list[[2]] = RS.fMRI_1.1_Load.Subjects.As.List___NFQ.List(Subjects_NFQ,
                                                                    path_Subjects.Lists_Downloaded)







  # ida search ========================================================================================
  Subjects.list[[3]] = RS.fMRI_1.1_Load.Subjects.As.List___Search.List(Subjects_Search,
                                                                       path_Subjects.Lists_Downloaded)




  # Registry ========================================================================================
  if(grep("\\.csv", Subjects_Registry) %>% length > 0){
    Registry.df = read.csv(paste0(path_Subjects.Lists_Downloaded %>% path_tail_slash(), Subjects_Registry))
  }else{
    Registry.df = read.csv(paste0(path_Subjects.Lists_Downloaded %>% path_tail_slash(), Subjects_Registry, ".csv"))
  }
  names(Registry.df) = Registry.df %>% names %>% toupper
  selected_cols = c("PTSTATUS", "RGSTATUS", "VISTYPE", "RGCONDCT", "RGREASON", "RGOTHSPE", "RGSOURCE", "RGRESCRN", "RGPREVID", "CHANGTR", "CGTRACK", "CGTRACK2", "UPDATE_STAMP")
  names(Registry.df)[which(names(Registry.df) %in% selected_cols)] = paste0("REGISTRY___", selected_cols)
  Registry.df = Registry.df %>% relocate(starts_with("REGISTRY_"), .after=last_col())
  Subjects.list[[4]] = Registry.df


  # Final ==========================================================================================
  final_Subjects.list = Subjects.list



  ### returning results ===========================================================================
  text = paste("\n","Step 1.1 is done !","\n")
  cat(crayon::bgMagenta(text))
  return(final_Subjects.list)
}


# # (3) Intersection by Search & QC ===========================================================================
# Intersection_Subjects.list = RS.fMRI_1.1_Load.Subjects.As.List___3.Intersection.Search.and.QC(Subjects.list)



# if(!is.null(Subjects_search_fMRI) && !is.null(Subjects_search_MRI)){
#
# }else{
#   data("ADNI_Subjects_search", package="ADNIprep")
#   Subjects.list[[1]] = ADNI_Subjects_search
# }
#
# if(!is.null(Subjects_QC_ADNI2GO) && !is.null(Subjects_QC_ADNI3)){
#
# }else{
#   data("ADNI_Subjects_QC", package="ADNIprep")
#   Subjects.list[[2]] = ADNI_Subjects_QC
# }
# if(!is.null(Subjects_NFQ)){
#
# }else{
#   data("ADNI_Subjects_NFQ", package="ADNIprep")
#   Subjects.list[[3]] = ADNI_Subjects_NFQ
# }

#
#
# # (5) Intersection by SCAN.DATE ===========================================================================
# ImageID_Subjects.list = RS.fMRI_1.1_Load.Subjects.As.List___4.Intersection.by.Image.ID(Subjects.list)
#
#


# # (5) Exlcude previous RID ===========================================================================
# if(!is.null(Exclude_RID)){
#   folders = list.files(path_Subjects, full.names = T)
#   previous = folders[grep("Previous", folders)] %>% list.files(full.names=T)
#   previous_RID = read.csv(file=previous) %>% unlist %>% as.character
#   for(i in 1:length(Subjects.list)){
#     Subjects.list[[i]] = Subjects.list[[i]] %>% dplyr::filter(! RID %in% previous_RID)
#   }
# }

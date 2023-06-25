RS.fMRI_1_Data.Selection___Loading.Lists___CLIELG = function(Selected_RID, Subjects_CV_ADNI2GO, Subjects_CV_ADNI3, path_Subjects.Lists_Downloaded){
  #=============================================================================
  # Loading data
  #=============================================================================
  CV_1.df = read.csv(paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_CV_ADNI2GO, ".csv"))
  CV_2.df = read.csv(paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_CV_ADNI3, ".csv"))



  #=============================================================================
  # Combining
  #=============================================================================
  names(CV_1.df) = names(CV_1.df) %>% toupper
  names(CV_2.df) = names(CV_2.df) %>% toupper

  Dummy.df = matrix(NA, nrow = nrow(CV_2.df), ncol = ncol(CV_1.df)) %>% as.data.frame
  names(Dummy.df) = names(CV_1.df)
  CV_2_New.df = merge(CV_2.df, Dummy.df, by = intersect(names(CV_2.df), names(Dummy.df)), all.x = T)
  CV_1_New.df = CV_1.df %>% relocate(names(CV_2_New.df))
  CV.df = rbind(CV_1_New.df, CV_2_New.df) %>% arrange(RID, USERDATE) %>% filter(RID %in% Selected_RID)




  #=============================================================================
  # names change
  #=============================================================================
  names(CV.df) = paste0("CLIELG___", names(CV.df))




  #=============================================================================
  # replace elements
  #=============================================================================
  # CLIELG_Intersect_Selected.df = replace_elements(CLIELG_Intersect_Selected.df, col_name = "DIAGNOSIS", from = c("Cognitively Normal", "Early MCI", "Late MCI", "Significant Memory Concern"), to = c("CN", "EMCI", "LMCI", "SMC"))




  #=============================================================================
  # as list
  #=============================================================================
  CV.list = RS.fMRI_1_Data.Selection___Loading.Lists___SUB___Making.List(Selected_RID, CV.df)

  return(CV.list)
}












# #=============================================================================
# # find by dates difference
# #=============================================================================
# EPB_BLCHANGE_Combined.list = lapply(RID_EPB, function(ith_RID, ...){
#   # ith EPB
#   ith_EPB = EPB.df %>% filter(RID == ith_RID)
#   ith_EPB_Study.Date = ith_EPB$STUDY.DATE
#
#   # ith_Combined list
#   ith_Combined.list = list(ith_EPB, NA, NA)
#   names(ith_Combined.list) = paste0("RID_", ith_RID, "___", c("EPB", "Nearest_BLCHANGE", "ith_BLCHANGE_List"))
#
#
#   if(ith_RID %in% RID_BL){
#     # ith BL CHANGE
#     ith_BLCHANGE = BLCHANGE.df %>% filter(RID == ith_RID)
#     ith_BLCHANGE_Exam.Dates = ith_BLCHANGE$EXAMDATE
#
#
#     # Dates difference
#     ith_Min.Diff.Index = abs(ith_EPB_Study.Date - ith_BLCHANGE_Exam.Dates) %>% which.min
#     ith_BLCHANGE_Nearest = ith_BLCHANGE[ith_Min.Diff.Index, ]
#     ith_Combined.list[[1]]$STUDY.DATE
#     ith_Combined.list[[1]]$VISCODE2
#
#     ith_Combined.list[[2]] = ith_BLCHANGE_Nearest
#     ith_Combined.list[[3]] = ith_BLCHANGE
#   }
#   return(ith_Combined.list)
# })
#
#
#
#
#
#
#
# #=============================================================================
# # Compare VISCODE
# #=============================================================================
# Visits = lapply(EPB_BLCHANGE_Combined.list, function(y){
#   if(is.data.frame(y[[2]])){
#     ith_combined = c(y[[1]]$VISCODE, y[[2]]$VISCODE,
#                      y[[1]]$VISCODE2, y[[2]]$VISCODE2,
#                      as.character(y[[1]]$STUDY.DATE), as.character(y[[2]]$EXAMDATE))
#     names(ith_combined) = c("VISCODE_EPB", "VISCODE_BLCHANGE", "VISCODE2_EPB", "VISCODE2_BLCHANGE", "DATE_EPB", "DATE_BLCHANGE")
#     return(ith_combined)
#   }
# })

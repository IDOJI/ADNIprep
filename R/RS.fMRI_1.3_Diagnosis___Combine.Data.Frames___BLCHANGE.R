RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___BLCHANGE = function(Merged_Lists.df, path_Subjects_BLCHANGE){
  #=============================================================================
  # csv?
  #=============================================================================
  if(grep("csv", path_Subjects_BLCHANGE) %>% length > 0){
    BLCHANGE.df = read.csv(path_Subjects_BLCHANGE)
  }else{
    BLCHANGE.df = read.csv(paste0(path_Subjects_BLCHANGE, ".csv"))
  }


  #=============================================================================
  # As date
  #=============================================================================
  BLCHANGE.df$EXAMDATE = BLCHANGE.df$EXAMDATE %>% as.Date()






  #=============================================================================
  # Intersect RID
  #=============================================================================
  RID_BL = BLCHANGE.df$RID %>% unique %>% sort
  RID_EPB = Merged_Lists.df$RID %>% sort
  RID_Intersect = intersect(RID_BL, RID_EPB) %>% sort


  BLCHANGE_Intersect.df = BLCHANGE.df %>% filter(RID %in% RID_Intersect) %>% arrange(RID, EXAMDATE)





  #=============================================================================
  # Selecting columns
  #=============================================================================
  # RS.fMRI_1.3_Diagnosis___Data.Dictionary("BCCORCOG")
  BLCHANGE_Intersect_Selected.df = BLCHANGE_Intersect.df %>% select(c("RID", "VISCODE", "VISCODE2", "EXAMDATE", "BCPREDX", "BCEXTSP", "BCSUMM"))


  names(BLCHANGE_Intersect_Selected.df) = paste0("BLCHANGE___", names(BLCHANGE_Intersect_Selected.df))



  #=============================================================================
  # Change Description
  #=============================================================================
  # RS.fMRI_1.3_Diagnosis___Data.Dictionary("BCPREDX")
  BLCHANGE_Intersect_Selected.df = replace_elements(BLCHANGE_Intersect_Selected.df, col_name = "BLCHANGE___BCPREDX", from = c(1,2,3,-4, NA), to = c("CN", "MCI", "AD", "NA", "NA"))



  #=============================================================================
  # BL  as list by RID
  #=============================================================================
  BL.list = as_list_by(BLCHANGE_Intersect_Selected.df, by =  "BLCHANGE___RID")



  cat("\n", crayon::bgMagenta("Step 1.3 "),crayon::green("Diagnosis subjects selection is done : "), crayon::red("BLCHANGE"),"\n")
  return(BL.list)
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

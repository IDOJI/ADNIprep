RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___ADNIMERGE.Package___CLIELG = function(Merged_Lists.df){
  #=============================================================================
  # As date
  #=============================================================================
  require(ADNIMERGE)
  CLIELG.df = clielg
  CLIELG.df$CDATE = CLIELG.df$CDATE %>% as.Date()
  CLIELG.df$USERDATE = CLIELG.df$USERDATE %>% as.Date()
  CLIELG.df$USERDATE2 = CLIELG.df$USERDATE2 %>% as.Date()




  #=============================================================================
  # Intersect RID
  #=============================================================================
  RID_CLIELG = CLIELG.df$RID %>% unique %>% sort
  RID_EPB = Merged_Lists.df$RID %>% sort
  RID_Intersect = intersect(RID_CLIELG, RID_EPB) %>% sort
  CLIELG_Intersect.df = CLIELG.df %>% filter(RID %in% RID_Intersect) %>% arrange(RID, USERDATE)



  #=============================================================================
  # Selecting columns
  #=============================================================================
  # RS.fMRI_1.3_Diagnosis___Data.Dictionary("CRAND")
  # cat(paste0('"',names(CLIELG_Intersect.df), '"'), sep=", ")
  CLIELG_Intersect_Selected.df = CLIELG_Intersect.df %>% select(c("RID", "VISCODE", "USERDATE", "USERDATE2", "CCOMM", "CENROLL", "DIAGNOSIS", "INCLUSION", "EXCLUSION","CRAND", "CDATE"))




  #=============================================================================
  # replace elements
  #=============================================================================
  CLIELG_Intersect_Selected.df = replace_elements(CLIELG_Intersect_Selected.df, col_name = "DIAGNOSIS", from = c("Cognitively Normal", "Early MCI", "Late MCI", "Significant Memory Concern"), to = c("CN", "EMCI", "LMCI", "SMC"))




  #=============================================================================
  # BL  as list by RID
  #=============================================================================
  names(CLIELG_Intersect_Selected.df) = paste0("CLIELG___", names(CLIELG_Intersect_Selected.df))
  CLIELG.list = as_list_by(CLIELG_Intersect_Selected.df, by =  "CLIELG___RID")



  cat("\n", crayon::bgMagenta("Step 1.3 "), crayon::green("Diagnosis subjects selection is done :"), crayon::blue("ADNIMERGE package"), crayon::red("CLIELG"),"\n")



  return(CLIELG.list)
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

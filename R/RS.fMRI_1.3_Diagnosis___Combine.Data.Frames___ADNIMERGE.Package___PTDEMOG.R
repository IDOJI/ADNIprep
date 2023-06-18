RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___ADNIMERGE.Package___PTDEMOG = function(Merged_Lists.list){
  #=============================================================================
  # As date
  #=============================================================================
  require(ADNIMERGE)
  Data.df = ptdemog
  Data.df$EXAMDATE = Data.df$EXAMDATE %>% as.Date()
  Data.df$USERDATE = Data.df$USERDATE %>% as.Date()
  Data.df$USERDATE2 = Data.df$USERDATE2 %>% as.Date()





  #=============================================================================
  # EPB, MT1
  #=============================================================================
  EPB.df = Merged_Lists.list[[1]]
  MT1.df = Merged_Lists.list[[2]]




  #=============================================================================
  # Intersect RID
  #=============================================================================
  RID_Data = Data.df$RID %>% unique %>% sort
  RID_EPB = EPB.df$RID %>% sort
  RID_Intersect = intersect(RID_Data, RID_EPB) %>% sort
  Data_Intersect.df = Data.df %>% filter(RID %in% RID_Intersect) %>% arrange(RID, USERDATE)




  #=============================================================================
  # Selecting columns
  #=============================================================================
  # RS.fMRI_1.3_Diagnosis___Data.Dictionary("CRAND")
  # cat(paste0('"',names(Data_Intersect.df), '"'), sep=", ")
  Data_Intersect_Selected.df = Data_Intersect.df %>% select(c("ORIGPROT", "COLPROT", "RID", "SITEID", "VISCODE", "USERDATE", "USERDATE2", "PTADDX", "PTCOGBEG", "PTDOB", "PTEDUCAT", "PTETHCAT", "PTGENDER", "PTHAND", "PTHOME", "PTMARRY", "PTNOTRT", "PTOTHOME", "PTPLANG", "PTPSPEC", "PTRACCAT", "PTRTYR", "PTSOURCE", "PTTLANG", "PTWORK", "PTWORKHS", "PTWRECNT", "EXAMDATE", "AGE", "PTMCIBEG", "PTADBEG"))
  names(Data_Intersect_Selected.df) = paste0("PTDEMO___", names(Data_Intersect_Selected.df))




  #=============================================================================
  # BL  as list by RID
  #=============================================================================
  PTDEMO.list = as_list_by(Data_Intersect_Selected.df, by =  "PTDEMO___RID")

  cat("\n", crayon::bgMagenta("Step 1.3 "), crayon::green("Diagnosis subjects selection is done :"), crayon::blue("ADNIMERGE package"), crayon::red("PTDEMO"),"\n")


  return(PTDEMO.list)
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

RS.fMRI_1_Data.Selection___Loading.Lists___ADNIMERGE = function(Selected_RID){
  #===============================================================================
  # ADNIMERGE 패키지 설치
  #===============================================================================
  # install_package("Hmisc")
  # install.packages("C:/Users/lleii/Dropbox/Github/Rpkgs/ADNIprep/ADNIMERGE/ADNIMERGE_0.0.1.tar.gz", repose = NULL, type="source")
  require(ADNIMERGE)
  # data(package = "ADNIMERGE")




  #=============================================================================
  # As date
  #=============================================================================
  ADNIMERGE.df = adnimerge
  ADNIMERGE.df$EXAMDATE = ADNIMERGE.df$EXAMDATE %>% as.Date()
  ADNIMERGE.df$EXAMDATE.bl = ADNIMERGE.df$EXAMDATE.bl %>% as.Date()





  #=============================================================================
  # filter by RID
  #=============================================================================
  ADNIMERGE_New.df = ADNIMERGE.df %>% filter(RID %in% Selected_RID) %>% arrange(RID, EXAMDATE)





  #=============================================================================
  # Selecting columns
  #=============================================================================
  # RS.fMRI_1.3_Diagnosis___Data.Dictionary("Years.bl")
  ADNIMERGE_New_2.df = ADNIMERGE_New.df %>% select(c("RID", "COLPROT", "ORIGPROT",
                                                     "VISCODE", "EXAMDATE", "DX.bl", "AGE", "PTGENDER", "PTEDUCAT", "PTETHCAT", "PTRACCAT", "PTMARRY",
                                                     "APOE4", "ADAS11", "ADAS13", "ADASQ4", "MMSE",
                                                     "DX", "EXAMDATE.bl", "Years.bl", "Month.bl", "Month", "M"))
  ADNIMERGE_New_2.df$DX.bl = ADNIMERGE_New_2.df$DX.bl %>% as.character()
  ADNIMERGE_New_2.df$DX = ADNIMERGE_New_2.df$DX %>% as.character()





  #=============================================================================
  # Replace Names
  #=============================================================================
  names(ADNIMERGE_New_2.df) = paste0("ADNIMERGE___", names(ADNIMERGE_New_2.df))




  #=============================================================================
  # as list
  #=============================================================================
  ADNIMERGE.list = RS.fMRI_1_Data.Selection___Loading.Lists___SUB___Making.List(Selected_RID, Data.df = ADNIMERGE_New_2.df)


  return(ADNIMERGE.list)
}


# #=============================================================================
# # EPB, MT1
# #=============================================================================
# EPB_DXSUM.list = Subjects_List_DX_Summary.list[[1]]
# MT1.df = Subjects_List_DX_Summary.list[[2]]
#
#
#
#
# #=============================================================================
# # Extract nearest
# #=============================================================================
# Combined.list = lapply(EPB_DXSUM.list, function(y, ...){
#   ith_RID = y[[1]]$RID
#   ith_Study.Date = y[[1]]$STUDY.DATE %>% as.Date
#
#   ith_ADNIMERGE = adnimerge %>% filter(RID==ith_RID)
#   if(nrow(ith_ADNIMERGE)>0){
#     ith_ADNIMERGE_Date = ith_ADNIMERGE$EXAMDATE
#     minium_index = difftime(ith_DX_Date, ith_Study.Date, units = "days") %>% abs %>% which.min
#     ith_ADNIMERGE_Min.Date = ith_ADNIMERGE %>% filter(EXAMDATE == ith_ADNIMERGE_Date[minium_index])
#
#     ith_List = c(y, list(ith_ADNIMERGE_Min.Date), list(ith_ADNIMERGE))
#   }else{
#     ith_List = c(y, list(NA), list(NA))
#   }
#   names(ith_List)[6:7] = paste0("RID_", ith_RID, "___",c("Nearest_ADNIMERGE", "ADNIMERGE"))
#   return(ith_List)
# })
#
#
#
# #=============================================================================
# # List's names by RID
# #=============================================================================
# names(Combined.list) = paste0("RID_", fit_length(sort(MT1.df$RID), 4))
#
# return(list(EPB_combined = Combined.list, MT1 = MT1.df))

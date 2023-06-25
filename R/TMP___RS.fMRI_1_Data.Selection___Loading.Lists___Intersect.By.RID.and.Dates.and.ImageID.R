RS.fMRI_1.2_Merging.Lists___Intersect.By.RID.and.Dates.and.ImageID = function(Subjects.list, ...){
  #=============================================================================
  # loading
  #=============================================================================
  Subjects_1 = Subjects.list[[1]]
  Subjects_2 = Subjects.list[[2]]
  Subjects_3 = Subjects.list[[3]]


  #=============================================================================
  # Dates
  #=============================================================================
  ### Change colnames
  df1_Date = df1_RID %>% dplyr::rename(STUDY.DATE = STUDY.DATE)
  df2_Date = df2_RID %>% dplyr::rename(STUDY.DATE = SERIES_DATE)
  df3_Date = df3_RID %>% dplyr::rename(STUDY.DATE = SCANDATE)


  ### intersect
  if(class(df1_Date$STUDY.DATE) %>% is.character &&
      class(df2_Date$STUDY.DATE) %>% is.character &&
        class(df3_Date$STUDY.DATE) %>% is.character){
    intersect_Date = intersect(intersect(df1_Date$STUDY.DATE, df2_Date$STUDY.DATE), df3_Date$STUDY.DATE)
    df1_Date = df1_Date %>% filter(STUDY.DATE %in% intersect_Date) %>% as.tibble()
    df2_Date = df2_Date %>% filter(STUDY.DATE %in% intersect_Date) %>% as.tibble()
    df3_Date = df3_Date %>% filter(STUDY.DATE %in% intersect_Date) %>% as.tibble()
  }else{
    stop("The STUDY.DATE variable is not character. Check this out!")
  }


  return(list(SEARCH = df1_Date, QC = df2_Date, NFQ = df3_Date))
}







# what_RID_have_Search.QC = lapply(intersect_RID, FUN=function(ith_RID, ...){
#   text0 = crayon::yellow("Having both Search & QC : ")
#   text1 = crayon::blue("RID")
#   text2 = crayon::bgMagenta(ith_RID)
#   text3 = crayon::blue("is done")
#   text4 = paste0("( ", round(100 * which(intersect_RID==ith_RID)/length(intersect_RID), 4), "% )")
#   cat("\n", text0, text1, text2, text3, text4, "\n")
#
#   if(intersect(dplyr::filter(df1_RID, RID==ith_RID)[,"STUDY.DATE"] %>% unlist, dplyr::filter(df2_RID, RID==ith_RID)[,"SERIES_DATE"] %>% unlist) %>% length > 0){
#     return(ith_RID)
#   }
# }) %>% unlist

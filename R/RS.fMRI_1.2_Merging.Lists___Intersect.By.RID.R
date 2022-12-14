RS.fMRI_1.2_Merging.Lists___Intersect.By.RID = function(Subjects.list, ...){
  #=============================================================================
  # loading
  #=============================================================================
  df1 = Subjects.list[[1]]
  df2 = Subjects.list[[2]]
  df3 = Subjects.list[[3]]


  #=============================================================================
  # intersect RID
  #=============================================================================
  intersect_RID = intersect(intersect(df1$RID, df2$RID), df3$RID) %>% unique %>% as.numeric %>% sort %>% as.character
  df1_RID = df1 %>% dplyr::filter(RID %in% intersect_RID)
  df2_RID = df2 %>% dplyr::filter(RID %in% intersect_RID)
  df3_RID = df3 %>% dplyr::filter(RID %in% intersect_RID)


  #=============================================================================
  # intersect by date : SEARCH & QC
  #=============================================================================
  what_RID_have_Search.QC = lapply(intersect_RID, FUN=function(ith_RID,...){
    text0 = crayon::yellow("Having both Search & QC : ")
    text1 = crayon::blue("RID")
    text2 = crayon::bgMagenta(ith_RID)
    text3 = crayon::blue("is done")
    text4 = paste0("( ", round(100 * which(intersect_RID==ith_RID)/length(intersect_RID), 4), "% )")
    cat("\n", text0, text1, text2, text3, text4, "\n")

    if(intersect(dplyr::filter(df1_RID, RID==ith_RID)[,"STUDY.DATE"] %>% unlist, dplyr::filter(df2_RID, RID==ith_RID)[,"SERIES_DATE"] %>% unlist) %>% length > 0){
      return(ith_RID)
    }
  })
  what_RID_have_Search.QC = what_RID_have_Search.QC %>% unlist
  df1_SQ = df1_RID %>% dplyr::filter(RID %in% what_RID_have_Search.QC)
  df2_SQ = df2_RID %>% dplyr::filter(RID %in% what_RID_have_Search.QC)
  df3_SQ = df3_RID %>% dplyr::filter(RID %in% what_RID_have_Search.QC)


  return(list(df1_SQ, df2_SQ, df3_SQ))
}




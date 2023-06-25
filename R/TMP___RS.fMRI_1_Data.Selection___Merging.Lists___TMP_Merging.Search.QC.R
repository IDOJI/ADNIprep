RS.fMRI_1.2_Merging.Lists___Merging.Search.QC = function(data.list=Selected_QC_by_what.date.list,...){
  S = .list[[1]]
  Q = Selected_QC_by_what.date.list[[2]]
  N = Selected_QC_by_what.date.list[[3]]
  what_RID_have_Search.QC = S$RID %>% unique


  ### merging SQ
  merged.list = lapply(Q, FUN=function(y,...){
    text0 = crayon::yellow("Merging Search & QC : ")
    text1 = crayon::blue("RID")
    text2 = crayon::bgMagenta(y$RID[1])
    text3 = crayon::blue("is done")
    text4 = paste0("( ", round(100 * which(what_RID_have_Search.QC==y$RID[1])/length(what_RID_have_Search.QC), 4), "% )")
    cat("\n", text0, text1, text2, text3, text4, "\n")


    ith_S = S %>% dplyr::filter(RID %in% y$RID)
    dplyr::full_join(ith_S, y, by=c("RID", "IMAGE_ID"), suffix=c("SEARCH_", "QC_")) %>% return
  })
  names(merged.list) = what_RID_have_Search.QC
  return(list(merged.list, N))
}

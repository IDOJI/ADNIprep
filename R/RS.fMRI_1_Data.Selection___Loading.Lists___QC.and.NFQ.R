RS.fMRI_1.2_Merging.Lists___QC.and.NFQ = function(QC.list, NFQ.df){
  #===========================================================================
  # Subjects' lists
  #===========================================================================
  QC_EPB.list = QC.list[[1]]
  QC_MT1.list = QC.list[[2]]



  #===========================================================================
  # NA NFQ
  #===========================================================================
  NA_NFQ.df = matrix(NA, ncol=ncol(NFQ.df)) %>% as.data.frame
  names(NA_NFQ.df) = names(NFQ.df)



  #===========================================================================
  # Binding NFQ & QC
  #===========================================================================
  RID = c()
  Binded.list = lapply(seq_along(QC_EPB.list), function(i, ...){
    ith_QC_EPB.df = QC_EPB.list[[i]]
    ith_RID = ith_QC_EPB.df$RID %>% as.numeric; RID <<- c(RID, ith_RID)
    ith_SERIES.DATE = ith_QC_EPB.df$SERIES_DATE

    ith_NFQ.df = NFQ.df %>% filter(RID == ith_RID & SCANDATE == ith_SERIES.DATE)

    if(nrow(ith_NFQ.df)==0){
      ith_NFQ.df = NA_NFQ.df
      ith_NFQ.df$RID = ith_RID
      ith_NFQ.df$SCANDATE = ith_SERIES.DATE
      ith_Merged.df = merge(ith_QC_EPB.df, ith_NFQ.df, by = "RID", all = T)
    }else{
      ith_Merged.df = merge(ith_QC_EPB.df, ith_NFQ.df, by = "RID", all = T)
    }

    ith_Merged.df = ith_Merged.df %>% relocate(starts_with("IMAGING.PROTOCOL___"), .after=last_col()) %>% relocate(starts_with("NFQ___"), .after=last_col()) %>% relocate(starts_with("QC_VAR"), .after=last_col()) %>% relocate(starts_with("QC_COMMENTS"), .after=last_col())


    return(ith_Merged.df)
  })
  names(Binded.list) = RID




  #===========================================================================
  # return
  #===========================================================================
  return(list(EPB.list = Binded.list,
              MT1.list = QC_MT1.list))
}
























RS.fMRI_1.2_Merging.Lists___QC.and.NFQ = function(Subjects.list){
  #===========================================================================
  # Subjects' lists
  #===========================================================================
  QC_EPB.list = Subjects.list[[1]][[1]]
  QC_MT1.list = Subjects.list[[1]][[2]]
  NFQ.df = Subjects.list[[2]]



  #===========================================================================
  # Filter NFQ by QC RIDs
  #===========================================================================
  RID_QC = names(QC_EPB.list)
  NFQ.df$RID = NFQ.df$RID %>% as.numeric %>% as.character
  RID_NFQ.df = NFQ.df %>% filter(RID %in% RID_QC)



  #===========================================================================
  # Filter NFQ by series dates
  #===========================================================================
  Dates_QC = sapply(QC_EPB.list, FUN=function(x){x$SERIES_DATE})
  Dates_NFQ.df = RID_NFQ.df %>% filter(SCANDATE %in% Dates_QC)




  #===========================================================================
  # binding
  #===========================================================================
  Dummy_NFQ.df = rep(NA, ncol(Dates_NFQ.df)) %>% matrix(nrow=1) %>% as.data.frame
  names(Dummy_NFQ.df) = names(Dates_NFQ.df)


  EPB_binded.list = lapply(QC_EPB.list, FUN=function(ith_QC_EPB, ...){
    # ith_QC_EPB = QC_EPB.list[[58]]
    # ith_QC_EPB = QC_EPB.list[[21]]

    # ith QC RID & Date
    ith_RID = ith_QC_EPB$RID
    ith_Date = ith_QC_EPB$SERIES_DATE

    # Select ith NFQ
    ith_NFQ.df = Dates_NFQ.df %>% filter(RID == ith_RID & SCANDATE == ith_Date)

    if(nrow(ith_NFQ.df)==0){
      ith_NFQ.df = Dummy_NFQ.df
    }

    ith_NFQ.df$RID = NULL
    ith_NFQ.df$SCANDATE = NULL

    cat("\n", crayon::yellow("RID :"), crayon::bgBlue(ith_RID),  crayon::yellow("is merged (QC + NFQ)"),"\n")
    dplyr::bind_cols(ith_QC_EPB, ith_NFQ.df) %>% as_tibble
  })

  #===========================================================================
  # return
  #===========================================================================
  return(list(EPB.list = EPB_binded.list,
              MT1.list = QC_MT1.list,
              Search = Subjects.list[[3]]))
}























